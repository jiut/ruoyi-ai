package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.annotation.SaCheckPermission;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.core.constant.UserConstants;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.*;
import org.ruoyi.designer.domain.enums.UnbindResult;
import org.ruoyi.designer.domain.enums.UserEntityType;
import org.ruoyi.designer.domain.vo.DesignerCompletenessVo;
import org.ruoyi.designer.domain.vo.EnterpriseCompletenessVo;
import org.ruoyi.designer.domain.vo.ProfileCompletenessVo;
import org.ruoyi.designer.domain.vo.SchoolCompletenessVo;
import org.ruoyi.designer.service.*;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户注册和绑定Controller
 *
 * @author ruoyi
 */
@Tag(name = "用户身份管理", description = "用户注册设计师、企业、院校身份，支持创建新实体或绑定已有实体")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/user")
public class UserRegistrationController extends BaseController {

    private final IUserBindingService userBindingService;
    private final IDesignerService designerService;
    private final IEnterpriseService enterpriseService;
    private final ISchoolService schoolService;
    private final IEducationService educationService;
    private final IWorkExperienceService workExperienceService;
    private final IWorkService workService;
    private final IAwardWorkService awardWorkService;
    private final ICourseGroupService courseGroupService;

    /**
     * 验证用户角色权限
     * @param requiredRoleKey 需要的角色key
     * @param roleName 角色名称（用于错误提示）
     * @return 验证结果
     */
    private R<Void> validateUserRole(String requiredRoleKey, String roleName) {
        // 检查用户是否具有指定角色
        boolean hasRole = LoginHelper.getLoginUser().getRolePermission().contains(requiredRoleKey) ||
                         LoginHelper.isSuperAdmin();
        
        if (!hasRole) {
            return R.fail("权限不足：只有" + roleName + "角色才能注册对应身份");
        }
        
        return R.ok();
    }

    /**
     * 注册设计师并绑定用户
     */
    @Operation(
        summary = "注册设计师身份", 
        description = "用户注册设计师身份并自动绑定到当前登录用户",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "设计师注册信息",
            required = true,
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Designer.class),
                examples = @ExampleObject(
                    name = "设计师注册示例",
                    summary = "基础设计师信息",
                    value = """
                        {
                            "designerName": "张三",
                            "avatar": "https://avatars.githubusercontent.com/u/27265998",
                            "gender": "0",
                            "birthDate": "1995-06-15",
                            "phone": "13800138000",
                            "email": "zhangsan@example.com",
                            "description": "专业UI设计师，擅长原型设计和视觉设计",
                            "profession": "UI_UX_DESIGNER",
                            "skillTags": "[\\"prototype_design\\", \\"visual_design\\"]",
                            "workYears": 3,
                            "graduationDate": "2022-06-30",
                            "portfolioUrl": "https://portfolio.example.com",
                            "socialLinks": "{\"github\":\"https://github.com/zhangsan\",\"behance\":\"https://behance.net/zhangsan\"}"
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "注册成功"),
            @ApiResponse(responseCode = "400", description = "用户已绑定设计师身份"),
            @ApiResponse(responseCode = "403", description = "权限不足，只有设计师角色才能注册设计师身份"),
            @ApiResponse(responseCode = "500", description = "注册失败")
        }
    )
    @Log(title = "设计师注册", businessType = BusinessType.INSERT)
    @PostMapping("/register/designer")
    public R<Void> registerDesigner(@Validated @RequestBody Designer designer) {
        // 1. 验证用户角色权限 - 只有设计师角色才能注册设计师身份
        R<Void> roleValidation = validateUserRole("designer", "设计师");
        if (!R.isSuccess(roleValidation)) {
            return roleValidation;
        }

        Long userId = LoginHelper.getUserId();
        
        // 2. 检查用户是否已经绑定了设计师（只检查有效绑定）
        if (userBindingService.isUserBoundToEntityType(userId, UserEntityType.DESIGNER)) {
            return R.fail("用户已绑定设计师身份");
        }
        
        // 检查是否有历史绑定记录（包括解绑状态）
        UserBinding existingBinding = userBindingService.getBindingByUserIdAndEntityTypeAllStatus(userId, UserEntityType.DESIGNER);
        if (existingBinding != null && "0".equals(existingBinding.getBindingStatus())) {
            // 如果有解绑记录，更新现有设计师信息并重新激活绑定
            Long existingDesignerId = existingBinding.getEntityId();
            Designer existingDesigner = designerService.selectDesignerById(existingDesignerId);
            if (existingDesigner != null) {
                // 更新设计师信息
                designer.setDesignerId(existingDesignerId);
                designer.setUserId(userId);
                if (designerService.updateDesigner(designer)) {
                    // 重新激活绑定关系
                    userBindingService.bindUserToEntity(userId, UserEntityType.DESIGNER, existingDesignerId);
                    return R.ok();
                }
            }
        }
        
        // 设置用户ID
        designer.setUserId(userId);
        
        // 保存设计师信息
        if (designerService.insertDesigner(designer)) {
            // 创建用户绑定关系
            userBindingService.bindUserToEntity(userId, UserEntityType.DESIGNER, designer.getDesignerId());
            return R.ok();
        }
        
        return R.fail("注册失败");
    }

    /**
     * 注册企业并绑定用户
     */
    @Operation(
        summary = "注册企业身份",
        description = "用户注册企业身份并自动绑定到当前登录用户",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "企业注册信息",
            required = true,
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Enterprise.class),
                examples = @ExampleObject(
                    name = "企业注册示例",
                    value = """
                        {
                            "enterpriseName": "创新科技有限公司",
                            "description": "专注于互联网产品设计与开发",
                            "industry": "智能硬件",
                            "scale": "5000-10000人",
                            "address": "北京市朝阳区",
                            "email": "hr@innovation.com",
                            "phone": "010-12345678",
                            "website": "https://www.innovation.com"
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "注册成功"),
            @ApiResponse(responseCode = "400", description = "用户已绑定企业身份或企业名称已存在"),
            @ApiResponse(responseCode = "403", description = "权限不足，只有企业管理员角色才能注册企业身份"),
            @ApiResponse(responseCode = "500", description = "注册失败")
        }
    )
    @Log(title = "企业注册", businessType = BusinessType.INSERT)
    @PostMapping("/register/enterprise")
    public R<Void> registerEnterprise(@Validated @RequestBody Enterprise enterprise) {
        // 1. 验证用户角色权限 - 只有企业管理员角色才能注册企业身份
        R<Void> roleValidation = validateUserRole("enterprise", "企业管理员");
        if (!R.isSuccess(roleValidation)) {
            return roleValidation;
        }

        Long userId = LoginHelper.getUserId();
        
        // 2. 检查用户是否已经绑定了企业
        if (userBindingService.isUserBoundToEntityType(userId, UserEntityType.ENTERPRISE)) {
            return R.fail("用户已绑定企业身份");
        }
        
        // 检查企业名称是否已存在
        if (StringUtils.isNotBlank(enterprise.getEnterpriseName()) && 
            enterpriseService.existsByEnterpriseName(enterprise.getEnterpriseName())) {
            return R.fail("企业名称已存在，请更换企业名称");
        }
        
        // 设置用户ID
        enterprise.setUserId(userId);
        
        // 保存企业信息
        if (enterpriseService.insertEnterprise(enterprise)) {
            // 创建用户绑定关系
            userBindingService.bindUserToEntity(userId, UserEntityType.ENTERPRISE, enterprise.getEnterpriseId());
            return R.ok();
        }
        
        return R.fail("注册失败");
    }

    /**
     * 注册院校并绑定用户
     */
    @Operation(
        summary = "注册院校身份",
        description = "用户注册院校身份并自动绑定到当前登录用户",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "院校注册信息",
            required = true,
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = School.class),
                examples = @ExampleObject(
                    name = "院校注册示例",
                    value = """
                        {
                            "schoolName": "北京设计学院",
                            "schoolType": "COMPREHENSIVE",
                            "level": "UNDERGRADUATE",
                            "address": "北京市海淀区",
                            "description": "专业的设计教育机构"
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "注册成功"),
            @ApiResponse(responseCode = "400", description = "用户已绑定院校身份或院校名称已存在"),
            @ApiResponse(responseCode = "403", description = "权限不足，只有院校管理员角色才能注册院校身份"),
            @ApiResponse(responseCode = "500", description = "注册失败")
        }
    )
    @Log(title = "院校注册", businessType = BusinessType.INSERT)
    @PostMapping("/register/school")
    public R<Void> registerSchool(@Validated @RequestBody School school) {
        // 1. 验证用户角色权限 - 只有院校管理员角色才能注册院校身份
        R<Void> roleValidation = validateUserRole("school", "院校管理员");
        if (!R.isSuccess(roleValidation)) {
            return roleValidation;
        }

        Long userId = LoginHelper.getUserId();
        
        // 2. 检查用户是否已经绑定了院校
        if (userBindingService.isUserBoundToEntityType(userId, UserEntityType.SCHOOL)) {
            return R.fail("用户已绑定院校身份");
        }
        
        // 检查院校名称是否已存在
        if (StringUtils.isNotBlank(school.getSchoolName()) && 
            schoolService.existsBySchoolName(school.getSchoolName())) {
            return R.fail("院校名称已存在，请更换院校名称");
        }
        
        // 设置用户ID
        school.setUserId(userId);
        
        // 保存院校信息
        if (schoolService.insertSchool(school)) {
            // 创建用户绑定关系
            userBindingService.bindUserToEntity(userId, UserEntityType.SCHOOL, school.getSchoolId());
            return R.ok();
        }
        
        return R.fail("注册失败");
    }

    /**
     * 获取当前用户的绑定信息
     */
    @Operation(
        summary = "获取用户绑定信息", 
        description = "获取当前用户的所有身份绑定信息，包括设计师、企业、院校等身份",
        responses = {
            @ApiResponse(responseCode = "200", description = "获取成功",
                        content = @Content(schema = @Schema(implementation = UserBinding.class))),
            @ApiResponse(responseCode = "401", description = "用户未登录")
        }
    )
    @GetMapping("/bindings")
    public R<List<UserBinding>> getCurrentUserBindings() {
        Long userId = LoginHelper.getUserId();
        List<UserBinding> bindings = userBindingService.getBindingsByUserId(userId);
        return R.ok(bindings);
    }

        /**
     * 获取当前用户绑定的设计师信息
     */
    @Operation(
        summary = "获取设计师档案",
        description = "获取当前用户绑定的设计师信息",
        responses = {
            @ApiResponse(responseCode = "200", description = "获取成功",
                        content = @Content(schema = @Schema(implementation = Designer.class))),
            @ApiResponse(responseCode = "400", description = "用户未绑定设计师身份")
        }
    )
    @GetMapping("/designer/profile")
    public R<Designer> getCurrentDesignerProfile() {
        Long userId = LoginHelper.getUserId();
        Long designerId = userBindingService.getDesignerIdByUserId(userId);
        
        if (designerId == null) {
            return R.fail("用户未绑定设计师身份");
        }
        
        Designer designer = designerService.selectDesignerById(designerId);
        return R.ok(designer);
    }

    /**
     * 更新当前用户绑定的设计师信息
     */
    @Operation(
        summary = "更新设计师档案",
        description = "更新当前用户绑定的设计师信息，设计师只能编辑自己的信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "设计师信息（无需提供designerId和userId）",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Designer.class),
                examples = @ExampleObject(
                    name = "更新设计师档案示例",
                    value = """
                        {
                            "designerName": "张三",
                            "avatar": "https://avatars.example.com/user.jpg",
                            "gender": "0", 
                            "birthDate": "1995-06-15",
                            "phone": "13800138000",
                            "email": "zhangsan@example.com",
                            "description": "专业UI设计师，擅长原型设计和视觉设计",
                            "profession": "UI_UX_DESIGNER",
                            "skillTags": "[\\"prototype_design\\", \\"visual_design\\"]",
                            "workYears": 3,
                            "portfolioUrl": "https://portfolio.example.com",
                            "socialLinks": "{\\"github\\":\\"https://github.com/zhangsan\\",\\"behance\\":\\"https://behance.net/zhangsan\\"}"
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "用户未绑定设计师身份或更新失败")
        }
    )
    @PutMapping("/designer/profile")
    public R<Void> updateDesignerProfile(@Validated @RequestBody Designer designer) {
        Long userId = LoginHelper.getUserId();
        Long designerId = userBindingService.getDesignerIdByUserId(userId);
        
        if (designerId == null) {
            return R.fail("用户未绑定设计师身份");
        }
        
        // 设置设计师ID和用户ID（防止恶意修改）
        designer.setDesignerId(designerId);
        designer.setUserId(userId);
        
        // 调用设计师服务更新信息
        if (designerService.updateDesigner(designer)) {
            return R.ok();
        } else {
            return R.fail("更新设计师信息失败");
        }
    }

    /**
     * 获取当前用户绑定的企业信息
     */
    @Operation(
        summary = "获取企业档案",
        description = "获取当前用户绑定的企业信息",
        responses = {
            @ApiResponse(responseCode = "200", description = "获取成功",
                        content = @Content(schema = @Schema(implementation = Enterprise.class))),
            @ApiResponse(responseCode = "400", description = "用户未绑定企业身份")
        }
    )
    @GetMapping("/enterprise/profile")
    public R<Enterprise> getCurrentEnterpriseProfile() {
        Long userId = LoginHelper.getUserId();
        Long enterpriseId = userBindingService.getEnterpriseIdByUserId(userId);
        
        if (enterpriseId == null) {
            return R.fail("用户未绑定企业身份");
        }
        
        Enterprise enterprise = enterpriseService.selectEnterpriseById(enterpriseId);
        return R.ok(enterprise);
    }

    /**
     * 获取当前用户绑定的院校信息
     */
    @Operation(
        summary = "获取院校档案",
        description = "获取当前用户绑定的院校信息",
        responses = {
            @ApiResponse(responseCode = "200", description = "获取成功",
                        content = @Content(schema = @Schema(implementation = School.class))),
            @ApiResponse(responseCode = "400", description = "用户未绑定院校身份")
        }
    )
    @GetMapping("/school/profile")
    public R<School> getCurrentSchoolProfile() {
        Long userId = LoginHelper.getUserId();
        Long schoolId = userBindingService.getSchoolIdByUserId(userId);
        
        if (schoolId == null) {
            return R.fail("用户未绑定院校身份");
        }
        
        School school = schoolService.selectSchoolById(schoolId);
        return R.ok(school);
    }

    /**
     * 更新当前用户绑定的企业信息
     */
    @Operation(
        summary = "更新企业档案",
        description = "更新当前用户绑定的企业信息，企业管理员只能编辑自己的企业信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "企业信息（无需提供enterpriseId和userId）",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Enterprise.class),
                examples = @ExampleObject(
                    name = "更新企业档案示例",
                    value = """
                        {
                            "enterpriseName": "创新科技有限公司",
                            "logo": "https://logos.example.com/enterprise.jpg",
                            "industry": "互联网",
                            "scale": "100-500人",
                            "address": "北京市朝阳区创新大厦",
                            "phone": "010-12345678",
                            "email": "contact@innovation.com",
                            "website": "https://www.innovation.com",
                            "description": "专注于互联网产品设计与开发的创新型企业"
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "用户未绑定企业身份或更新失败")
        }
    )
    @PutMapping("/enterprise/profile")
    public R<Void> updateEnterpriseProfile(@Validated @RequestBody Enterprise enterprise) {
        Long userId = LoginHelper.getUserId();
        Long enterpriseId = userBindingService.getEnterpriseIdByUserId(userId);
        
        if (enterpriseId == null) {
            return R.fail("用户未绑定企业身份");
        }
        
        // 设置企业ID和用户ID（防止恶意修改）
        enterprise.setEnterpriseId(enterpriseId);
        enterprise.setUserId(userId);
        
        // 调用企业服务更新信息
        if (enterpriseService.updateEnterprise(enterprise)) {
            return R.ok();
        } else {
            return R.fail("更新企业信息失败");
        }
    }

    /**
     * 更新当前用户绑定的院校信息
     */
    @Operation(
        summary = "更新院校档案",
        description = "更新当前用户绑定的院校信息，院校管理员只能编辑自己的院校信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "院校信息（无需提供schoolId和userId）",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = School.class),
                examples = @ExampleObject(
                    name = "更新院校档案示例",
                    value = """
                        {
                            "schoolName": "北京设计学院",
                            "logo": "https://logos.example.com/school.jpg",
                            "schoolType": "COMPREHENSIVE",
                            "level": "UNDERGRADUATE",
                            "address": "北京市海淀区学院路88号",
                            "phone": "010-88888888",
                            "email": "info@bjdesign.edu.cn",
                            "website": "https://www.bjdesign.edu.cn",
                            "description": "专业的设计教育机构，培养优秀设计人才"
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "用户未绑定院校身份或更新失败")
        }
    )
    @PutMapping("/school/profile")
    public R<Void> updateSchoolProfile(@Validated @RequestBody School school) {
        Long userId = LoginHelper.getUserId();
        Long schoolId = userBindingService.getSchoolIdByUserId(userId);
        
        if (schoolId == null) {
            return R.fail("用户未绑定院校身份");
        }
        
        // 设置院校ID和用户ID（防止恶意修改）
        school.setSchoolId(schoolId);
        school.setUserId(userId);
        
        // 调用院校服务更新信息
        if (schoolService.updateSchool(school)) {
            return R.ok();
        } else {
            return R.fail("更新院校信息失败");
        }
    }

    /**
     * 解绑用户身份
     * 用户可以自行解绑自己的身份，无需特殊权限
     */
    @Operation(
        summary = "解绑用户身份",
        description = "用户可以自行解绑自己的身份，支持解绑企业或院校身份",
        parameters = {
            @Parameter(name = "entityType", description = "实体类型", required = true, 
                      example = "enterprise", 
                      schema = @Schema(allowableValues = {"enterprise", "school"}))
        },
        responses = {
            @ApiResponse(responseCode = "200", description = "解绑成功"),
            @ApiResponse(responseCode = "400", description = "用户未绑定该身份或已处于解绑状态"),
            @ApiResponse(responseCode = "500", description = "解绑失败")
        }
    )
    @SaCheckLogin
    @Log(title = "解绑用户身份", businessType = BusinessType.UPDATE)
    @PutMapping("/unbind/{entityType}")
    public R<Void> unbindUserIdentity(@PathVariable String entityType) {
        Long userId = LoginHelper.getUserId();
        
        UserEntityType type = UserEntityType.getByCode(entityType);
        if (type == null) {
            return R.fail("无效的实体类型");
        }
        
        UnbindResult result = userBindingService.unbindUserFromEntityWithResult(userId, type);
        
        switch (result) {
            case SUCCESS:
                return R.ok("解绑成功");
            case NOT_BOUND:
                return R.fail("用户未绑定该身份，无需解绑");
            case ALREADY_UNBOUND:
                return R.fail("用户已经处于解绑状态");
            case FAILED:
            default:
                return R.fail("解绑失败");
        }
    }

    /**
     * 管理员绑定用户与实体
     */
    @Operation(
        summary = "管理员绑定用户实体",
        description = "管理员可以将任意用户绑定到指定的实体（设计师、企业或院校）",
        parameters = {
            @Parameter(name = "userId", description = "用户ID", required = true, example = "123"),
            @Parameter(name = "entityType", description = "实体类型", required = true, 
                      example = "enterprise",
                      schema = @Schema(allowableValues = {"designer", "enterprise", "school"})),
            @Parameter(name = "entityId", description = "实体ID", required = true, example = "1")
        },
        responses = {
            @ApiResponse(responseCode = "200", description = "绑定成功"),
            @ApiResponse(responseCode = "400", description = "无效的实体类型"),
            @ApiResponse(responseCode = "403", description = "权限不足"),
            @ApiResponse(responseCode = "500", description = "绑定失败")
        }
    )
    @SaCheckPermission("designer:user:bind")
    @Log(title = "绑定用户实体", businessType = BusinessType.INSERT)
    @PostMapping("/bind")
    public R<Void> bindUserToEntity(@RequestParam Long userId,
                                    @RequestParam String entityType,
                                    @RequestParam Long entityId) {
        UserEntityType type = UserEntityType.getByCode(entityType);
        if (type == null) {
            return R.fail("无效的实体类型");
        }
        
        if (userBindingService.bindUserToEntity(userId, type, entityId)) {
            return R.ok();
        }
        
        return R.fail("绑定失败");
    }

    /**
     * 绑定已有企业
     * 用户可以选择绑定到已有的企业
     */
    @Operation(
        summary = "绑定已有企业",
        description = "用户绑定到已有的企业（需要企业邀请码或管理员权限）",
        parameters = {
            @Parameter(name = "enterpriseId", description = "企业ID", required = true, example = "1"),
            @Parameter(name = "inviteCode", description = "企业邀请码（可选）", example = "INVITE123")
        },
        responses = {
            @ApiResponse(responseCode = "200", description = "绑定企业成功"),
            @ApiResponse(responseCode = "400", description = "用户已绑定企业身份或企业不存在"),
            @ApiResponse(responseCode = "500", description = "绑定失败")
        }
    )
    @Log(title = "绑定已有企业", businessType = BusinessType.INSERT)
    @PostMapping("/bind/enterprise")
    public R<Void> bindToExistingEnterprise(@RequestParam Long enterpriseId,
                                            @RequestParam(required = false) String inviteCode) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否已经绑定了企业
        if (userBindingService.isUserBoundToEntityType(userId, UserEntityType.ENTERPRISE)) {
            return R.fail("用户已绑定企业身份，请先解绑后再绑定");
        }
        
        // 验证企业是否存在
        Enterprise enterprise = enterpriseService.selectEnterpriseById(enterpriseId);
        if (enterprise == null) {
            return R.fail("企业不存在");
        }
        
        // TODO: 这里可以添加邀请码验证逻辑
        // if (StringUtils.isNotBlank(inviteCode)) {
        //     if (!validateInviteCode(enterpriseId, inviteCode)) {
        //         return R.fail("邀请码无效");
        //     }
        // }
        
        // 绑定用户到企业
        if (userBindingService.bindUserToEntity(userId, UserEntityType.ENTERPRISE, enterpriseId)) {
            return R.ok("绑定企业成功");
        }
        
        return R.fail("绑定失败");
    }

    /**
     * 绑定已有院校
     * 用户可以选择绑定到已有的院校
     */
    @Operation(
        summary = "绑定已有院校",
        description = "用户绑定到已有的院校（通常用于学生身份验证）",
        parameters = {
            @Parameter(name = "schoolId", description = "院校ID", required = true, example = "1"),
            @Parameter(name = "studentId", description = "学号（可选）", example = "2020001234")
        },
        responses = {
            @ApiResponse(responseCode = "200", description = "绑定院校成功"),
            @ApiResponse(responseCode = "400", description = "用户已绑定院校身份或院校不存在"),
            @ApiResponse(responseCode = "500", description = "绑定失败")
        }
    )
    @Log(title = "绑定已有院校", businessType = BusinessType.INSERT)
    @PostMapping("/bind/school")
    public R<Void> bindToExistingSchool(@RequestParam Long schoolId,
                                        @RequestParam(required = false) String studentId) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否已经绑定了院校
        if (userBindingService.isUserBoundToEntityType(userId, UserEntityType.SCHOOL)) {
            return R.fail("用户已绑定院校身份，请先解绑后再绑定");
        }
        
        // 验证院校是否存在
        School school = schoolService.selectSchoolById(schoolId);
        if (school == null) {
            return R.fail("院校不存在");
        }
        
        // TODO: 这里可以添加学生身份验证逻辑
        // if (StringUtils.isNotBlank(studentId)) {
        //     if (!validateStudentId(schoolId, studentId)) {
        //         return R.fail("学号验证失败");
        //     }
        // }
        
        // 绑定用户到院校
        if (userBindingService.bindUserToEntity(userId, UserEntityType.SCHOOL, schoolId)) {
            return R.ok("绑定院校成功");
        }
        
        return R.fail("绑定失败");
    }

    /**
     * 获取可绑定的企业列表
     * 返回系统中所有可用的企业供用户选择
     */
    @Operation(
        summary = "获取可绑定企业列表",
        description = "获取系统中所有可用的企业列表，支持分页查询和名称模糊搜索",
        parameters = {
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10"),
            @Parameter(name = "enterpriseName", description = "企业名称（模糊查询）", example = "科技")
        },
        responses = {
            @ApiResponse(responseCode = "200", description = "查询成功",
                        content = @Content(schema = @Schema(implementation = Enterprise.class))),
            @ApiResponse(responseCode = "401", description = "用户未登录")
        }
    )
    @GetMapping("/available/enterprises")
    public R<TableDataInfo<Enterprise>> getAvailableEnterprises(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String enterpriseName) {
        
        PageQuery pageQuery = new PageQuery(pageSize, pageNum);
        
        Enterprise queryEnterprise = new Enterprise();
        if (StringUtils.isNotBlank(enterpriseName)) {
            queryEnterprise.setEnterpriseName(enterpriseName);
        }
        
        TableDataInfo<Enterprise> result = enterpriseService.selectEnterpriseList(queryEnterprise, pageQuery);
        return R.ok(result);
    }

    /**
     * 获取可绑定的院校列表
     * 返回系统中所有可用的院校供用户选择
     */
    @Operation(
        summary = "获取可绑定院校列表",
        description = "获取系统中所有可用的院校列表，支持分页查询和名称模糊搜索",
        parameters = {
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10"),
            @Parameter(name = "schoolName", description = "院校名称（模糊查询）", example = "设计")
        },
        responses = {
            @ApiResponse(responseCode = "200", description = "查询成功",
                        content = @Content(schema = @Schema(implementation = School.class))),
            @ApiResponse(responseCode = "401", description = "用户未登录")
        }
    )
    @GetMapping("/available/schools")
    public R<TableDataInfo<School>> getAvailableSchools(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String schoolName) {
        
        PageQuery pageQuery = new PageQuery(pageSize, pageNum);
        
        School querySchool = new School();
        if (StringUtils.isNotBlank(schoolName)) {
            querySchool.setSchoolName(schoolName);
        }
        
        TableDataInfo<School> result = schoolService.selectSchoolList(querySchool, pageQuery);
        return R.ok(result);
    }

    // ==================== 信息补充相关接口 ====================

    /**
     * 获取用户档案完整度
     */
    // ==================== 设计师信息补充接口 ====================







    // ==================== 院校信息补充接口 ====================

    /**
     * 添加获奖作品展示
     */
    @Operation(
        summary = "添加获奖作品展示",
        description = "为当前用户绑定的院校添加获奖作品信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "获奖作品信息",
            required = true,
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = AwardWork.class),
                examples = @ExampleObject(
                    name = "获奖作品示例",
                    value = """
                        {
                            "title": "智能导盲系统设计",
                            "award": "2024 红点设计奖 · 最佳设计奖",
                            "description": "基于计算机视觉和触觉反馈的创新型导盲设备，为视障人士提供更安全、便捷的出行体验。"
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "添加成功"),
            @ApiResponse(responseCode = "400", description = "用户未绑定院校身份"),
            @ApiResponse(responseCode = "500", description = "添加失败")
        }
    )
    @Log(title = "添加获奖作品", businessType = BusinessType.INSERT)
    @PostMapping("/school/award-works")
    public R<Void> addAwardWork(@Validated @RequestBody AwardWork awardWork) {
        Long userId = LoginHelper.getUserId();
        
        // 获取院校身份
        UserBinding binding = userBindingService.getBindingByUserIdAndEntityType(userId, UserEntityType.SCHOOL);
        if (binding == null) {
            return R.fail("用户未绑定院校身份");
        }
        
        // 设置院校ID
        awardWork.setSchoolId(binding.getEntityId());
        
        // 保存获奖作品
        if (awardWorkService.save(awardWork)) {
            return R.ok();
        }
        
        return R.fail("添加失败");
    }

    /**
     * 设置课程体系
     */
    @Operation(
        summary = "设置课程体系",
        description = "为当前用户绑定的院校设置课程体系信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "课程体系信息",
            required = true,
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = CourseGroup.class),
                examples = @ExampleObject(
                    name = "课程体系示例",
                    value = """
                        {
                            "name": "基础理论课程",
                            "courses": ["设计史论", "艺术概论", "美学原理", "设计心理学"]
                        }
                        """
                )
            )
        ),
        responses = {
            @ApiResponse(responseCode = "200", description = "设置成功"),
            @ApiResponse(responseCode = "400", description = "用户未绑定院校身份"),
            @ApiResponse(responseCode = "500", description = "设置失败")
        }
    )
    @Log(title = "设置课程体系", businessType = BusinessType.INSERT)
    @PostMapping("/school/course-groups")
    public R<Void> addCourseGroup(@Validated @RequestBody CourseGroup courseGroup) {
        Long userId = LoginHelper.getUserId();
        
        // 获取院校身份
        UserBinding binding = userBindingService.getBindingByUserIdAndEntityType(userId, UserEntityType.SCHOOL);
        if (binding == null) {
            return R.fail("用户未绑定院校身份");
        }
        
        // 设置院校ID
        courseGroup.setSchoolId(binding.getEntityId());
        
        // 保存课程体系
        if (courseGroupService.save(courseGroup)) {
            return R.ok();
        }
        
        return R.fail("设置失败");
    }

    // ==================== 私有方法：完整度计算 ====================

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
        completeness.setSuggestions(generateDesignerSuggestions(completeness));

        return completeness;
    }

    /**
     * 计算企业档案完整度
     */
    private EnterpriseCompletenessVo calculateEnterpriseCompleteness(Long enterpriseId) {
        Enterprise enterprise = enterpriseService.selectEnterpriseById(enterpriseId);
        EnterpriseCompletenessVo completeness = new EnterpriseCompletenessVo();

        // 基础信息完整度 (权重60%)
        int basicScore = 0;
        if (StringUtils.isNotBlank(enterprise.getEnterpriseName())) basicScore += 25;
        if (StringUtils.isNotBlank(enterprise.getIndustry())) basicScore += 25;
        if (StringUtils.isNotBlank(enterprise.getScale())) basicScore += 25;
        if (StringUtils.isNotBlank(enterprise.getDescription())) basicScore += 25;
        completeness.setBasicInfo(basicScore);

        // 联系信息完整度 (权重25%)
        int contactScore = 0;
        if (StringUtils.isNotBlank(enterprise.getPhone())) contactScore += 25;
        if (StringUtils.isNotBlank(enterprise.getEmail())) contactScore += 25;
        if (StringUtils.isNotBlank(enterprise.getWebsite())) contactScore += 25;
        if (StringUtils.isNotBlank(enterprise.getAddress())) contactScore += 25;
        completeness.setContactInfo(contactScore);

        // 招聘信息完整度 (权重15%) - 这里可以扩展
        int recruitmentScore = 50; // 默认值，后续可以根据实际招聘信息计算
        completeness.setRecruitmentInfo(recruitmentScore);

        // 计算总体完整度
        int overall = (int) (basicScore * 0.6 + contactScore * 0.25 + recruitmentScore * 0.15);
        completeness.setOverall(overall);

        // 生成改进建议
        completeness.setSuggestions(generateEnterpriseSuggestions(completeness));

        return completeness;
    }

    /**
     * 计算院校档案完整度
     */
    private SchoolCompletenessVo calculateSchoolCompleteness(Long schoolId) {
        School school = schoolService.selectSchoolById(schoolId);
        SchoolCompletenessVo completeness = new SchoolCompletenessVo();

        // 基础信息完整度 (权重40%)
        int basicScore = 0;
        if (StringUtils.isNotBlank(school.getSchoolName())) basicScore += 25;
        if (StringUtils.isNotBlank(school.getSchoolType())) basicScore += 25;
        if (StringUtils.isNotBlank(school.getDescription())) basicScore += 25;
        if (StringUtils.isNotBlank(school.getAddress())) basicScore += 25;
        completeness.setBasicInfo(basicScore);

        // 课程体系完整度 (权重30%)
        List<CourseGroup> courseGroups = courseGroupService.getCourseGroupsBySchoolId(schoolId);
        int courseScore = Math.min(courseGroups.size() * 25, 100);
        completeness.setCourseSystem(courseScore);

        // 获奖作品完整度 (权重20%)
        List<AwardWork> awardWorks = awardWorkService.getBySchoolId(schoolId);
        int awardScore = Math.min(awardWorks.size() * 20, 100);
        completeness.setAwardWorks(awardScore);

        // 统计数据完整度 (权重10%) - 默认值
        int statsScore = 80; // 可以根据实际统计数据计算
        completeness.setStatisticsData(statsScore);

        // 计算总体完整度
        int overall = (int) (basicScore * 0.4 + courseScore * 0.3 + awardScore * 0.2 + statsScore * 0.1);
        completeness.setOverall(overall);

        // 生成改进建议
        completeness.setSuggestions(generateSchoolSuggestions(completeness));

        return completeness;
    }

    /**
     * 生成设计师改进建议
     */
    private List<String> generateDesignerSuggestions(DesignerCompletenessVo completeness) {
        List<String> suggestions = new java.util.ArrayList<>();
        
        if (completeness.getBasicInfo() < 80) {
            suggestions.add("完善基础信息：添加联系方式、职业类型、个人描述等");
        }
        if (completeness.getPortfolio() < 60) {
            suggestions.add("上传作品集：至少上传6个代表性作品展示您的设计能力");
        }
        if (completeness.getExperience() < 50) {
            suggestions.add("添加工作经历：详细描述您的工作经验和项目经历");
        }
        if (completeness.getEducation() < 100) {
            suggestions.add("补充教育背景：添加您的学历和专业培训经历");
        }
        
        return suggestions;
    }

    /**
     * 生成企业改进建议
     */
    private List<String> generateEnterpriseSuggestions(EnterpriseCompletenessVo completeness) {
        List<String> suggestions = new java.util.ArrayList<>();
        
        if (completeness.getBasicInfo() < 80) {
            suggestions.add("完善企业信息：补充行业类型、企业规模、公司描述等");
        }
        if (completeness.getContactInfo() < 70) {
            suggestions.add("完善联系方式：添加官方网站、联系电话、企业邮箱、办公地址");
        }
        if (completeness.getRecruitmentInfo() < 60) {
            suggestions.add("发布招聘信息：添加岗位需求，吸引优秀设计人才");
        }
        
        return suggestions;
    }

    /**
     * 生成院校改进建议
     */
    private List<String> generateSchoolSuggestions(SchoolCompletenessVo completeness) {
        List<String> suggestions = new java.util.ArrayList<>();
        
        if (completeness.getBasicInfo() < 80) {
            suggestions.add("完善院校信息：补充院校类型、办学层次、院校简介等");
        }
        if (completeness.getCourseSystem() < 60) {
            suggestions.add("设置课程体系：添加专业课程设置，展示教学特色");
        }
        if (completeness.getAwardWorks() < 40) {
            suggestions.add("展示获奖作品：上传学生获奖作品，体现教学成果");
        }
        if (completeness.getStatisticsData() < 80) {
            suggestions.add("完善统计数据：更新就业率、师资力量等关键数据");
        }
        
        return suggestions;
    }
} 