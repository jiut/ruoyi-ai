package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Min;
import java.io.Serial;

/**
 * 院校对象 des_school
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_school")
@Schema(description = "院校信息")
public class School extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 院校ID
     */
    @JsonProperty("id")
    @Schema(description = "院校ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "school_id")
    private Long schoolId;

    /**
     * 关联用户ID
     */
    @JsonIgnore
    @Schema(description = "关联用户ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    private Long userId;

    /**
     * 院校名称
     */
    @NotBlank(message = "院校名称不能为空")
    @Schema(description = "院校名称", example = "北京设计学院", requiredMode = Schema.RequiredMode.REQUIRED)
    private String schoolName;

    /**
     * 院校简介
     */
    @Schema(description = "院校简介", example = "专业的设计教育机构，致力于培养优秀的设计人才")
    private String description;

    /**
     * 院校地址
     */
    @Schema(description = "院校地址", example = "北京市海淀区")
    private String address;

    /**
     * 联系电话
     */
    @Pattern(regexp = "^(0\\d{2,3}-?\\d{7,8}|1[3-9]\\d{9})$", message = "联系电话格式不正确")
    @Schema(description = "联系电话", example = "010-12345678")
    private String phone;

    /**
     * 联系邮箱
     */
    @Email(message = "邮箱格式不正确")
    @Schema(description = "联系邮箱", example = "contact@school.edu.cn")
    private String email;

    /**
     * 院校网站
     */
    @Pattern(regexp = "^https?://[\\w\\-]+(\\.[\\w\\-]+)+([\\w\\-\\.,@?^=%&:/~\\+#]*[\\w\\-\\@?^=%&/~\\+#])?$", 
             message = "网站地址格式不正确")
    @Schema(description = "院校网站", example = "https://www.school.edu.cn")
    private String website;

    /**
     * 院校类型
     */
    @Pattern(regexp = "^(COMPREHENSIVE|ART|ENGINEERING|NORMAL|FINANCE)$", 
             message = "院校类型不在允许的范围内")
    @Schema(description = "院校类型", example = "COMPREHENSIVE",
            allowableValues = {"COMPREHENSIVE", "ART", "ENGINEERING", "NORMAL", "FINANCE"})
    private String schoolType;

    /**
     * 院校等级
     */
    @Pattern(regexp = "^(UNDERGRADUATE|GRADUATE|VOCATIONAL)$", 
             message = "院校等级不在允许的范围内")
    @Schema(description = "院校等级", example = "UNDERGRADUATE",
            allowableValues = {"UNDERGRADUATE", "GRADUATE", "VOCATIONAL"})
    private String level;

    /**
     * 院校LOGO
     */
    @Schema(description = "院校LOGO链接", example = "https://www.school.edu.cn/logo.png")
    private String logo;

    /**
     * 状态（0正常 1停用）
     */
    @Pattern(regexp = "^[01]$", message = "状态值必须为0或1")
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;

    /**
     * 省份
     */
    @Schema(description = "省份", example = "北京市")
    private String province;

    /**
     * 城市
     */
    @Schema(description = "城市", example = "海淀区")
    private String city;

    /**
     * 完整地址位置描述
     */
    @Schema(description = "完整地址位置描述", example = "北京市海淀区")
    private String location;

    /**
     * 院校排名
     */
    @Min(value = 1, message = "院校排名必须大于0")
    @Schema(description = "院校排名", example = "1")
    private Integer ranking;

    /**
     * 学生总数
     */
    @Min(value = 0, message = "学生总数不能小于0")
    @Schema(description = "学生总数", example = "30000")
    private Integer totalStudents;

    /**
     * 教师总数
     */
    @Min(value = 0, message = "教师总数不能小于0")
    @Schema(description = "教师总数", example = "2000")
    private Integer totalTeachers;

    /**
     * 院系数量
     */
    @Min(value = 0, message = "院系数量不能小于0")
    @Schema(description = "院系数量", example = "20")
    private Integer facultyCount;

    /**
     * 专业数量
     */
    @Min(value = 0, message = "专业数量不能小于0")
    @Schema(description = "专业数量", example = "80")
    private Integer majorCount;

    /**
     * 是否重点院校
     */
    @Schema(description = "是否重点院校", example = "true")
    private Boolean isKey;

    /**
     * 是否985院校
     */
    @Schema(description = "是否985院校", example = "true")
    @TableField("is_985")
    private Boolean is985;

    /**
     * 是否211院校
     */
    @Schema(description = "是否211院校", example = "true")
    @TableField("is_211")
    private Boolean is211;

    /**
     * 是否双一流院校
     */
    @Schema(description = "是否双一流院校", example = "true")
    @TableField("is_double_first")
    private Boolean isDoubleFirst;

    // ============ 卡片统计数据字段（非数据库字段，用于前端卡片展示） ============
    
    /**
     * 就业率（用于卡片显示）
     */
    @Schema(description = "就业率", example = "96.8%", accessMode = Schema.AccessMode.READ_ONLY)
    @TableField(exist = false)
    private String employmentRate;

    /**
     * 师资力量评分（用于卡片显示）
     */
    @Schema(description = "师资力量评分", example = "5.0", accessMode = Schema.AccessMode.READ_ONLY)
    @TableField(exist = false)
    private String facultyStrength;

    /**
     * 学生评分（用于卡片显示）
     */
    @Schema(description = "学生评分", example = "4.9", accessMode = Schema.AccessMode.READ_ONLY)
    @TableField(exist = false)
    private String studentScore;

    /**
     * 优势专业（用于卡片显示）
     */
    @Schema(description = "优势专业", example = "信息艺术设计、智能产品设计、交互设计", accessMode = Schema.AccessMode.READ_ONLY)
    @TableField(exist = false)
    private String advantagePrograms;
} 