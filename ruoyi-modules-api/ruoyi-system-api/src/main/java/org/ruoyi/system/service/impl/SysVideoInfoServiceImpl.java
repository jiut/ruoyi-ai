package org.ruoyi.system.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.exception.ServiceException;
import org.ruoyi.common.core.utils.MapstructUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.core.utils.file.FileUtils;
import org.ruoyi.common.core.utils.file.MimeTypeUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.system.domain.SysVideoInfo;
import org.ruoyi.system.domain.bo.SysVideoInfoBo;
import org.ruoyi.system.domain.vo.SysOssVo;
import org.ruoyi.system.domain.vo.SysVideoInfoVo;
import org.ruoyi.system.domain.vo.SysVideoUploadVo;
import org.ruoyi.system.mapper.SysVideoInfoMapper;
import org.ruoyi.system.service.ISysOssService;
import org.ruoyi.system.service.ISysVideoInfoService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collection;
import java.util.List;

/**
 * 视频信息Service业务层处理
 *
 * @author ruoyi
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class SysVideoInfoServiceImpl implements ISysVideoInfoService {

    private final SysVideoInfoMapper baseMapper;
    private final ISysOssService ossService;

    /**
     * 查询视频信息
     */
    @Override
    public SysVideoInfoVo queryById(Long videoId) {
        SysVideoInfoVo vo = baseMapper.selectVoById(videoId);
        if (vo != null) {
            // 格式化显示信息
            formatVideoInfo(vo);
        }
        return vo;
    }

    /**
     * 查询视频信息列表
     */
    @Override
    public TableDataInfo<SysVideoInfoVo> queryPageList(SysVideoInfoBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<SysVideoInfo> lqw = buildQueryWrapper(bo);
        Page<SysVideoInfoVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        // 格式化显示信息
        result.getRecords().forEach(this::formatVideoInfo);
        return TableDataInfo.build(result);
    }

    /**
     * 查询视频信息列表
     */
    @Override
    public List<SysVideoInfoVo> queryList(SysVideoInfoBo bo) {
        LambdaQueryWrapper<SysVideoInfo> lqw = buildQueryWrapper(bo);
        List<SysVideoInfoVo> list = baseMapper.selectVoList(lqw);
        // 格式化显示信息
        list.forEach(this::formatVideoInfo);
        return list;
    }

    private LambdaQueryWrapper<SysVideoInfo> buildQueryWrapper(SysVideoInfoBo bo) {
        LambdaQueryWrapper<SysVideoInfo> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getVideoId() != null, SysVideoInfo::getVideoId, bo.getVideoId());
        lqw.eq(bo.getOssId() != null, SysVideoInfo::getOssId, bo.getOssId());
        lqw.like(StringUtils.isNotBlank(bo.getTitle()), SysVideoInfo::getTitle, bo.getTitle());
        lqw.like(StringUtils.isNotBlank(bo.getDescription()), SysVideoInfo::getDescription, bo.getDescription());
        lqw.eq(StringUtils.isNotBlank(bo.getFormat()), SysVideoInfo::getFormat, bo.getFormat());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), SysVideoInfo::getStatus, bo.getStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getCategory()), SysVideoInfo::getCategory, bo.getCategory());
        lqw.eq(StringUtils.isNotBlank(bo.getIsPublic()), SysVideoInfo::getIsPublic, bo.getIsPublic());
        lqw.eq(bo.getUploaderId() != null, SysVideoInfo::getUploaderId, bo.getUploaderId());
        lqw.orderByDesc(SysVideoInfo::getCreateTime);
        return lqw;
    }

    /**
     * 新增视频信息
     */
    @Override
    public Boolean insertByBo(SysVideoInfoBo bo) {
        SysVideoInfo add = MapstructUtils.convert(bo, SysVideoInfo.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setVideoId(add.getVideoId());
        }
        return flag;
    }

    /**
     * 修改视频信息
     */
    @Override
    public Boolean updateByBo(SysVideoInfoBo bo) {
        SysVideoInfo update = MapstructUtils.convert(bo, SysVideoInfo.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(SysVideoInfo entity) {
        // 可以添加自定义校验逻辑
    }

    /**
     * 批量删除视频信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 做一些业务上的校验,判断是否需要校验
        }
        // 查询视频信息，删除关联的OSS文件
        List<SysVideoInfo> videoList = baseMapper.selectBatchIds(ids);
        for (SysVideoInfo video : videoList) {
            if (video.getOssId() != null) {
                // 删除OSS文件
                ossService.deleteWithValidByIds(List.of(video.getOssId()), false);
            }
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    /**
     * 上传视频文件
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public SysVideoUploadVo uploadVideo(MultipartFile file, String title, String description,
                                       String category, String tags, String isPublic) {
        if (ObjectUtil.isNull(file)) {
            throw new ServiceException("上传文件不能为空");
        }

        // 验证文件类型
        if (!FileUtils.isValidFileExtention(file, MimeTypeUtils.ALL_VIDEO_EXTENSION)) {
            throw new ServiceException("不支持的视频文件格式");
        }

        try {
            // 上传到OSS
            SysOssVo ossVo = ossService.upload(file);

            // 创建视频信息
            SysVideoInfo videoInfo = new SysVideoInfo();
            videoInfo.setOssId(ossVo.getOssId());
            videoInfo.setTitle(StringUtils.isNotBlank(title) ? title : file.getOriginalFilename());
            videoInfo.setDescription(description);
            videoInfo.setFormat(getFileExtension(file.getOriginalFilename()));
            videoInfo.setFileSize(file.getSize());
            videoInfo.setStatus("0"); // 正常状态
            videoInfo.setCategory(category);
            videoInfo.setTags(tags);
            videoInfo.setIsPublic(StringUtils.isNotBlank(isPublic) ? isPublic : "1"); // 默认公开
            videoInfo.setPlayCount(0L);
            
            // 设置上传者信息
            try {
                Long userId = LoginHelper.getUserId();
                String username = LoginHelper.getUsername();
                videoInfo.setUploaderId(userId);
                videoInfo.setUploaderName(username);
            } catch (Exception e) {
                log.warn("获取用户信息失败，使用默认值", e);
                videoInfo.setUploaderId(1L);
                videoInfo.setUploaderName("系统");
            }

            // 保存视频信息
            baseMapper.insert(videoInfo);

            // 构造返回结果
            SysVideoUploadVo result = new SysVideoUploadVo();
            result.setOssId(ossVo.getOssId().toString());
            result.setVideoId(videoInfo.getVideoId().toString());
            result.setUrl(ossVo.getUrl());
            result.setFileName(ossVo.getOriginalName());
            result.setTitle(videoInfo.getTitle());
            result.setFileSize(file.getSize());
            result.setFormat(videoInfo.getFormat());
            result.setMessage("视频上传成功");

            return result;
        } catch (Exception e) {
            log.error("视频上传失败", e);
            throw new ServiceException("视频上传失败：" + e.getMessage());
        }
    }

    /**
     * 根据OSS ID查询视频信息
     */
    @Override
    public SysVideoInfoVo queryByOssId(Long ossId) {
        LambdaQueryWrapper<SysVideoInfo> lqw = Wrappers.lambdaQuery();
        lqw.eq(SysVideoInfo::getOssId, ossId);
        SysVideoInfoVo vo = baseMapper.selectVoOne(lqw);
        if (vo != null) {
            formatVideoInfo(vo);
        }
        return vo;
    }

    /**
     * 增加播放次数
     */
    @Override
    public Boolean incrementPlayCount(Long videoId) {
        LambdaUpdateWrapper<SysVideoInfo> updateWrapper = Wrappers.lambdaUpdate();
        updateWrapper.eq(SysVideoInfo::getVideoId, videoId)
                   .setSql("play_count = play_count + 1");
        return baseMapper.update(null, updateWrapper) > 0;
    }

    /**
     * 获取视频播放URL
     */
    @Override
    public String getVideoPlayUrl(Long videoId) {
        SysVideoInfo videoInfo = baseMapper.selectById(videoId);
        if (videoInfo == null || videoInfo.getOssId() == null) {
            throw new ServiceException("视频不存在");
        }
        
        SysOssVo ossVo = ossService.getById(videoInfo.getOssId());
        if (ossVo == null) {
            throw new ServiceException("视频文件不存在");
        }
        
        // 增加播放次数
        incrementPlayCount(videoId);
        
        return ossVo.getUrl();
    }

    /**
     * 获取公开视频列表
     */
    @Override
    public TableDataInfo<SysVideoInfoVo> queryPublicVideoList(PageQuery pageQuery, String category, String keyword) {
        LambdaQueryWrapper<SysVideoInfo> lqw = Wrappers.lambdaQuery();
        lqw.eq(SysVideoInfo::getIsPublic, "1"); // 公开视频
        lqw.eq(SysVideoInfo::getStatus, "0"); // 正常状态
        lqw.eq(StringUtils.isNotBlank(category), SysVideoInfo::getCategory, category);
        lqw.and(StringUtils.isNotBlank(keyword), wrapper -> 
            wrapper.like(SysVideoInfo::getTitle, keyword)
                   .or()
                   .like(SysVideoInfo::getDescription, keyword)
                   .or()
                   .like(SysVideoInfo::getTags, keyword)
        );
        lqw.orderByDesc(SysVideoInfo::getCreateTime);
        
        Page<SysVideoInfoVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        result.getRecords().forEach(this::formatVideoInfo);
        return TableDataInfo.build(result);
    }

    /**
     * 获取热门视频列表
     */
    @Override
    public List<SysVideoInfoVo> queryHotVideoList(Integer limit) {
        LambdaQueryWrapper<SysVideoInfo> lqw = Wrappers.lambdaQuery();
        lqw.eq(SysVideoInfo::getIsPublic, "1"); // 公开视频
        lqw.eq(SysVideoInfo::getStatus, "0"); // 正常状态
        lqw.orderByDesc(SysVideoInfo::getPlayCount); // 按播放次数排序
        lqw.last("LIMIT " + (limit != null ? limit : 10));
        
        List<SysVideoInfoVo> list = baseMapper.selectVoList(lqw);
        list.forEach(this::formatVideoInfo);
        return list;
    }

    /**
     * 格式化视频信息显示
     */
    private void formatVideoInfo(SysVideoInfoVo vo) {
        if (vo == null) {
            return;
        }
        
        // 格式化时长显示
        if (vo.getDuration() != null && vo.getDuration() > 0) {
            int minutes = vo.getDuration() / 60;
            int seconds = vo.getDuration() % 60;
            vo.setDurationDisplay(String.format("%02d:%02d", minutes, seconds));
        }
        
        // 格式化分辨率显示
        if (vo.getWidth() != null && vo.getHeight() != null) {
            vo.setResolution(vo.getWidth() + "x" + vo.getHeight());
        }
        
        // 格式化文件大小显示
        if (vo.getFileSize() != null) {
            vo.setFileSizeDisplay(formatFileSize(vo.getFileSize()));
        }
        
        // 处理标签
        if (StringUtils.isNotBlank(vo.getTags())) {
            vo.setTagArray(vo.getTags().split(","));
        }
        
        // 获取视频URL
        if (vo.getOssId() != null) {
            try {
                SysOssVo ossVo = ossService.getById(vo.getOssId());
                if (ossVo != null) {
                    vo.setVideoUrl(ossVo.getUrl());
                }
            } catch (Exception e) {
                log.warn("获取视频URL失败", e);
            }
        }
    }

    /**
     * 格式化文件大小
     */
    private String formatFileSize(Long fileSize) {
        if (fileSize == null || fileSize <= 0) {
            return "0B";
        }
        
        final String[] units = {"B", "KB", "MB", "GB", "TB"};
        int digitGroups = (int) (Math.log10(fileSize) / Math.log10(1024));
        return String.format("%.1f %s", fileSize / Math.pow(1024, digitGroups), units[digitGroups]);
    }

    /**
     * 获取文件扩展名
     */
    private String getFileExtension(String filename) {
        if (StrUtil.isBlank(filename)) {
            return "";
        }
        int lastDotIndex = filename.lastIndexOf(".");
        if (lastDotIndex == -1) {
            return "";
        }
        return filename.substring(lastDotIndex + 1).toLowerCase();
    }
} 