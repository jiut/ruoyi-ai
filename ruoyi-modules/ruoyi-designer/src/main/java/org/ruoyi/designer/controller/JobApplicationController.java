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
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.JobApplication;
import org.ruoyi.designer.domain.JobPosting;
import org.ruoyi.designer.service.IJobApplicationService;
import org.ruoyi.designer.service.IJobPostingService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 岗位申请Controller
 * 
 * 权限说明：
 * - 系统管理员：可以访问所有申请管理功能
 * - 设计师：可以申请岗位、查看和撤回自己的申请
 * - 企业管理员：可以处理自己企业岗位的申请
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
    private final IJobPostingService jobPostingService;
    private final DesignerPermissionUtils permissionUtils;

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
     * 权限矩阵：只有设计师和系统管理员可以申请岗位
     */
    @Operation(
        summary = "申请岗位",
        description = "设计师申请指定的岗位"
    )
    @SaCheckPermission("designer:application:apply")
    @Log(title = "申请岗位", businessType = BusinessType.INSERT)
    @PostMapping("/apply")
    public R<Void> applyForJob(
            @Parameter(name = "jobId", description = "岗位ID", required = true, example = "1")
            @RequestParam Long jobId,
            @Parameter(name = "designerId", description = "设计师ID", required = true, example = "1") 
            @RequestParam Long designerId,
            @Parameter(name = "coverLetter", description = "申请说明", required = false, 
                      example = "我对这个岗位很感兴趣，希望能加入贵公司团队")
            @RequestParam(required = false) String coverLetter,
            @Parameter(name = "resumeUrl", description = "简历文件URL", required = false, 
                      example = "https://example.com/resume.pdf")
            @RequestParam(required = false) String resumeUrl) {
        
        // 验证当前用户是否为设计师或管理员
        if (!LoginHelper.isSuperAdmin() && !permissionUtils.isDesigner()) {
            return R.fail("只有设计师用户才能申请岗位");
        }
        
        // 如果是设计师，验证是否为自己申请
        if (permissionUtils.isDesigner()) {
            Long currentDesignerId = permissionUtils.getCurrentDesignerId();
            if (currentDesignerId == null || !currentDesignerId.equals(designerId)) {
                return R.fail("只能为自己申请岗位");
            }
        }
        
        return toAjax(jobApplicationService.applyForJob(jobId, designerId, coverLetter, resumeUrl));
    }

    /**
     * 企业处理申请（通过或拒绝）
     * 权限矩阵：只有企业管理员和系统管理员可以处理申请
     */
    @Operation(
        summary = "处理岗位申请",
        description = "企业处理设计师的岗位申请，可以通过或拒绝申请"
    )
    @SaCheckPermission("designer:application:process")
    @Log(title = "处理申请", businessType = BusinessType.UPDATE)
    @PutMapping("/process")
    public R<Void> processApplication(
            @Parameter(name = "applicationId", description = "申请ID", required = true, example = "1") 
            @RequestParam Long applicationId,
            @Parameter(name = "status", description = "处理结果", required = true, 
                      example = "APPROVED",
                      schema = @io.swagger.v3.oas.annotations.media.Schema(
                          allowableValues = {"APPROVED", "REJECTED", "1", "2"},
                          description = "支持英文常量（APPROVED=通过, REJECTED=拒绝）或数字代码（1=通过, 2=拒绝）"
                      ))
            @RequestParam String status,
            @Parameter(name = "feedback", description = "企业反馈信息", required = false, 
                      example = "申请通过，请联系HR安排面试")
            @RequestParam(required = false) String feedback) {
        
        // 验证当前用户是否为企业用户或管理员
        if (!LoginHelper.isSuperAdmin() && !permissionUtils.isEnterprise()) {
            return R.fail("只有企业用户才能处理岗位申请");
        }
        
        // 如果是企业用户，验证是否为自己企业的岗位申请
        if (permissionUtils.isEnterprise()) {
            // 获取申请信息
            JobApplication application = jobApplicationService.selectJobApplicationById(applicationId);
            if (application == null) {
                return R.fail("申请不存在");
            }
            
            // 获取岗位信息
            JobPosting jobPosting = jobPostingService.selectJobPostingById(application.getJobId());
            if (jobPosting == null) {
                return R.fail("岗位不存在");
            }
            
            // 验证是否为自己企业的岗位
            if (!permissionUtils.hasEnterprisePermission(jobPosting.getEnterpriseId())) {
                return R.fail("只能处理自己企业的岗位申请");
            }
        }
        
        return toAjax(jobApplicationService.processApplication(applicationId, status, feedback));
    }

    /**
     * 设计师撤回申请
     * 权限矩阵：只有设计师和系统管理员可以撤回申请
     */
    @Operation(
        summary = "撤回申请",
        description = "设计师撤回自己提交的岗位申请"
    )
    @SaCheckPermission("designer:application:withdraw")
    @Log(title = "撤回申请", businessType = BusinessType.UPDATE)
    @PutMapping("/withdraw")
    public R<Void> withdrawApplication(
            @Parameter(name = "applicationId", description = "申请ID", required = true, example = "1")
            @RequestParam Long applicationId,
            @Parameter(name = "designerId", description = "设计师ID", required = true, example = "1")
            @RequestParam Long designerId) {
        
        // 验证当前用户是否为设计师或管理员
        if (!LoginHelper.isSuperAdmin() && !permissionUtils.isDesigner()) {
            return R.fail("只有设计师用户才能撤回申请");
        }
        
        // 如果是设计师，验证是否为自己的申请
        if (permissionUtils.isDesigner()) {
            Long currentDesignerId = permissionUtils.getCurrentDesignerId();
            if (currentDesignerId == null || !currentDesignerId.equals(designerId)) {
                return R.fail("只能撤回自己的申请");
            }
        }
        
        return toAjax(jobApplicationService.withdrawApplication(applicationId, designerId));
    }
} 