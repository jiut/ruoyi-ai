package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 院校就业统计对象 des_school_employment_stats
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_school_employment_stats")
@Schema(description = "院校就业统计")
public class EmploymentStats extends BaseEntity {

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
     * 就业率
     */
    @Schema(description = "就业率", example = "96.8%")
    private String employmentRate;

    /**
     * 平均薪资
     */
    @Schema(description = "平均薪资", example = "18.5K")
    private String averageSalary;

    /**
     * 深造率
     */
    @Schema(description = "深造率", example = "38.2%")
    private String furtherStudyRate;

    /**
     * 海外就业率
     */
    @Schema(description = "海外就业率", example = "22.1%")
    private String overseasEmploymentRate;

    /**
     * 就业描述
     */
    @Schema(description = "就业描述")
    private String description;
} 