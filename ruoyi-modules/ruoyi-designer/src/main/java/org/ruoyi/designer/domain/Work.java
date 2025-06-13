package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 作品对象 des_work
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_work")
@Schema(description = "设计师作品信息")
public class Work extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 作品ID
     */
    @JsonIgnore
    @Schema(description = "作品ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "work_id")
    private Long workId;

    /**
     * 设计师ID
     */
    @Schema(description = "设计师ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long designerId;

    /**
     * 作品标题
     */
    @Schema(description = "作品标题", example = "移动应用UI设计", requiredMode = Schema.RequiredMode.REQUIRED)
    private String title;

    /**
     * 作品描述
     */
    @Schema(description = "作品描述", example = "这是一套现代化的移动应用界面设计，采用简洁的设计风格")
    private String description;

    /**
     * 作品类型（image/video）
     */
    @Schema(description = "作品类型", example = "image", 
            allowableValues = {"image", "video"},
            requiredMode = Schema.RequiredMode.REQUIRED)
    private String workType;

    /**
     * 文件URL
     */
    @Schema(description = "文件URL", example = "https://example.com/work/design.jpg",
            requiredMode = Schema.RequiredMode.REQUIRED)
    private String fileUrl;

    /**
     * 缩略图URL
     */
    @Schema(description = "缩略图URL", example = "https://example.com/work/design_thumb.jpg")
    private String thumbnailUrl;

    /**
     * 文件大小（字节）
     */
    @Schema(description = "文件大小（字节）", example = "2048576")
    private Long fileSize;

    /**
     * 作品标签（JSON数组格式）
     */
    @Schema(description = "作品标签，JSON数组格式", 
            example = "[\"UI设计\", \"移动应用\", \"用户体验\"]")
    private String tags;

    /**
     * 点赞数
     */
    @Schema(description = "点赞数", example = "128", accessMode = Schema.AccessMode.READ_ONLY)
    private Integer likeCount;

    /**
     * 浏览数
     */
    @Schema(description = "浏览数", example = "1024", accessMode = Schema.AccessMode.READ_ONLY)
    private Integer viewCount;

    /**
     * 是否为代表作品（0否 1是）
     */
    @Schema(description = "是否为代表作品", example = "0", allowableValues = {"0", "1"})
    private String isFeatured;

    /**
     * 状态（0正常 1停用）
     */
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;
} 