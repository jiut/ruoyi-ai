package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.common.idempotent.annotation.RepeatSubmit;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.WorkExperience;
import org.ruoyi.designer.service.IWorkExperienceService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 工作经历管理（已废弃）
 * 
 * @deprecated 请使用 ProfileManagementController 中的新接口
 * @author ruoyi
 */
@Deprecated
@Tag(name = "工作经历管理（已废弃）", description = "请使用 ProfileManagementController 中的新接口")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/work-experience")
public class WorkExperienceController extends BaseController {

    private final IWorkExperienceService workExperienceService;
    private final DesignerPermissionUtils designerPermissionUtils;

    /**
     * 查询工作经历列表
     */
    // @SaCheckPermission("designer:workExperience:list") // 移除严格权限注解
    @GetMapping("/list")
    public TableDataInfo<WorkExperience> list(WorkExperience workExperience) {
        // 权限检查：管理员 OR 设计师查询自己的记录
        if (workExperience.getDesignerId() != null) {
            if (!LoginHelper.isSuperAdmin()) {
                if (!designerPermissionUtils.hasDesignerPermission(workExperience.getDesignerId())) {
                    return TableDataInfo.build(); // 返回空列表，不暴露权限错误
                }
            }
        } else {
            // 如果没有指定designerId，只有管理员可以查看所有工作经历
            if (!LoginHelper.isSuperAdmin()) {
                return TableDataInfo.build();
            }
        }
        
        return workExperienceService.selectWorkExperienceList(workExperience);
    }

    /**
     * 获取工作经历详细信息
     */
    @SaCheckPermission("designer:workExperience:query")
    @GetMapping("/{experienceId}")
    public R<WorkExperience> getInfo(@PathVariable Long experienceId) {
        return R.ok(workExperienceService.selectWorkExperienceById(experienceId));
    }

    /**
     * 根据设计师ID查询工作经历列表
     */
    @SaCheckPermission("designer:workExperience:list")
    @GetMapping("/designer/{designerId}")
    public R<List<WorkExperience>> getWorkExperiencesByDesignerId(@PathVariable Long designerId) {
        List<WorkExperience> workExperiences = workExperienceService.selectWorkExperienceByDesignerId(designerId);
        return R.ok(workExperiences);
    }

    /**
     * 新增工作经历
     */
    @SaCheckPermission("designer:workExperience:add")
    @Log(title = "工作经历", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody WorkExperience workExperience) {
        return toAjax(workExperienceService.insertWorkExperience(workExperience));
    }

    /**
     * 修改工作经历
     */
    // @SaCheckPermission("designer:workExperience:edit") // 移除严格权限注解
    @Log(title = "工作经历", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody WorkExperience workExperience) {
        // 权限检查：管理员 OR 设计师本人
        if (!LoginHelper.isSuperAdmin()) {
            // 检查工作经历是否存在
            WorkExperience existing = workExperienceService.selectWorkExperienceById(workExperience.getExperienceId());
            if (existing == null) {
                return R.fail("工作经历不存在");
            }
            
            // 检查是否是设计师本人
            if (!designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                return R.fail("无权限编辑此工作经历");
            }
            
            // 确保不能修改设计师ID（防止恶意修改）
            workExperience.setDesignerId(existing.getDesignerId());
        }
        
        return toAjax(workExperienceService.updateWorkExperience(workExperience));
    }

    /**
     * 删除工作经历
     */
    // @SaCheckPermission("designer:workExperience:remove") // 移除严格权限注解
    @Log(title = "工作经历", businessType = BusinessType.DELETE)
    @DeleteMapping("/{experienceIds}")
    public R<Void> remove(@PathVariable List<Long> experienceIds) {
        if (!LoginHelper.isSuperAdmin()) {
            // 检查所有要删除的记录是否都属于当前用户
            for (Long id : experienceIds) {
                WorkExperience existing = workExperienceService.selectWorkExperienceById(id);
                if (existing == null || !designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                    return R.fail("无权限删除工作经历");
                }
            }
        }
        
        return toAjax(workExperienceService.deleteWorkExperienceByIds(experienceIds));
    }
} 