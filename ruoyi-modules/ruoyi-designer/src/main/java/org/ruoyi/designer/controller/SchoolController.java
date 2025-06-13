package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
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
import org.ruoyi.designer.domain.School;
import org.ruoyi.designer.service.ISchoolService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 院校管理Controller
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

    /**
     * 查询院校列表
     */
    @Operation(summary = "查询院校列表", description = "分页查询院校信息列表")
    @SaCheckPermission("designer:school:list")
    @GetMapping("/list")
    public TableDataInfo<School> list(School school, PageQuery pageQuery) {
        return schoolService.selectSchoolList(school, pageQuery);
    }

    /**
     * 获取院校详细信息
     */
    @Operation(summary = "获取院校详情", description = "根据院校ID获取详细信息")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:query")
    @GetMapping("/{schoolId}")
    public R<School> getInfo(@PathVariable Long schoolId) {
        return R.ok(schoolService.selectSchoolById(schoolId));
    }

    /**
     * 新增院校
     */
    @Operation(summary = "新增院校", description = "添加新的院校信息")
    @SaCheckPermission("designer:school:add")
    @Log(title = "院校管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody School school) {
        return toAjax(schoolService.insertSchool(school));
    }

    /**
     * 修改院校
     */
    @Operation(summary = "修改院校", description = "更新院校信息")
    @SaCheckPermission("designer:school:edit")
    @Log(title = "院校管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody School school) {
        return toAjax(schoolService.updateSchool(school));
    }

    /**
     * 删除院校
     */
    @Operation(summary = "删除院校", description = "批量删除院校")
    @Parameter(name = "schoolIds", description = "院校ID数组", required = true)
    @SaCheckPermission("designer:school:remove")
    @Log(title = "院校管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{schoolIds}")
    public R<Void> remove(@PathVariable Long[] schoolIds) {
        return toAjax(schoolService.deleteSchoolByIds(Arrays.asList(schoolIds)));
    }

    /**
     * 根据用户ID查询院校
     */
    @Operation(summary = "根据用户ID查询院校", description = "获取用户绑定的院校信息")
    @Parameter(name = "userId", description = "用户ID", required = true)
    @SaCheckPermission("designer:school:query")
    @GetMapping("/user/{userId}")
    public R<School> getByUserId(@PathVariable Long userId) {
        return R.ok(schoolService.selectSchoolByUserId(userId));
    }

    /**
     * 获取院校就业统计
     */
    @Operation(summary = "获取就业统计", description = "获取院校毕业生就业统计数据")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:statistics")
    @GetMapping("/{schoolId}/employment/statistics")
    public R<Map<String, Object>> getEmploymentStatistics(@PathVariable Long schoolId) {
        return R.ok(schoolService.getEmploymentStatistics(schoolId));
    }

    /**
     * 获取院校就业分布
     */
    @Operation(summary = "获取就业分布", description = "获取院校毕业生企业分布数据")
    @Parameter(name = "schoolId", description = "院校ID", required = true)
    @SaCheckPermission("designer:school:statistics")
    @GetMapping("/{schoolId}/employment/distribution")
    public R<List<Map<String, Object>>> getEmploymentDistribution(@PathVariable Long schoolId) {
        return R.ok(schoolService.getEmploymentDistribution(schoolId));
    }
}