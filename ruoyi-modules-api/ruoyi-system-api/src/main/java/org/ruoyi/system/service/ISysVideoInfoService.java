package org.ruoyi.system.service;

import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.system.domain.bo.SysVideoInfoBo;
import org.ruoyi.system.domain.vo.SysVideoInfoVo;
import org.ruoyi.system.domain.vo.SysVideoUploadVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collection;
import java.util.List;

/**
 * 视频信息Service接口
 *
 * @author ruoyi
 */
public interface ISysVideoInfoService {

    /**
     * 查询视频信息
     */
    SysVideoInfoVo queryById(Long videoId);

    /**
     * 查询视频信息列表
     */
    TableDataInfo<SysVideoInfoVo> queryPageList(SysVideoInfoBo bo, PageQuery pageQuery);

    /**
     * 查询视频信息列表
     */
    List<SysVideoInfoVo> queryList(SysVideoInfoBo bo);

    /**
     * 新增视频信息
     */
    Boolean insertByBo(SysVideoInfoBo bo);

    /**
     * 修改视频信息
     */
    Boolean updateByBo(SysVideoInfoBo bo);

    /**
     * 校验并批量删除视频信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 上传视频文件
     *
     * @param file 视频文件
     * @param title 视频标题
     * @param description 视频描述
     * @param category 视频分类
     * @param tags 视频标签
     * @param isPublic 是否公开
     * @return 上传结果
     */
    SysVideoUploadVo uploadVideo(MultipartFile file, String title, String description, 
                                String category, String tags, String isPublic);

    /**
     * 根据OSS ID查询视频信息
     */
    SysVideoInfoVo queryByOssId(Long ossId);

    /**
     * 增加播放次数
     */
    Boolean incrementPlayCount(Long videoId);

    /**
     * 获取视频播放URL
     */
    String getVideoPlayUrl(Long videoId);

    /**
     * 获取公开视频列表
     */
    TableDataInfo<SysVideoInfoVo> queryPublicVideoList(PageQuery pageQuery, String category, String keyword);

    /**
     * 获取热门视频列表
     */
    List<SysVideoInfoVo> queryHotVideoList(Integer limit);
} 