package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.util.List;
import java.util.Map;

/**
 * 院校卡片统计数据对象 des_school_card_stats
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "des_school_card_stats", autoResultMap = true)
@Schema(description = "院校卡片统计数据")
public class SchoolCardStats extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @Schema(description = "主键ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 院校ID
     */
    @Schema(description = "院校ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    @TableField("school_id")
    private Long schoolId;

    /**
     * 就业率数组
     */
    @Schema(description = "就业率数组", example = "[\"96.8%\", \"95.2%\", \"97.1%\", \"94.6%\", \"96.3%\", \"95.8%\", \"97.5%\", \"94.9%\"]")
    @TableField(value = "employment_rates", typeHandler = JacksonTypeHandler.class)
    private List<String> employmentRates;

    /**
     * 师资力量评分数组
     */
    @Schema(description = "师资力量评分数组", example = "[\"5.0\", \"4.8\", \"4.9\", \"4.7\", \"4.8\", \"4.6\", \"4.5\", \"4.4\"]")
    @TableField(value = "faculty_strengths", typeHandler = JacksonTypeHandler.class)
    private List<String> facultyStrengths;

    /**
     * 学生评分数组
     */
    @Schema(description = "学生评分数组", example = "[\"4.9\", \"4.7\", \"4.8\", \"4.6\", \"4.7\", \"4.5\", \"4.4\", \"4.3\"]")
    @TableField(value = "student_scores", typeHandler = JacksonTypeHandler.class)
    private List<String> studentScores;

    /**
     * 优势专业列表
     */
    @Schema(description = "优势专业列表", example = "[\"信息艺术设计\", \"智能产品设计\", \"交互设计\"]")
    @TableField(value = "advantage_programs", typeHandler = JacksonTypeHandler.class)
    private List<String> advantagePrograms;

    /**
     * 排除父类中不存在的字段
     * 因为 des_school_card_stats 表中没有 create_dept 字段
     */
    @TableField(exist = false)
    private Long createDept;
} 