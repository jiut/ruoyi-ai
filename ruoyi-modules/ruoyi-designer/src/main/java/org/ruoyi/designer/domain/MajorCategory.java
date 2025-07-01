package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.util.List;

/**
 * 院校专业分类对象 des_school_major_category
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "des_school_major_category", autoResultMap = true)
@Schema(description = "院校专业分类")
public class MajorCategory extends BaseEntity {

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
    @com.baomidou.mybatisplus.annotation.TableField("school_id")
    private Long schoolId;

    /**
     * 专业名称
     */
    @Schema(description = "专业名称", example = "信息艺术设计", requiredMode = Schema.RequiredMode.REQUIRED)
    private String name;

    /**
     * 图标类名
     */
    @Schema(description = "图标类名", example = "ri-computer-line")
    private String icon;

    /**
     * 专业描述
     */
    @Schema(description = "专业描述", example = "结合清华理工科优势，培养具备信息可视化、人机交互等前沿设计能力的复合型人才。")
    private String description;

    /**
     * 技能列表
     */
    @Schema(description = "技能列表", example = "[\"信息可视化\", \"交互设计\", \"数据艺术\", \"智能界面设计\"]")
    @com.baomidou.mybatisplus.annotation.TableField(value = "skills", typeHandler = JacksonTypeHandler.class)
    private List<String> skills;

    /**
     * 排除父类中不存在的字段
     * 因为 des_school_major_category 表中没有 create_dept 字段
     */
    @com.baomidou.mybatisplus.annotation.TableField(exist = false)
    private Long createDept;
} 