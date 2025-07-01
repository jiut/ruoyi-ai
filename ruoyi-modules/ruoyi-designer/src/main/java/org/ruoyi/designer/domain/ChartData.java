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
import java.util.Map;

/**
 * 院校就业图表数据对象 des_school_chart_data
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "des_school_chart_data", autoResultMap = true)
@Schema(description = "院校就业图表数据")
public class ChartData extends BaseEntity {

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
     * 行业分布数据
     */
    @Schema(description = "行业分布数据")
    @com.baomidou.mybatisplus.annotation.TableField(value = "industry_data", typeHandler = JacksonTypeHandler.class)
    private List<Map<String, Object>> industryData;

    /**
     * 薪资分布数据
     */
    @Schema(description = "薪资分布数据")
    @com.baomidou.mybatisplus.annotation.TableField(value = "salary_data", typeHandler = JacksonTypeHandler.class)
    private List<Integer> salaryData;

    /**
     * 薪资区间标签
     */
    @Schema(description = "薪资区间标签")
    @com.baomidou.mybatisplus.annotation.TableField(value = "salary_labels", typeHandler = JacksonTypeHandler.class)
    private List<String> salaryLabels;

    /**
     * 排除父类中不存在的字段
     * 因为 des_school_chart_data 表中没有 create_dept 字段
     */
    @com.baomidou.mybatisplus.annotation.TableField(exist = false)
    private Long createDept;
} 