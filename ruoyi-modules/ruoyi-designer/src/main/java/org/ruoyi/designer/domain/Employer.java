package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 院校代表性雇主对象 des_school_employer
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_school_employer")
@Schema(description = "院校代表性雇主")
public class Employer extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @Schema(description = "主键ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "id")
    private Long id;

    /**
     * 院校ID
     */
    @Schema(description = "院校ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long schoolId;

    /**
     * 雇主名称
     */
    @Schema(description = "雇主名称", example = "苹果", requiredMode = Schema.RequiredMode.REQUIRED)
    private String name;

    /**
     * 行业类型
     */
    @Schema(description = "行业类型", example = "国际科技")
    private String industry;
} 