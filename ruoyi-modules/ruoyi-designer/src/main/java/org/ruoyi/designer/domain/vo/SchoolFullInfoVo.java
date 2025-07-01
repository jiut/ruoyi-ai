package org.ruoyi.designer.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.ruoyi.designer.domain.*;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 院校完整信息VO
 *
 * @author ruoyi
 */
@Data
@Schema(description = "院校完整信息")
public class SchoolFullInfoVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 基础院校信息
     */
    @Schema(description = "基础院校信息")
    private School basicInfo;

    /**
     * 专业分类列表
     */
    @Schema(description = "专业分类列表")
    private List<MajorCategory> majorCategories;

    /**
     * 课程体系列表
     */
    @Schema(description = "课程体系列表")
    private List<CourseGroup> courseSystem;

    /**
     * 师资统计
     */
    @Schema(description = "师资统计")
    private FacultyStats facultyStats;

    /**
     * 代表性教师列表
     */
    @Schema(description = "代表性教师列表")
    private List<Teacher> facultyMembers;

    /**
     * 就业统计
     */
    @Schema(description = "就业统计")
    private EmploymentStats employmentStats;

    /**
     * 代表性雇主列表
     */
    @Schema(description = "代表性雇主列表")
    private List<Employer> employers;

    /**
     * 就业图表数据
     */
    @Schema(description = "就业图表数据")
    private ChartData employmentCharts;

    /**
     * 学生成果统计
     */
    @Schema(description = "学生成果统计")
    private AchievementStats achievementStats;

    /**
     * 获奖趋势数据
     */
    @Schema(description = "获奖趋势数据")
    private TrendData awardTrends;

    /**
     * 获奖作品列表
     */
    @Schema(description = "获奖作品列表")
    private List<AwardWork> awardWorks;

    /**
     * 卡片统计数据
     */
    @Schema(description = "卡片统计数据")
    private SchoolCardStats cardStats;
} 