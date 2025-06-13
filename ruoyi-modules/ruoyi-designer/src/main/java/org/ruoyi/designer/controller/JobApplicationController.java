package org.ruoyi.designer.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;

import cn.dev33.satoken.annotation.SaCheckPermission;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.JobApplication;
import org.ruoyi.designer.service.IJobApplicationService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 岗位申请Controller
 *
 * @author ruoyi
 */
@Tag(name = "岗位申请管理", description = "设计师岗位申请和企业处理流程")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/application")
public class JobApplicationController extends BaseController {

    private final IJobApplicationService jobApplicationService;

    /**
     * 查询岗位申请列表
     */
    @Operation(summary = "查询岗位申请列表", description = "分页查询岗位申请信息")
    @SaCheckPermission("designer:application:list")
    @GetMapping("/list")
    public TableDataInfo<JobApplication> list(JobApplication jobApplication, PageQuery pageQuery) {
        return jobApplicationService.selectJobApplicationList(jobApplication, pageQuery);
    }

    /**
     * 获取岗位申请详细信息
     */
    @SaCheckPermission("designer:application:query")
    @GetMapping("/{applicationId}")
    public R<JobApplication> getInfo(@PathVariable Long applicationId) {
        return R.ok(jobApplicationService.selectJobApplicationById(applicationId));
    }

    /**
     * 新增岗位申请
     */
    @SaCheckPermission("designer:application:add")
    @Log(title = "岗位申请", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody JobApplication jobApplication) {
        return toAjax(jobApplicationService.insertJobApplication(jobApplication));
    }

    /**
     * 修改岗位申请
     */
    @SaCheckPermission("designer:application:edit")
    @Log(title = "岗位申请", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody JobApplication jobApplication) {
        return toAjax(jobApplicationService.updateJobApplication(jobApplication));
    }

    /**
     * 删除岗位申请
     */
    @SaCheckPermission("designer:application:remove")
    @Log(title = "岗位申请", businessType = BusinessType.DELETE)
    @DeleteMapping("/{applicationIds}")
    public R<Void> remove(@PathVariable Long[] applicationIds) {
        return toAjax(jobApplicationService.deleteJobApplicationByIds(Arrays.asList(applicationIds)));
    }

    /**
     * 根据岗位查询申请
     */
    @SaCheckPermission("designer:application:query")
    @GetMapping("/job/{jobId}")
    public R<List<JobApplication>> getByJob(@PathVariable Long jobId) {
        return R.ok(jobApplicationService.selectJobApplicationByJob(jobId));
    }

    /**
     * 根据设计师查询申请
     */
    @SaCheckPermission("designer:application:query")
    @GetMapping("/designer/{designerId}")
    public R<List<JobApplication>> getByDesigner(@PathVariable Long designerId) {
        return R.ok(jobApplicationService.selectJobApplicationByDesigner(designerId));
    }

    /**
     * 设计师申请岗位
     */
    @SaCheckPermission("designer:application:apply")
    @Log(title = "申请岗位", businessType = BusinessType.INSERT)
    @PostMapping("/apply")
    public R<Void> applyForJob(@RequestParam Long jobId, 
                               @RequestParam Long designerId,
                               @RequestParam(required = false) String coverLetter,
                               @RequestParam(required = false) String resumeUrl) {
        return toAjax(jobApplicationService.applyForJob(jobId, designerId, coverLetter, resumeUrl));
    }

    /**
     * 企业处理申请（通过或拒绝）
     */
    @SaCheckPermission("designer:application:process")
    @Log(title = "处理申请", businessType = BusinessType.UPDATE)
    @PutMapping("/process")
    public R<Void> processApplication(@RequestParam Long applicationId,
                                      @RequestParam String status,
                                      @RequestParam(required = false) String feedback) {
        return toAjax(jobApplicationService.processApplication(applicationId, status, feedback));
    }

    /**
     * 设计师撤回申请
     */
    @SaCheckPermission("designer:application:withdraw")
    @Log(title = "撤回申请", businessType = BusinessType.UPDATE)
    @PutMapping("/withdraw")
    public R<Void> withdrawApplication(@RequestParam Long applicationId,
                                       @RequestParam Long designerId) {
        return toAjax(jobApplicationService.withdrawApplication(applicationId, designerId));
    }
} 