package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 院校师资统计对象 des_school_faculty_stats
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_school_faculty_stats")
@Schema(description = "院校师资统计")
public class FacultyStats extends BaseEntity {

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
     * 师资总数
     */
    @Schema(description = "师资总数", example = "68")
    private Integer totalFaculty;

    /**
     * 教授人数
     */
    @Schema(description = "教授人数", example = "42")
    private Integer professors;

    /**
     * 博士学位人数
     */
    @Schema(description = "博士学位人数", example = "53")
    private Integer doctorDegree;

    /**
     * 海外背景人数
     */
    @Schema(description = "海外背景人数", example = "35")
    private Integer overseasBackground;

    /**
     * 师资描述
     */
    @Schema(description = "师资描述")
    private String description;

    /**
     * 排除父类中不存在的字段
     * 因为 des_school_faculty_stats 表中没有 create_dept 字段
     */
    @com.baomidou.mybatisplus.annotation.TableField(exist = false)
    private Long createDept;
} 