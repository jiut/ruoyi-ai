package org.ruoyi.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.common.core.validate.QueryGroup;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.system.domain.bo.SysVideoInfoBo;
import org.ruoyi.system.domain.vo.SysVideoInfoVo;
import org.ruoyi.system.service.ISysVideoInfoService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 视频管理控制器
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/video")
public class SysVideoController extends BaseController {

    private final ISysVideoInfoService videoInfoService;

    /**
     * 查询视频信息列表
     */
    @SaCheckPermission("system:video:list")
    @GetMapping("/list")
    public TableDataInfo<SysVideoInfoVo> list(@Validated(QueryGroup.class) SysVideoInfoBo bo, PageQuery pageQuery) {
        return videoInfoService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取视频信息详细信息
     */
    @SaCheckPermission("system:video:query")
    @GetMapping("/{videoId}")
    public R<SysVideoInfoVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long videoId) {
        return R.ok(videoInfoService.queryById(videoId));
    }

    /**
     * 新增视频信息
     */
    @SaCheckPermission("system:video:add")
    @Log(title = "视频信息", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody SysVideoInfoBo bo) {
        return toAjax(videoInfoService.insertByBo(bo));
    }

    /**
     * 修改视频信息
     */
    @SaCheckPermission("system:video:edit")
    @Log(title = "视频信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody SysVideoInfoBo bo) {
        return toAjax(videoInfoService.updateByBo(bo));
    }

    /**
     * 删除视频信息
     */
    @SaCheckPermission("system:video:remove")
    @Log(title = "视频信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{videoIds}")
    public R<Void> remove(@NotNull(message = "主键不能为空") @PathVariable Long[] videoIds) {
        return toAjax(videoInfoService.deleteWithValidByIds(List.of(videoIds), true));
    }

    /**
     * 获取视频播放URL
     */
    @GetMapping("/play/{videoId}")
    public R<String> getPlayUrl(@PathVariable Long videoId) {
        try {
            String playUrl = videoInfoService.getVideoPlayUrl(videoId);
            return R.ok(playUrl);
        } catch (Exception e) {
            return R.fail(e.getMessage());
        }
    }

    /**
     * 增加视频播放次数
     */
    @PostMapping("/play/count/{videoId}")
    public R<Void> incrementPlayCount(@PathVariable Long videoId) {
        return toAjax(videoInfoService.incrementPlayCount(videoId));
    }

    /**
     * 获取公开视频列表（无需权限）
     */
    @GetMapping("/public/list")
    public TableDataInfo<SysVideoInfoVo> getPublicVideoList(
            PageQuery pageQuery,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "keyword", required = false) String keyword) {
        return videoInfoService.queryPublicVideoList(pageQuery, category, keyword);
    }

    /**
     * 获取热门视频列表（无需权限）
     */
    @GetMapping("/public/hot")
    public R<List<SysVideoInfoVo>> getHotVideoList(
            @RequestParam(value = "limit", required = false, defaultValue = "10") Integer limit) {
        return R.ok(videoInfoService.queryHotVideoList(limit));
    }

    /**
     * 根据OSS ID查询视频信息
     */
    @SaCheckPermission("system:video:query")
    @GetMapping("/oss/{ossId}")
    public R<SysVideoInfoVo> getByOssId(@PathVariable Long ossId) {
        return R.ok(videoInfoService.queryByOssId(ossId));
    }
} 