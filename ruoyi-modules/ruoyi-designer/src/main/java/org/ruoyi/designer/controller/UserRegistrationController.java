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
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.Designer;
import org.ruoyi.designer.domain.Enterprise;
import org.ruoyi.designer.domain.School;
import org.ruoyi.designer.domain.UserBinding;
import org.ruoyi.designer.domain.enums.UnbindResult;
import org.ruoyi.designer.domain.enums.UserEntityType;
import org.ruoyi.designer.service.*;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户注册和绑定Controller
 *
 * @author ruoyi
 */
@Tag(name = "用户身份注册", description = "用户注册设计师、企业、院校身份并进行绑定")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/user")
public class UserRegistrationController extends BaseController {

    private final IUserBindingService userBindingService;
    private final IDesignerService designerService;
    private final IEnterpriseService enterpriseService;
    private final ISchoolService schoolService;

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
                            "profession": "UI_DESIGNER",
                            "skillTags": "[\\"PROTOTYPE_DESIGN\\", \\"VISUAL_DESIGN\\"]",
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
            @ApiResponse(responseCode = "500", description = "注册失败")
        }
    )
    @Log(title = "设计师注册", businessType = BusinessType.INSERT)
    @PostMapping("/register/designer")
    public R<Void> registerDesigner(@Validated @RequestBody Designer designer) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否已经绑定了设计师（只检查有效绑定）
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
                            "industry": "互联网",
                            "scale": "100-500人",
                            "address": "北京市朝阳区",
                            "email": "hr@innovation.com",
                            "phone": "010-12345678",
                            "website": "https://www.innovation.com"
                        }
                        """
                )
            )
        )
    )
    @Log(title = "企业注册", businessType = BusinessType.INSERT)
    @PostMapping("/register/enterprise")
    public R<Void> registerEnterprise(@Validated @RequestBody Enterprise enterprise) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否已经绑定了企业
        if (userBindingService.isUserBoundToEntityType(userId, UserEntityType.ENTERPRISE)) {
            return R.fail("用户已绑定企业身份");
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
                            "schoolType": "UNIVERSITY",
                            "level": "本科",
                            "address": "北京市海淀区",
                            "description": "专业的设计教育机构"
                        }
                        """
                )
            )
        )
    )
    @Log(title = "院校注册", businessType = BusinessType.INSERT)
    @PostMapping("/register/school")
    public R<Void> registerSchool(@Validated @RequestBody School school) {
        Long userId = LoginHelper.getUserId();
        
        // 检查用户是否已经绑定了院校
        if (userBindingService.isUserBoundToEntityType(userId, UserEntityType.SCHOOL)) {
            return R.fail("用户已绑定院校身份");
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
    @Operation(summary = "获取用户绑定信息", description = "获取当前用户的所有身份绑定信息")
    @GetMapping("/bindings")
    public R<List<UserBinding>> getCurrentUserBindings() {
        Long userId = LoginHelper.getUserId();
        List<UserBinding> bindings = userBindingService.getBindingsByUserId(userId);
        return R.ok(bindings);
    }

    /**
     * 获取当前用户绑定的设计师信息
     */
    @Operation(summary = "获取设计师档案", description = "获取当前用户绑定的设计师信息")
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
     * 获取当前用户绑定的企业信息
     */
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
     * 解绑用户身份
     * 用户可以自行解绑自己的身份，无需特殊权限
     */
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
        description = "获取系统中所有可用的企业列表",
        parameters = {
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10"),
            @Parameter(name = "enterpriseName", description = "企业名称（模糊查询）")
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
        description = "获取系统中所有可用的院校列表",
        parameters = {
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10"),
            @Parameter(name = "schoolName", description = "院校名称（模糊查询）")
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
} 