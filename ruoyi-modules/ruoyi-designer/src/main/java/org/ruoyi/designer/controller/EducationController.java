package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.Education;
import org.ruoyi.designer.service.IEducationService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 教育背景信息Controller
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/education")
@Tag(name = "设计师教育背景管理", description = "设计师教育背景信息的增删改查")
public class EducationController extends BaseController {

    private final IEducationService educationService;

    /**
     * 查询教育背景列表
     */
    @GetMapping("/list")
    @SaCheckPermission("designer:education:list")
    @Operation(summary = "查询教育背景列表", description = "根据条件分页查询教育背景信息")
    public TableDataInfo<Education> list(Education education) {
        return educationService.selectEducationList(education);
    }

    /**
     * 根据设计师ID获取教育背景列表
     */
    @GetMapping("/designer/{designerId}")
    @SaCheckPermission("designer:education:list")
    @Operation(summary = "根据设计师ID查询教育背景", description = "获取指定设计师的所有教育背景信息")
    public R<List<Education>> getByDesignerId(@Parameter(description = "设计师ID") @PathVariable("designerId") Long designerId) {
        List<Education> list = educationService.selectEducationByDesignerId(designerId);
        return R.ok(list);
    }

    /**
     * 获取教育背景详细信息
     */
    @GetMapping("/{educationId}")
    @SaCheckPermission("designer:education:query")
    @Operation(summary = "获取教育背景详情", description = "根据教育背景ID获取详细信息")
    public R<Education> getInfo(@Parameter(description = "教育背景ID") @PathVariable("educationId") Long educationId) {
        return R.ok(educationService.selectEducationById(educationId));
    }

    /**
     * 新增教育背景
     */
    @PostMapping
    @SaCheckPermission("designer:education:add")
    @Log(title = "教育背景管理", businessType = BusinessType.INSERT)
    @Operation(summary = "新增教育背景", description = "添加新的教育背景信息")
    public R<Void> add(@Validated @RequestBody Education education) {
        return toAjax(educationService.insertEducation(education));
    }

    /**
     * 修改教育背景
     */
    @PutMapping
    @SaCheckPermission("designer:education:edit")
    @Log(title = "教育背景管理", businessType = BusinessType.UPDATE)
    @Operation(summary = "修改教育背景", description = "更新教育背景信息")
    public R<Void> edit(@Validated @RequestBody Education education) {
        return toAjax(educationService.updateEducation(education));
    }

    /**
     * 删除教育背景
     */
    @DeleteMapping("/{educationIds}")
    @SaCheckPermission("designer:education:remove")
    @Log(title = "教育背景管理", businessType = BusinessType.DELETE)
    @Operation(summary = "删除教育背景", description = "根据ID删除教育背景信息")
    public R<Void> remove(@Parameter(description = "教育背景ID数组") @PathVariable List<Long> educationIds) {
        return toAjax(educationService.deleteEducationByIds(educationIds));
    }

    /**
     * 删除指定设计师的所有教育背景
     */
    @DeleteMapping("/designer/{designerId}")
    @SaCheckPermission("designer:education:remove")
    @Log(title = "教育背景管理", businessType = BusinessType.DELETE)
    @Operation(summary = "删除设计师所有教育背景", description = "删除指定设计师的所有教育背景信息")
    public R<Void> removeByDesignerId(@Parameter(description = "设计师ID") @PathVariable("designerId") Long designerId) {
        return toAjax(educationService.deleteEducationByDesignerId(designerId));
    }
} 