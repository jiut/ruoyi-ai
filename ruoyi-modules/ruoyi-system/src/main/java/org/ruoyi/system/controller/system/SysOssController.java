package org.ruoyi.system.controller.system;


import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ObjectUtil;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.annotation.FileSizeLimit;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.utils.file.FileSizeLimitUtils;
import org.ruoyi.common.core.utils.file.FileUtils;
import org.ruoyi.common.core.utils.file.MimeTypeUtils;
import org.ruoyi.common.core.validate.QueryGroup;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.system.domain.bo.SysOssBo;
import org.ruoyi.system.domain.vo.SysOssUploadVo;
import org.ruoyi.system.domain.vo.SysOssVo;
import org.ruoyi.system.domain.vo.SysVideoUploadVo;
import org.ruoyi.system.service.ISysOssService;
import org.ruoyi.system.service.ISysVideoInfoService;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 文件上传 控制层
 *
 * @author Lion Li
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/resource/oss")
public class SysOssController extends BaseController {

    private final ISysOssService ossService;
    private final ISysVideoInfoService videoInfoService;

    /**
     * 查询OSS对象存储列表
     */
    @SaCheckPermission("system:oss:list")
    @GetMapping("/list")
    public TableDataInfo<SysOssVo> list(@Validated(QueryGroup.class) SysOssBo bo, PageQuery pageQuery) {
        return ossService.queryPageList(bo, pageQuery);
    }

    /**
     * 查询OSS对象基于id串
     *
     * @param ossIds OSS对象ID串
     */
    @SaCheckPermission("system:oss:list")
    @GetMapping("/listByIds/{ossIds}")
    public R<List<SysOssVo>> listByIds(@NotEmpty(message = "主键不能为空")
                                       @PathVariable Long[] ossIds) {
        List<SysOssVo> list = ossService.listByIds(Arrays.asList(ossIds));
        return R.ok(list);
    }

    /**
     * 上传OSS对象存储
     *
     * @param file 文件
     */
    @SaCheckPermission("system:oss:upload")
    @Log(title = "OSS对象存储", businessType = BusinessType.INSERT)
    @FileSizeLimit(maxSizeMB = 50, message = "普通文件最大支持50MB")
    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<SysOssUploadVo> upload(@RequestPart("file") MultipartFile file) {
        if (ObjectUtil.isNull(file)) {
            return R.fail("上传文件不能为空");
        }
        SysOssVo oss = ossService.upload(file);
        SysOssUploadVo uploadVo = new SysOssUploadVo();
        uploadVo.setUrl(oss.getUrl());
        uploadVo.setFileName(oss.getOriginalName());
        uploadVo.setOssId(oss.getOssId().toString());
        return R.ok(uploadVo);
    }

    /**
     * 上传视频文件
     *
     * @param file 视频文件
     * @param title 视频标题
     * @param description 视频描述
     * @param category 视频分类
     * @param tags 视频标签
     * @param isPublic 是否公开 (0私有 1公开)
     */
    @SaCheckPermission("system:oss:upload:video")
    @Log(title = "视频文件上传", businessType = BusinessType.INSERT)
    @FileSizeLimit(maxSizeMB = 500, message = "视频文件最大支持500MB")
    @PostMapping(value = "/upload/video", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<SysVideoUploadVo> uploadVideo(
            @RequestPart("file") MultipartFile file,
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "tags", required = false) String tags,
            @RequestParam(value = "isPublic", required = false, defaultValue = "1") String isPublic) {
        
        if (ObjectUtil.isNull(file)) {
            return R.fail("上传文件不能为空");
        }
        
        // 验证是否为视频文件
        if (!FileUtils.isValidFileExtention(file, MimeTypeUtils.ALL_VIDEO_EXTENSION)) {
            return R.fail("仅支持视频文件格式：" + String.join(", ", MimeTypeUtils.ALL_VIDEO_EXTENSION));
        }
        
        try {
            SysVideoUploadVo result = videoInfoService.uploadVideo(file, title, description, category, tags, isPublic);
            return R.ok(result);
        } catch (Exception e) {
            return R.fail("视频上传失败：" + e.getMessage());
        }
    }

    /**
     * 上传图片文件
     *
     * @param file 图片文件
     */
    @SaCheckPermission("system:oss:upload:image")
    @Log(title = "图片文件上传", businessType = BusinessType.INSERT)
    @FileSizeLimit(maxSizeMB = 10, message = "图片文件最大支持10MB")
    @PostMapping(value = "/upload/image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<SysOssUploadVo> uploadImage(@RequestPart("file") MultipartFile file) {
        if (ObjectUtil.isNull(file)) {
            return R.fail("上传文件不能为空");
        }
        
        // 验证是否为图片文件
        if (!FileUtils.isValidFileExtention(file, MimeTypeUtils.IMAGE_EXTENSION)) {
            return R.fail("仅支持图片文件格式：" + String.join(", ", MimeTypeUtils.IMAGE_EXTENSION));
        }
        
        SysOssVo oss = ossService.upload(file);
        SysOssUploadVo uploadVo = new SysOssUploadVo();
        uploadVo.setUrl(oss.getUrl());
        uploadVo.setFileName(oss.getOriginalName());
        uploadVo.setOssId(oss.getOssId().toString());
        return R.ok(uploadVo);
    }

    /**
     * 上传文档文件
     *
     * @param file 文档文件
     */
    @SaCheckPermission("system:oss:upload:document")
    @Log(title = "文档文件上传", businessType = BusinessType.INSERT)
    @FileSizeLimit(maxSizeMB = 100, message = "文档文件最大支持100MB")
    @PostMapping(value = "/upload/document", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<SysOssUploadVo> uploadDocument(@RequestPart("file") MultipartFile file) {
        if (ObjectUtil.isNull(file)) {
            return R.fail("上传文件不能为空");
        }
        
        SysOssVo oss = ossService.upload(file);
        SysOssUploadVo uploadVo = new SysOssUploadVo();
        uploadVo.setUrl(oss.getUrl());
        uploadVo.setFileName(oss.getOriginalName());
        uploadVo.setOssId(oss.getOssId().toString());
        return R.ok(uploadVo);
    }

    /**
     * 批量上传文件（智能识别文件类型限制）
     *
     * @param files 文件数组
     */
    @SaCheckPermission("system:oss:upload:batch")
    @Log(title = "批量文件上传", businessType = BusinessType.INSERT)
    @PostMapping(value = "/upload/batch", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<List<SysOssUploadVo>> uploadBatch(@RequestPart("files") MultipartFile[] files) {
        if (ObjectUtil.isNull(files) || files.length == 0) {
            return R.fail("上传文件不能为空");
        }
        
        // 智能验证每个文件的大小（根据文件类型自动判断）
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String validationResult = FileSizeLimitUtils.validateFileSizeSmartly(file);
                if (validationResult != null) {
                    return R.fail(validationResult);
                }
            }
        }
        
        List<SysOssUploadVo> results = new ArrayList<>();
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                SysOssVo oss = ossService.upload(file);
                SysOssUploadVo uploadVo = new SysOssUploadVo();
                uploadVo.setUrl(oss.getUrl());
                uploadVo.setFileName(oss.getOriginalName());
                uploadVo.setOssId(oss.getOssId().toString());
                results.add(uploadVo);
            }
        }
        
        return R.ok(results);
    }

    /**
     * 下载OSS对象
     *
     * @param ossId OSS对象ID
     */
    @SaCheckPermission("system:oss:download")
    @GetMapping("/download/{ossId}")
    public void download(@PathVariable Long ossId, HttpServletResponse response) throws IOException {
        ossService.download(ossId, response);
    }

    /**
     * 删除OSS对象存储
     *
     * @param ossIds OSS对象ID串
     */
    @SaCheckPermission("system:oss:remove")
    @Log(title = "OSS对象存储", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ossIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ossIds) {
        return toAjax(ossService.deleteWithValidByIds(List.of(ossIds), true));
    }

}
