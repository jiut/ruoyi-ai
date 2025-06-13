package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.JobPosting;
import org.ruoyi.designer.service.IJobPostingService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 岗位招聘Controller
 *
 * @author ruoyi
 */
@Tag(name = "岗位招聘管理", description = "企业岗位发布和管理")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/job")
public class JobPostingController extends BaseController {

    private final IJobPostingService jobPostingService;
    private final DesignerPermissionUtils permissionUtils;

    /**
     * 查询岗位招聘列表
     */
    @Operation(
        summary = "查询岗位列表", 
        description = "分页查询岗位招聘信息",
        parameters = {
            @Parameter(name = "jobTitle", description = "岗位名称"),
            @Parameter(name = "requiredProfession", description = "职业要求"),
            @Parameter(name = "location", description = "工作地点"),
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10")
        }
    )
    @SaCheckPermission("designer:job:list")
    @GetMapping("/list")
    public TableDataInfo<JobPosting> list(JobPosting jobPosting, PageQuery pageQuery) {
        return jobPostingService.selectJobPostingList(jobPosting, pageQuery);
    }

    /**
     * 获取岗位招聘详细信息
     */
    @Operation(
        summary = "获取岗位详情",
        description = "根据岗位ID获取详细信息",
        parameters = @Parameter(name = "jobId", description = "岗位ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:job:query")
    @GetMapping("/{jobId}")
    public R<JobPosting> getInfo(@PathVariable Long jobId) {
        return R.ok(jobPostingService.selectJobPostingById(jobId));
    }

    /**
     * 新增岗位招聘
     */
    @Operation(
        summary = "发布岗位",
        description = "企业发布新的招聘岗位",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "岗位信息",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = JobPosting.class),
                examples = @ExampleObject(
                    name = "岗位发布示例",
                    value = """
                        {
                            "jobTitle": "高级UI设计师",
                            "description": "负责移动端产品UI设计，与产品经理和开发团队紧密合作",
                            "requiredProfession": "UI_DESIGNER",
                            "requiredSkills": "[\\"PROTOTYPE_DESIGN\\", \\"VISUAL_DESIGN\\"]",
                            "workYearsRequired": "3-5年",
                            "salaryMin": 15000,
                            "salaryMax": 25000,
                            "location": "北京市朝阳区",
                            "jobType": "全职",
                            "educationRequired": "本科及以上",
                            "recruitmentCount": 2,
                            "deadline": "2024-12-31",
                            "contactPerson": "王经理",
                            "contactPhone": "010-12345678",
                            "contactEmail": "hr@company.com"
                        }
                        """
                )
            )
        )
    )
    @SaCheckPermission("designer:job:add")
    @Log(title = "岗位招聘", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody JobPosting jobPosting) {
        // 验证当前用户是否为企业用户
        if (!permissionUtils.isEnterprise()) {
            return R.fail("只有企业用户才能发布岗位");
        }
        
        // 获取当前用户绑定的企业ID
        Long enterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (enterpriseId == null) {
            return R.fail("未找到企业身份，请先注册企业账户");
        }
        
        // 设置企业ID到岗位信息中
        jobPosting.setEnterpriseId(enterpriseId);
        
        return toAjax(jobPostingService.insertJobPosting(jobPosting));
    }

    /**
     * 修改岗位招聘
     */
    @Operation(
        summary = "修改岗位",
        description = "更新岗位招聘信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "岗位信息（需包含jobId）",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = JobPosting.class)
            )
        )
    )
    @SaCheckPermission("designer:job:edit")
    @Log(title = "岗位招聘", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody JobPosting jobPosting) {
        // 验证当前用户是否为企业用户
        if (!permissionUtils.isEnterprise()) {
            return R.fail("只有企业用户才能修改岗位");
        }
        
        // 验证岗位归属权限
        JobPosting existingJob = jobPostingService.selectJobPostingById(jobPosting.getJobId());
        if (existingJob == null) {
            return R.fail("岗位不存在");
        }
        
        if (!permissionUtils.hasEnterprisePermission(existingJob.getEnterpriseId())) {
            return R.fail("无权限修改此岗位");
        }
        
        return toAjax(jobPostingService.updateJobPosting(jobPosting));
    }

    /**
     * 删除岗位招聘
     */
    @Operation(
        summary = "删除岗位",
        description = "根据岗位ID删除岗位信息（支持批量删除）",
        parameters = @Parameter(name = "jobIds", description = "岗位ID数组", required = true, example = "1,2,3")
    )
    @SaCheckPermission("designer:job:remove")
    @Log(title = "岗位招聘", businessType = BusinessType.DELETE)
    @DeleteMapping("/{jobIds}")
    public R<Void> remove(@PathVariable Long[] jobIds) {
        // 验证当前用户是否为企业用户
        if (!permissionUtils.isEnterprise()) {
            return R.fail("只有企业用户才能删除岗位");
        }
        
        // 验证所有岗位的归属权限
        for (Long jobId : jobIds) {
            JobPosting existingJob = jobPostingService.selectJobPostingById(jobId);
            if (existingJob == null) {
                return R.fail("岗位不存在: " + jobId);
            }
            
            if (!permissionUtils.hasEnterprisePermission(existingJob.getEnterpriseId())) {
                return R.fail("无权限删除岗位: " + jobId);
            }
        }
        
        return toAjax(jobPostingService.deleteJobPostingByIds(Arrays.asList(jobIds)));
    }

    /**
     * 根据企业查询岗位
     */
    @Operation(
        summary = "企业岗位查询",
        description = "根据企业ID查询该企业发布的所有岗位",
        parameters = @Parameter(name = "enterpriseId", description = "企业ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:job:query")
    @GetMapping("/enterprise/{enterpriseId}")
    public R<List<JobPosting>> getByEnterprise(@PathVariable Long enterpriseId) {
        // 验证权限：只有该企业用户或管理员才能查询企业岗位
        if (!permissionUtils.hasEnterprisePermission(enterpriseId)) {
            return R.fail("无权限查询该企业的岗位信息");
        }
        
        return R.ok(jobPostingService.selectJobPostingByEnterprise(enterpriseId));
    }

    /**
     * 根据职业要求查询岗位
     */
    @Operation(
        summary = "按职业查询岗位",
        description = "根据职业要求查询相关岗位",
        parameters = @Parameter(name = "profession", description = "职业类型", required = true, 
                               example = "UI_DESIGNER",
                               schema = @Schema(allowableValues = {"ILLUSTRATOR", "INTERACTION_DESIGNER", 
                                                                 "BRAND_DESIGNER", "UI_DESIGNER", "UX_DESIGNER", 
                                                                 "GRAPHIC_DESIGNER", "PRODUCT_DESIGNER", "MOTION_DESIGNER"}))
    )
    @SaCheckPermission("designer:job:query")
    @GetMapping("/profession/{profession}")
    public R<List<JobPosting>> getByProfession(@PathVariable String profession) {
        return R.ok(jobPostingService.selectJobPostingByProfession(profession));
    }

    /**
     * 根据技能要求查询岗位
     */
    @Operation(
        summary = "按技能查询岗位",
        description = "根据技能要求查询匹配的岗位",
        parameters = @Parameter(name = "skillTags", description = "技能标签列表", required = true,
                               example = "PROTOTYPE_DESIGN,VISUAL_DESIGN")
    )
    @SaCheckPermission("designer:job:query")
    @GetMapping("/skills")
    public R<List<JobPosting>> getBySkills(@RequestParam List<String> skillTags) {
        return R.ok(jobPostingService.selectJobPostingBySkills(skillTags));
    }
} 