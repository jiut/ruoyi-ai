package org.ruoyi.system.domain.bo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.common.tenant.core.TenantEntity;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 视频信息BO对象 sys_video_info
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysVideoInfoBo extends TenantEntity {

    /**
     * 视频ID
     */
    @NotNull(message = "视频ID不能为空", groups = { EditGroup.class })
    private Long videoId;

    /**
     * 关联的OSS文件ID
     */
    @NotNull(message = "OSS文件ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long ossId;

    /**
     * 视频标题
     */
    @NotBlank(message = "视频标题不能为空", groups = { AddGroup.class, EditGroup.class })
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
     * 视频宽度（像素）
     */
    private Integer width;

    /**
     * 视频高度（像素）
     */
    private Integer height;

    /**
     * 视频大小（字节）
     */
    private Long fileSize;

    /**
     * 视频格式
     */
    private String format;

    /**
     * 缩略图URL
     */
    private String thumbnail;

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
} 