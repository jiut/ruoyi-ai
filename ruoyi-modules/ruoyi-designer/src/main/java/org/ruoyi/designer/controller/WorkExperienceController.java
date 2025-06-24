package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 工作经历管理
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/work-experience")
public class WorkExperienceController extends BaseController {

    private final IWorkExperienceService workExperienceService;

    /**
     * 查询工作经历列表
     */
    @SaCheckPermission("designer:workExperience:list")
    @GetMapping("/list")
    public TableDataInfo<WorkExperience> list(WorkExperience workExperience) {
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
    @SaCheckPermission("designer:workExperience:edit")
    @Log(title = "工作经历", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody WorkExperience workExperience) {
        return toAjax(workExperienceService.updateWorkExperience(workExperience));
    }

    /**
     * 删除工作经历
     */
    @SaCheckPermission("designer:workExperience:remove")
    @Log(title = "工作经历", businessType = BusinessType.DELETE)
    @DeleteMapping("/{experienceIds}")
    public R<Void> remove(@PathVariable List<Long> experienceIds) {
        return toAjax(workExperienceService.deleteWorkExperienceByIds(experienceIds));
    }
} 