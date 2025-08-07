package org.ruoyi.system.domain.vo;

import lombok.Data;
import java.util.Date;

/**
 * 视频信息VO对象 sys_video_info
 *
 * @author ruoyi
 */
@Data
public class SysVideoInfoVo {

    /**
     * 视频ID
     */
    private Long videoId;

    /**
     * 关联的OSS文件ID
     */
    private Long ossId;

    /**
     * 视频URL
     */
    private String videoUrl;

    /**
     * 视频标题
     */
    private String title;

    /**
     * 视频描述
     */
    private String description;

    /**
     * 视频时长（秒）
     */
    private Integer duration;

    /**
     * 格式化的时长显示（如：10:35）
     */
    private String durationDisplay;

    /**
     * 视频宽度（像素）
     */
    private Integer width;

    /**
     * 视频高度（像素）
     */
    private Integer height;

    /**
     * 分辨率显示（如：1920x1080）
     */
    private String resolution;

    /**
     * 视频大小（字节）
     */
    private Long fileSize;

    /**
     * 格式化的文件大小显示（如：125.6MB）
     */
    private String fileSizeDisplay;

    /**
     * 视频格式
     */
    private String format;

    /**
     * 缩略图URL
     */
    private String thumbnail;

    /**
     * 播放次数
     */
    private Long playCount;

    /**
     * 状态（0正常 1停用）
     */
    private String status;

    /**
     * 分类
     */
    private String category;

    /**
     * 标签（用逗号分隔）
     */
    private String tags;

    /**
     * 标签数组
     */
    private String[] tagArray;

    /**
     * 是否公开（0私有 1公开）
     */
    private String isPublic;

    /**
     * 上传者ID
     */
    private Long uploaderId;

    /**
     * 上传者名称
     */
    private String uploaderName;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;
} 