package org.ruoyi.designer.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.*;
import org.ruoyi.designer.domain.vo.CompleteProfileVo;
import org.ruoyi.designer.domain.vo.ProfileCompletenessVo;
import org.ruoyi.designer.domain.vo.DesignerCompletenessVo;
import org.ruoyi.designer.service.*;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.HashMap;
import java.util.Map;

/**
 * 统一档案管理Controller
 *
 * @author ruoyi
 */
@Tag(name = "设计师档案管理", description = "统一的设计师档案管理接口")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer")
@Slf4j
public class ProfileManagementController extends BaseController {

    private final IWorkExperienceService workExperienceService;
    private final IEducationService educationService;
    private final IWorkService workService;
    private final IAwardService awardService;
    private final IDesignerService designerService;
    private final IUserBindingService userBindingService;
    private final DesignerPermissionUtils permissionUtils;

    // ========== 工作经历管理接口 ==========

    /**
     * 查询工作经历列表（权限控制返回范围）
     */
    @Operation(summary = "查询工作经历列表", description = "根据权限返回相应范围的工作经历数据")
    @GetMapping("/work-experience/list")
    public R<List<WorkExperience>> getWorkExperienceList() {
        if (LoginHelper.isSuperAdmin()) {
            // 管理员可查看所有
            return R.ok(workExperienceService.selectWorkExperienceList(new WorkExperience()).getRows());
        } else {
            // 普通用户只能查看自己的
            Long designerId = permissionUtils.getCurrentDesignerIdSafely();
            if (designerId == null) {
                return R.fail("用户未绑定设计师身份");
            }
            List<WorkExperience> experiences = workExperienceService.selectWorkExperienceByDesignerId(designerId);
            return R.ok(experiences);
        }
    }

    /**
     * 新增工作经历
     */
    @Operation(summary = "新增工作经历", description = "为当前用户添加工作经历")
    @Log(title = "工作经历", businessType = BusinessType.INSERT)
    @PostMapping("/work-experience")
    public R<Map<String, Object>> addWorkExperience(@Validated @RequestBody WorkExperience workExperience) {
        Long designerId = permissionUtils.getCurrentDesignerIdSafely();
        if (designerId == null) {
            return R.fail("用户未绑定设计师身份");
        }
        workExperience.setDesignerId(designerId);
        boolean result = workExperienceService.insertWorkExperience(workExperience);
        if (result && workExperience.getExperienceId() != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("experienceId", workExperience.getExperienceId());
            return R.ok(data);
        } else {
            return R.fail("新增失败");
        }
    }

    /**
     * 修改工作经历
     */
    @Operation(summary = "修改工作经历", description = "修改指定的工作经历信息")
    @Log(title = "工作经历", businessType = BusinessType.UPDATE)
    @PutMapping("/work-experience/{experienceId}")
    public R<Void> editWorkExperience(
        @Parameter(description = "工作经历ID") @PathVariable Long experienceId,
        @Validated @RequestBody WorkExperience workExperience) {
        
        // 检查记录是否存在且有权限操作
        WorkExperience existing = workExperienceService.selectWorkExperienceById(experienceId);
        if (existing == null) {
            return R.fail("工作经历不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限编辑此工作经历");
        }
        
        // 确保不能修改设计师ID和记录ID
        workExperience.setExperienceId(experienceId);
        workExperience.setDesignerId(existing.getDesignerId());
        
        return toAjax(workExperienceService.updateWorkExperience(workExperience));
    }

    /**
     * 删除工作经历
     */
    @Operation(summary = "删除工作经历", description = "删除指定的工作经历")
    @Log(title = "工作经历", businessType = BusinessType.DELETE)
    @DeleteMapping("/work-experience/{experienceId}")
    public R<Void> removeWorkExperience(@Parameter(description = "工作经历ID") @PathVariable Long experienceId) {
        // 检查记录是否存在且有权限操作
        WorkExperience existing = workExperienceService.selectWorkExperienceById(experienceId);
        if (existing == null) {
            return R.fail("工作经历不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限删除此工作经历");
        }
        
        Long currentUserId = LoginHelper.getUserId();
        Date currentTime = new Date();
        
        return toAjax(workExperienceService.logicDeleteWorkExperienceById(experienceId, currentUserId, currentTime));
    }

    /**
     * 查询指定设计师的工作经历（公开访问）
     */
    @Operation(summary = "查询设计师工作经历", description = "查询指定设计师的工作经历信息")
    @GetMapping("/work-experience/designer/{designerId}")
    public R<List<WorkExperience>> getDesignerWorkExperience(
        @Parameter(description = "设计师ID") @PathVariable Long designerId) {
        
        if (!permissionUtils.isValidDesignerId(designerId)) {
            return R.fail("设计师ID无效");
        }
        
        List<WorkExperience> experiences = workExperienceService.selectWorkExperienceByDesignerId(designerId);
        return R.ok(experiences);
    }

    // ========== 教育背景管理接口 ==========

    /**
     * 查询教育背景列表（权限控制返回范围）
     */
    @Operation(summary = "查询教育背景列表", description = "根据权限返回相应范围的教育背景数据")
    @GetMapping("/education/list")
    public R<List<Education>> getEducationList() {
        if (LoginHelper.isSuperAdmin()) {
            return R.ok(educationService.selectEducationList(new Education()).getRows());
        } else {
            Long designerId = permissionUtils.getCurrentDesignerIdSafely();
            if (designerId == null) {
                return R.fail("用户未绑定设计师身份");
            }
            List<Education> educations = educationService.selectEducationByDesignerId(designerId);
            return R.ok(educations);
        }
    }

    /**
     * 新增教育背景
     */
    @Operation(summary = "新增教育背景", description = "为当前用户添加教育背景")
    @Log(title = "教育背景", businessType = BusinessType.INSERT)
    @PostMapping("/education")
    public R<Map<String, Object>> addEducation(@Validated @RequestBody Education education) {
        Long designerId = permissionUtils.getCurrentDesignerIdSafely();
        if (designerId == null) {
            return R.fail("用户未绑定设计师身份");
        }
        education.setDesignerId(designerId);
        boolean result = educationService.insertEducation(education);
        if (result && education.getEducationId() != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("educationId", education.getEducationId());
            return R.ok(data);
        } else {
            return R.fail("新增失败");
        }
    }

    /**
     * 修改教育背景
     */
    @Operation(summary = "修改教育背景", description = "修改指定的教育背景信息")
    @Log(title = "教育背景", businessType = BusinessType.UPDATE)
    @PutMapping("/education/{educationId}")
    public R<Void> editEducation(
        @Parameter(description = "教育背景ID") @PathVariable Long educationId,
        @Validated @RequestBody Education education) {
        
        Education existing = educationService.selectEducationById(educationId);
        if (existing == null) {
            return R.fail("教育背景不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限编辑此教育背景");
        }
        
        education.setEducationId(educationId);
        education.setDesignerId(existing.getDesignerId());
        
        return toAjax(educationService.updateEducation(education));
    }

    /**
     * 删除教育背景
     */
    @Operation(summary = "删除教育背景", description = "删除指定的教育背景")
    @Log(title = "教育背景", businessType = BusinessType.DELETE)
    @DeleteMapping("/education/{educationId}")
    public R<Void> removeEducation(@Parameter(description = "教育背景ID") @PathVariable Long educationId) {
        Education existing = educationService.selectEducationById(educationId);
        if (existing == null) {
            return R.fail("教育背景不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限删除此教育背景");
        }
        
        // 使用逻辑删除，记录删除时间和删除人
        Long currentUserId = LoginHelper.getUserId();
        Date currentTime = new Date();
        
        return toAjax(educationService.logicDeleteEducationById(educationId, currentUserId, currentTime));
    }

    /**
     * 查询指定设计师的教育背景（公开访问）
     */
    @Operation(summary = "查询设计师教育背景", description = "查询指定设计师的教育背景信息")
    @GetMapping("/education/designer/{designerId}")
    public R<List<Education>> getDesignerEducation(
        @Parameter(description = "设计师ID") @PathVariable Long designerId) {
        
        if (!permissionUtils.isValidDesignerId(designerId)) {
            return R.fail("设计师ID无效");
        }
        
        List<Education> educations = educationService.selectEducationByDesignerId(designerId);
        return R.ok(educations);
    }

    // ========== 作品管理接口 ==========

    /**
     * 查询作品列表（权限控制返回范围）
     */
    @Operation(summary = "查询作品列表", description = "根据权限返回相应范围的作品数据")
    @GetMapping("/work/list")
    public R<List<Work>> getWorkList() {
        if (LoginHelper.isSuperAdmin()) {
            return R.ok(workService.selectWorkList(new Work()).getRows());
        } else {
            Long designerId = permissionUtils.getCurrentDesignerIdSafely();
            if (designerId == null) {
                return R.fail("用户未绑定设计师身份");
            }
            List<Work> works = workService.selectWorkByDesignerId(designerId);
            return R.ok(works);
        }
    }

    /**
     * 新增作品
     */
    @Operation(summary = "新增作品", description = "为当前用户添加作品")
    @Log(title = "作品", businessType = BusinessType.INSERT)
    @PostMapping("/work")
    public R<Map<String, Object>> addWork(@Validated @RequestBody Work work) {
        Long designerId = permissionUtils.getCurrentDesignerIdSafely();
        if (designerId == null) {
            return R.fail("用户未绑定设计师身份");
        }
        work.setDesignerId(designerId);
        boolean result = workService.insertWork(work);
        if (result && work.getWorkId() != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("workId", work.getWorkId());
            return R.ok(data);
        } else {
            return R.fail("新增失败");
        }
    }

    /**
     * 修改作品
     */
    @Operation(summary = "修改作品", description = "修改指定的作品信息")
    @Log(title = "作品", businessType = BusinessType.UPDATE)
    @PutMapping("/work/{workId}")
    public R<Void> editWork(
        @Parameter(description = "作品ID") @PathVariable Long workId,
        @Validated @RequestBody Work work) {
        
        Work existing = workService.selectWorkById(workId);
        if (existing == null) {
            return R.fail("作品不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限编辑此作品");
        }
        
        work.setWorkId(workId);
        work.setDesignerId(existing.getDesignerId());
        
        return toAjax(workService.updateWork(work));
    }

    /**
     * 删除作品
     */
    @Operation(summary = "删除作品", description = "删除指定的作品")
    @Log(title = "作品", businessType = BusinessType.DELETE)
    @DeleteMapping("/work/{workId}")
    public R<Void> removeWork(@Parameter(description = "作品ID") @PathVariable Long workId) {
        Work existing = workService.selectWorkById(workId);
        if (existing == null) {
            return R.fail("作品不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限删除此作品");
        }
        
        Long currentUserId = LoginHelper.getUserId();
        Date currentTime = new Date();
        return toAjax(workService.logicDeleteWorkById(workId, currentUserId, currentTime));
    }

    /**
     * 查询指定设计师的作品（公开访问）
     */
    @Operation(summary = "查询设计师作品", description = "查询指定设计师的作品信息")
    @GetMapping("/work/designer/{designerId}")
    public R<List<Work>> getDesignerWork(
        @Parameter(description = "设计师ID") @PathVariable Long designerId) {
        
        if (!permissionUtils.isValidDesignerId(designerId)) {
            return R.fail("设计师ID无效");
        }
        
        List<Work> works = workService.selectWorkByDesignerId(designerId);
        return R.ok(works);
    }

    // ========== 获奖记录管理接口 ==========

    /**
     * 查询获奖记录列表（权限控制返回范围）
     */
    @Operation(summary = "查询获奖记录列表", description = "根据权限返回相应范围的获奖记录数据")
    @GetMapping("/award/list")
    public R<List<Award>> getAwardList() {
        if (LoginHelper.isSuperAdmin()) {
            return R.ok(awardService.selectAwardList(new Award()).getRows());
        } else {
            Long designerId = permissionUtils.getCurrentDesignerIdSafely();
            if (designerId == null) {
                return R.fail("用户未绑定设计师身份");
            }
            List<Award> awards = awardService.selectAwardByDesignerId(designerId);
            return R.ok(awards);
        }
    }

    /**
     * 新增获奖记录
     */
    @Operation(summary = "新增获奖记录", description = "为当前用户添加获奖记录")
    @Log(title = "获奖记录", businessType = BusinessType.INSERT)
    @PostMapping("/award")
    public R<Map<String, Object>> addAward(@Validated @RequestBody Award award) {
        Long designerId = permissionUtils.getCurrentDesignerIdSafely();
        if (designerId == null) {
            return R.fail("用户未绑定设计师身份");
        }
        award.setDesignerId(designerId);
        boolean result = awardService.insertAward(award);
        if (result && award.getAwardId() != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("awardId", award.getAwardId());
            return R.ok(data);
        } else {
            return R.fail("新增失败");
        }
    }

    /**
     * 修改获奖记录
     */
    @Operation(summary = "修改获奖记录", description = "修改指定的获奖记录信息")
    @Log(title = "获奖记录", businessType = BusinessType.UPDATE)
    @PutMapping("/award/{awardId}")
    public R<Void> editAward(
        @Parameter(description = "获奖记录ID") @PathVariable Long awardId,
        @Validated @RequestBody Award award) {
        
        Award existing = awardService.selectAwardById(awardId);
        if (existing == null) {
            return R.fail("获奖记录不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限编辑此获奖记录");
        }
        
        award.setAwardId(awardId);
        award.setDesignerId(existing.getDesignerId());
        
        return toAjax(awardService.updateAward(award));
    }

    /**
     * 删除获奖记录
     */
    @Operation(summary = "删除获奖记录", description = "删除指定的获奖记录")
    @Log(title = "获奖记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/award/{awardId}")
    public R<Void> removeAward(@Parameter(description = "获奖记录ID") @PathVariable Long awardId) {
        Award existing = awardService.selectAwardById(awardId);
        if (existing == null) {
            return R.fail("获奖记录不存在");
        }
        
        if (!permissionUtils.hasPermissionToEdit(existing.getDesignerId())) {
            return R.fail("无权限删除此获奖记录");
        }
        
        Long currentUserId = LoginHelper.getUserId();
        Date currentTime = new Date();
        return toAjax(awardService.logicDeleteAwardById(awardId, currentUserId, currentTime));
    }

    /**
     * 查询指定设计师的获奖记录（公开访问）
     */
    @Operation(summary = "查询设计师获奖记录", description = "查询指定设计师的获奖记录信息")
    @GetMapping("/award/designer/{designerId}")
    public R<List<Award>> getDesignerAward(
        @Parameter(description = "设计师ID") @PathVariable Long designerId) {
        
        if (!permissionUtils.isValidDesignerId(designerId)) {
            return R.fail("设计师ID无效");
        }
        
        List<Award> awards = awardService.selectAwardByDesignerId(designerId);
        return R.ok(awards);
    }

    // ========== 聚合查询接口 ==========

    /**
     * 查询设计师完整档案（聚合API）- 优化版本
     */
    @Operation(
        summary = "查询设计师完整档案", 
        description = "一次性获取设计师的完整详情信息，包括基本信息、作品集、工作经历、教育背景、获奖情况",
        parameters = @Parameter(name = "designerId", description = "设计师ID", required = true, example = "1")
    )
    @GetMapping("/designer/{designerId}/complete")
    public R<CompleteProfileVo> getDesignerComplete(@PathVariable Long designerId) {
        try {
            // 权限验证逻辑
            Long userId = LoginHelper.getUserId();
            if (!LoginHelper.isSuperAdmin()) {
                if (permissionUtils.isDesigner()) {
                    // 设计师只能查看自己的详情
                    Long currentDesignerId = permissionUtils.getCurrentDesignerIdSafely();
                    if (currentDesignerId == null || !currentDesignerId.equals(designerId)) {
                        return R.fail("权限不足：只能查看自己的设计师信息");
                    }
                } else if (permissionUtils.isSchool()) {
                    // 院校管理员只能查看本校设计师
                    Designer designerInfo = designerService.selectDesignerById(designerId);
                    if (designerInfo == null) {
                        return R.fail("设计师不存在");
                    }
                    Long schoolId = permissionUtils.getCurrentSchoolId();
                    if (designerInfo.getSchoolId() == null || !designerInfo.getSchoolId().equals(schoolId)) {
                        return R.fail("权限不足：只能查看本校设计师信息");
                    }
                }
                // 企业管理员可以查看所有公开信息，无需额外检查
            }

            // 获取设计师基本信息
            Designer designer = designerService.selectDesignerById(designerId);
            if (designer == null) {
                return R.fail("设计师不存在");
            }

            // 并行获取相关数据以提升性能
            CompletableFuture<List<Work>> worksFuture = CompletableFuture
                .supplyAsync(() -> workService.selectWorkByDesignerId(designerId));

            CompletableFuture<List<WorkExperience>> workExpFuture = CompletableFuture
                .supplyAsync(() -> workExperienceService.selectWorkExperienceByDesignerId(designerId));

            CompletableFuture<List<Education>> educationFuture = CompletableFuture
                .supplyAsync(() -> educationService.selectEducationByDesignerId(designerId));

            CompletableFuture<List<Award>> awardsFuture = CompletableFuture
                .supplyAsync(() -> awardService.selectAwardByDesignerId(designerId));

            // 等待所有异步任务完成
            CompletableFuture.allOf(worksFuture, workExpFuture, educationFuture, awardsFuture).join();

            // 构造返回数据
            CompleteProfileVo profile = new CompleteProfileVo();
            profile.setDesigner(designer);
            profile.setWorks(worksFuture.get());
            profile.setWorkExperiences(workExpFuture.get());
            profile.setEducations(educationFuture.get());
            profile.setAwards(awardsFuture.get());

            return R.ok(profile);
        } catch (Exception e) {
            log.error("获取设计师完整信息失败，设计师ID: {}", designerId, e);
            return R.fail("获取设计师信息失败");
        }
    }

    // ========== 档案完整度接口 ==========

    /**
     * 获取用户档案完整度
     */
    @Operation(summary = "获取档案完整度", description = "计算当前用户的档案完整度并提供改进建议")
    @GetMapping("/profile/completeness")
    public R<ProfileCompletenessVo> getProfileCompleteness() {
        Long userId = LoginHelper.getUserId();
        
        ProfileCompletenessVo completeness = new ProfileCompletenessVo();
        
        // 检查用户绑定的身份类型
        List<UserBinding> bindings = userBindingService.getBindingsByUserId(userId);
        
        for (UserBinding binding : bindings) {
            if (!"1".equals(binding.getBindingStatus())) continue; // 只处理有效绑定
            
            if ("designer".equals(binding.getEntityType())) {
                DesignerCompletenessVo designerCompleteness = calculateDesignerCompleteness(binding.getEntityId());
                completeness.setDesigner(designerCompleteness);
                break;
            }
        }
        
        return R.ok(completeness);
    }

    /**
     * 计算设计师档案完整度
     */
    private DesignerCompletenessVo calculateDesignerCompleteness(Long designerId) {
        Designer designer = designerService.selectDesignerById(designerId);
        
        DesignerCompletenessVo completeness = new DesignerCompletenessVo();
        
        // 基础信息完整度 (权重40%)
        int basicScore = 0;
        if (StringUtils.isNotBlank(designer.getDesignerName())) basicScore += 20;
        if (StringUtils.isNotBlank(designer.getPhone())) basicScore += 20;
        if (StringUtils.isNotBlank(designer.getEmail())) basicScore += 20;
        if (StringUtils.isNotBlank(designer.getProfession())) basicScore += 20;
        if (StringUtils.isNotBlank(designer.getDescription())) basicScore += 20;
        completeness.setBasicInfo(basicScore);
        
        // 作品集完整度 (权重25%)
        List<Work> works = workService.selectWorkByDesignerId(designerId);
        int workScore = Math.min(works.size() * 10, 100);
        completeness.setPortfolio(workScore);
        
        // 工作经历完整度 (权重20%)
        List<WorkExperience> experiences = workExperienceService.selectWorkExperienceByDesignerId(designerId);
        int expScore = Math.min(experiences.size() * 25, 100);
        completeness.setExperience(expScore);
        
        // 教育背景完整度 (权重15%)
        List<Education> educations = educationService.selectEducationByDesignerId(designerId);
        int eduScore = Math.min(educations.size() * 50, 100);
        completeness.setEducation(eduScore);
        
        // 计算总体完整度
        int overall = (int) (basicScore * 0.4 + workScore * 0.25 + expScore * 0.2 + eduScore * 0.15);
        completeness.setOverall(overall);
        
        // 生成改进建议
        completeness.setSuggestions(generateImprovementSuggestions(completeness));
        
        return completeness;
    }

    /**
     * 生成改进建议
     */
    private List<String> generateImprovementSuggestions(DesignerCompletenessVo completeness) {
        List<String> suggestions = new ArrayList<>();
        
        if (completeness.getBasicInfo() < 80) {
            suggestions.add("完善基础信息：建议补充个人简介、联系方式和职业技能");
        }
        
        if (completeness.getPortfolio() < 50) {
            suggestions.add("上传作品集：至少上传5个代表性作品以展示您的设计能力");
        }
        
        if (completeness.getExperience() < 50) {
            suggestions.add("添加工作经历：详细的工作经历有助于企业了解您的职业背景");
        }
        
        if (completeness.getEducation() < 50) {
            suggestions.add("补充教育背景：学历信息能够展示您的专业基础");
        }
        
        return suggestions;
    }
} 