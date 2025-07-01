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
 * 院校获奖趋势数据对象 des_school_trend_data
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "des_school_trend_data", autoResultMap = true)
@Schema(description = "院校获奖趋势数据")
public class TrendData extends BaseEntity {

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
     * 年份数组
     */
    @Schema(description = "年份数组", example = "[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]")
    @com.baomidou.mybatisplus.annotation.TableField(value = "years", typeHandler = JacksonTypeHandler.class)
    private List<String> years;

    /**
     * 国际奖项数据
     */
    @Schema(description = "国际奖项数据", example = "[18, 22, 26, 28, 25, 27]")
    @com.baomidou.mybatisplus.annotation.TableField(value = "international_data", typeHandler = JacksonTypeHandler.class)
    private List<Integer> internationalData;

    /**
     * 国家级奖项数据
     */
    @Schema(description = "国家级奖项数据", example = "[45, 48, 52, 56, 53, 57]")
    @com.baomidou.mybatisplus.annotation.TableField(value = "national_data", typeHandler = JacksonTypeHandler.class)
    private List<Integer> nationalData;

    /**
     * 省级奖项数据
     */
    @Schema(description = "省级奖项数据", example = "[72, 78, 84, 82, 78, 85]")
    @com.baomidou.mybatisplus.annotation.TableField(value = "provincial_data", typeHandler = JacksonTypeHandler.class)
    private List<Integer> provincialData;

    /**
     * 排除父类中不存在的字段
     * 因为 des_school_trend_data 表中没有 create_dept 字段
     */
    @com.baomidou.mybatisplus.annotation.TableField(exist = false)
    private Long createDept;
} 