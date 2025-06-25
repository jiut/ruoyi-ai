package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaCheckRole;
import cn.dev33.satoken.annotation.SaMode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.School;
import org.ruoyi.designer.service.ISchoolService;
import org.ruoyi.designer.service.IUserBindingService;
import org.ruoyi.designer.domain.enums.UserEntityType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 院校管理Controller
 * 
 * 权限说明：
 * - 管理员：可以访问所有院校数据和管理功能
 * - 院校管理员：只能访问自己绑定的院校数据
 *
 * @author ruoyi
 */
@Tag(name = "院校管理", description = "院校信息的增删改查操作")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/school")
public class SchoolController extends BaseController {

    private final ISchoolService schoolService;
    private final IUserBindingService userBindingService;

    /**
     * 查询院校列表
     * 管理员可以查看所有院校，院校管理员只能查看自己绑定的院校
     */
    @Operation(summary = "查询院校列表", description = "分页查询院校信息列表")
    @SaCheckPermission("designer:school:list")
    @GetMapping("/list")
    public TableDataInfo<School> list(School school, PageQuery pageQuery) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (LoginHelper.isSuperAdmin()) {
            // 管理员可以查看所有院校
            return schoolService.selectSchoolList(school, pageQuery);
        } else {
            // 非管理员用户，检查是否绑定了院校
            Long schoolId = userBindingService.getSchoolIdByUserId(userId);
            if (schoolId != null) {
                // 院校管理员只能查看自己绑定的院校
                return schoolService.selectSchoolListBySchoolId(schoolId, school, pageQuery);
            } else {
                // 没有绑定院校的用户无权访问
                return TableDataInfo.build();
            }
        }
    }

    /**
     * 获取院校详细信息
     * 管理员可以查看任意院校，院校管理员只能查看自己绑定的院校
     */
    @Operation(summary = "获取院校详情", description = "根据院校ID获取详细信息")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:query")
    @GetMapping("/{schoolId}")
    public R<School> getInfo(@PathVariable Long schoolId) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限访问该院校
            Long userSchoolId = userBindingService.getSchoolIdByUserId(userId);
            if (userSchoolId == null || !userSchoolId.equals(schoolId)) {
                return R.fail("无权访问该院校信息");
            }
        }
        
        return R.ok(schoolService.selectSchoolById(schoolId));
    }

    /**
     * 查询院校学生列表
     * 管理员可以查看任意院校，院校管理员只能查看自己绑定的院校
     */
    @Operation(summary = "查询院校学生列表", description = "分页查询院校学生信息")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:query")
    @GetMapping("/{schoolId}/students")
    public R<TableDataInfo<Map<String, Object>>> getSchoolStudents(
            @PathVariable Long schoolId,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String profession,
            @RequestParam(required = false) Integer graduationYear) {
        
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限访问该院校
            Long userSchoolId = userBindingService.getSchoolIdByUserId(userId);
            if (userSchoolId == null || !userSchoolId.equals(schoolId)) {
                return R.fail("无权访问该院校学生信息");
            }
        }
        
        PageQuery pageQuery = new PageQuery(pageSize, pageNum);
        
        return R.ok(schoolService.getSchoolStudents(schoolId, status, profession, graduationYear, pageQuery));
    }

    /**
     * 查询院校专业列表
     * 管理员可以查看任意院校，院校管理员只能查看自己绑定的院校
     */
    @Operation(summary = "查询院校专业列表", description = "获取院校专业设置")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:query")
    @GetMapping("/{schoolId}/majors")
    public R<List<Map<String, Object>>> getSchoolMajors(@PathVariable Long schoolId) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限访问该院校
            Long userSchoolId = userBindingService.getSchoolIdByUserId(userId);
            if (userSchoolId == null || !userSchoolId.equals(schoolId)) {
                return R.fail("无权访问该院校专业信息");
            }
        }
        
        return R.ok(schoolService.getSchoolMajors(schoolId));
    }

    /**
     * 查询院校获奖成果
     * 管理员可以查看任意院校，院校管理员只能查看自己绑定的院校
     */
    @Operation(summary = "查询院校获奖成果", description = "获取院校学生获奖成果")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:query")
    @GetMapping("/{schoolId}/achievements")
    public R<List<Map<String, Object>>> getSchoolAchievements(@PathVariable Long schoolId) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限访问该院校
            Long userSchoolId = userBindingService.getSchoolIdByUserId(userId);
            if (userSchoolId == null || !userSchoolId.equals(schoolId)) {
                return R.fail("无权访问该院校成果信息");
            }
        }
        
        return R.ok(schoolService.getSchoolAchievements(schoolId));
    }

    /**
     * 收藏院校
     */
    @Operation(summary = "收藏院校", description = "收藏院校到个人收藏夹")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:query")
    @PostMapping("/{schoolId}/favorite")
    public R<Void> favoriteSchool(@PathVariable Long schoolId) {
        Long userId = LoginHelper.getUserId();
        return toAjax(schoolService.favoriteSchool(schoolId, userId));
    }

    /**
     * 取消收藏院校
     */
    @Operation(summary = "取消收藏院校", description = "从个人收藏夹移除院校")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:query")
    @DeleteMapping("/{schoolId}/favorite")
    public R<Void> unfavoriteSchool(@PathVariable Long schoolId) {
        Long userId = LoginHelper.getUserId();
        return toAjax(schoolService.unfavoriteSchool(schoolId, userId));
    }

    /**
     * 获取我的收藏院校
     */
    @Operation(summary = "获取我的收藏院校", description = "获取当前用户收藏的院校列表")
    @SaCheckPermission("designer:school:query")
    @GetMapping("/favorites")
    public R<List<School>> getFavoriteSchools() {
        Long userId = LoginHelper.getUserId();
        return R.ok(schoolService.getFavoriteSchools(userId));
    }



    /**
     * 新增院校
     * 仅管理员可以访问
     */
    @Operation(summary = "新增院校", description = "添加新的院校信息")
    @SaCheckRole("admin")
    @SaCheckPermission("designer:school:add")
    @Log(title = "院校管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody School school) {
        return toAjax(schoolService.insertSchool(school));
    }

    /**
     * 修改院校
     * 管理员可以修改任意院校，院校管理员只能修改自己绑定的院校
     */
    @Operation(summary = "修改院校", description = "更新院校信息")
    @SaCheckPermission("designer:school:edit")
    @Log(title = "院校管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody School school) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限修改该院校
            Long userSchoolId = userBindingService.getSchoolIdByUserId(userId);
            if (userSchoolId == null || !userSchoolId.equals(school.getSchoolId())) {
                return R.fail("无权修改该院校信息");
            }
        }
        
        return toAjax(schoolService.updateSchool(school));
    }

    /**
     * 删除院校
     * 仅管理员可以访问
     */
    @Operation(summary = "删除院校", description = "批量删除院校")
    @Parameter(name = "schoolIds", description = "院校ID数组", required = true)
    @SaCheckRole("admin")
    @SaCheckPermission("designer:school:remove")
    @Log(title = "院校管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{schoolIds}")
    public R<Void> remove(@PathVariable Long[] schoolIds) {
        return toAjax(schoolService.deleteSchoolByIds(Arrays.asList(schoolIds)));
    }

    /**
     * 根据用户ID查询院校
     * 仅管理员可以访问
     */
    @Operation(summary = "根据用户ID查询院校", description = "获取用户绑定的院校信息")
    @Parameter(name = "userId", description = "用户ID", required = true)
    @SaCheckRole("admin")
    @SaCheckPermission("designer:school:query")
    @GetMapping("/user/{userId}")
    public R<School> getByUserId(@PathVariable Long userId) {
        return R.ok(schoolService.selectSchoolByUserId(userId));
    }

    /**
     * 获取院校就业统计 
     * 管理员可以查看任意院校，院校管理员只能查看自己绑定的院校
     */
    @Operation(summary = "获取就业统计", description = "获取院校毕业生就业统计数据")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:statistics")
    @GetMapping("/{schoolId}/employment/statistics")
    public R<Map<String, Object>> getEmploymentStatistics(@PathVariable Long schoolId) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限访问该院校
            Long userSchoolId = userBindingService.getSchoolIdByUserId(userId);
            if (userSchoolId == null || !userSchoolId.equals(schoolId)) {
                return R.fail("无权访问该院校统计信息");
            }
        }
        
        return R.ok(schoolService.getEmploymentStatistics(schoolId));
    }

    /**
     * 获取院校就业分布
     * 管理员可以查看任意院校，院校管理员只能查看自己绑定的院校
     */
    @Operation(summary = "获取就业分布", description = "获取院校毕业生企业分布数据")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:statistics")
    @GetMapping("/{schoolId}/employment/distribution")
    public R<List<Map<String, Object>>> getEmploymentDistribution(@PathVariable Long schoolId) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否为管理员
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限访问该院校
            Long userSchoolId = userBindingService.getSchoolIdByUserId(userId);
            if (userSchoolId == null || !userSchoolId.equals(schoolId)) {
                return R.fail("无权访问该院校分布信息");
            }
        }
        
        return R.ok(schoolService.getEmploymentDistribution(schoolId));
    }
}