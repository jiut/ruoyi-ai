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
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 教育背景信息Controller（已废弃）
 *
 * @deprecated 请使用 ProfileManagementController 中的新接口
 * @author ruoyi
 */
@Deprecated
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/education")
@Tag(name = "设计师教育背景管理（已废弃）", description = "请使用 ProfileManagementController 中的新接口")
public class EducationController extends BaseController {

    private final IEducationService educationService;
    private final DesignerPermissionUtils designerPermissionUtils;

    /**
     * 查询教育背景列表
     */
    @GetMapping("/list")
    // @SaCheckPermission("designer:education:list") // 移除严格权限注解
    @Operation(summary = "查询教育背景列表", description = "根据条件分页查询教育背景信息")
    public TableDataInfo<Education> list(Education education) {
        // 权限检查：管理员 OR 设计师查询自己的记录
        if (education.getDesignerId() != null) {
            if (!LoginHelper.isSuperAdmin()) {
                if (!designerPermissionUtils.hasDesignerPermission(education.getDesignerId())) {
                    return TableDataInfo.build(); // 返回空列表，不暴露权限错误
                }
            }
        } else {
            // 如果没有指定designerId，只有管理员可以查看所有教育背景
            if (!LoginHelper.isSuperAdmin()) {
                return TableDataInfo.build();
            }
        }
        
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
    // @SaCheckPermission("designer:education:edit") // 移除严格权限注解
    @Log(title = "教育背景管理", businessType = BusinessType.UPDATE)
    @Operation(summary = "修改教育背景", description = "更新教育背景信息")
    public R<Void> edit(@Validated @RequestBody Education education) {
        // 权限检查：管理员 OR 设计师本人
        if (!LoginHelper.isSuperAdmin()) {
            // 检查教育背景是否存在
            Education existing = educationService.selectEducationById(education.getEducationId());
            if (existing == null) {
                return R.fail("教育背景不存在");
            }
            
            // 检查是否是设计师本人
            if (!designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                return R.fail("无权限编辑此教育背景");
            }
            
            // 确保不能修改设计师ID（防止恶意修改）
            education.setDesignerId(existing.getDesignerId());
        }
        
        return toAjax(educationService.updateEducation(education));
    }

    /**
     * 删除教育背景
     */
    @DeleteMapping("/{educationIds}")
    // @SaCheckPermission("designer:education:remove") // 移除严格权限注解
    @Log(title = "教育背景管理", businessType = BusinessType.DELETE)
    @Operation(summary = "删除教育背景", description = "根据ID删除教育背景信息")
    public R<Void> remove(@Parameter(description = "教育背景ID数组") @PathVariable List<Long> educationIds) {
        if (!LoginHelper.isSuperAdmin()) {
            // 检查所有要删除的记录是否都属于当前用户
            for (Long id : educationIds) {
                Education existing = educationService.selectEducationById(id);
                if (existing == null || !designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                    return R.fail("无权限删除教育背景");
                }
            }
        }
        
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