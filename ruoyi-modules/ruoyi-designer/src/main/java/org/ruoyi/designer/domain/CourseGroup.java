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
 * 院校课程体系对象 des_school_course_group
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "des_school_course_group", autoResultMap = true)
@Schema(description = "院校课程体系")
public class CourseGroup extends BaseEntity {

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
     * 课程组名称
     */
    @Schema(description = "课程组名称", example = "通识基础课程", requiredMode = Schema.RequiredMode.REQUIRED)
    private String name;

    /**
     * 课程列表
     */
    @Schema(description = "课程列表", example = "[\"设计素描\", \"色彩构成\", \"立体构成\", \"设计史论\"]")
    @com.baomidou.mybatisplus.annotation.TableField(value = "courses", typeHandler = JacksonTypeHandler.class)
    private List<String> courses;

    /**
     * 排除父类中不存在的字段
     * 因为 des_school_course_group 表中没有 create_dept 字段
     */
    @com.baomidou.mybatisplus.annotation.TableField(exist = false)
    private Long createDept;
} 