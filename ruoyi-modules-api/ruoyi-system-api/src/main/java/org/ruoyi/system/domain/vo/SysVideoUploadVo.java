package org.ruoyi.system.domain.vo;

import lombok.Data;

/**
 * 视频上传返回对象
 *
 * @author ruoyi
 */
@Data
public class SysVideoUploadVo {

    /**
     * OSS文件ID
     */
    private String ossId;

    /**
     * 视频ID
     */
    private String videoId;

    /**
     * 视频访问URL
     */
    private String url;

    /**
     * 原始文件名
     */
    private String fileName;

    /**
     * 视频标题
     */
    private String title;

    /**
     * 文件大小
     */
    private Long fileSize;

    /**
     * 视频格式
     */
    private String format;

    /**
     * 上传状态消息
     */
    private String message;
} 