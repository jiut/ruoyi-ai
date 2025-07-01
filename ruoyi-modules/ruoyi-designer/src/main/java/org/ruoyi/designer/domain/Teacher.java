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
 * 院校代表性教师对象 des_school_teacher
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "des_school_teacher", autoResultMap = true)
@Schema(description = "院校代表性教师")
public class Teacher extends BaseEntity {

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
     * 教师姓名
     */
    @Schema(description = "教师姓名", example = "张松鹤", requiredMode = Schema.RequiredMode.REQUIRED)
    private String name;

    /**
     * 职称
     */
    @Schema(description = "职称", example = "教授 / 博士生导师")
    private String title;

    /**
     * 专业领域
     */
    @Schema(description = "专业领域", example = "[\"信息设计\", \"交互设计\"]")
    @com.baomidou.mybatisplus.annotation.TableField(value = "expertise", typeHandler = JacksonTypeHandler.class)
    private List<String> expertise;

    /**
     * 教师描述
     */
    @Schema(description = "教师描述", example = "前苹果公司首席设计师，在人机交互和信息可视化领域具有重要贡献")
    private String description;

    /**
     * 排除父类中不存在的字段
     * 因为 des_school_teacher 表中没有 create_dept 字段
     */
    @com.baomidou.mybatisplus.annotation.TableField(exist = false)
    private Long createDept;
} 