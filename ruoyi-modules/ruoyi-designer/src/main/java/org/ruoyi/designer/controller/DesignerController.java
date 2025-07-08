package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.Designer;
import org.ruoyi.designer.domain.Work;
import org.ruoyi.designer.domain.WorkExperience;
import org.ruoyi.designer.domain.Education;
import org.ruoyi.designer.domain.Award;
import org.ruoyi.designer.domain.enums.DesignerProfession;
import org.ruoyi.designer.domain.enums.SkillTag;
import org.ruoyi.designer.service.IDesignerService;
import org.ruoyi.designer.service.IWorkService;
import org.ruoyi.designer.service.IWorkExperienceService;
import org.ruoyi.designer.service.IEducationService;
import org.ruoyi.designer.service.IAwardService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.beans.PropertyEditorSupport;
import lombok.Data;
import jakarta.validation.constraints.Pattern;

/**
 * 设计师管理Controller
 * 
 * 权限说明：
 * - 系统管理员：可以访问所有设计师管理接口
 * - 企业管理员：可以查看设计师公开信息（用于招聘）
 * - 院校管理员：可以查看本校设计师信息
 * - 设计师：只能查看自己的信息，个人档案管理请使用用户档案接口
 *
 * @author ruoyi
 */
@Tag(name = "设计师管理", description = "设计师信息的增删改查和相关操作")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/designer")
@Slf4j
public class DesignerController extends BaseController {

    private final IDesignerService designerService;
    private final IWorkService workService;
    private final IWorkExperienceService workExperienceService;
    private final IEducationService educationService;
    private final IAwardService awardService;
    private final DesignerPermissionUtils permissionUtils;

    /**
     * 检查当前用户是否有设计师查看权限
     * 根据权限矩阵，不同角色有不同的访问权限
     */
    private boolean hasDesignerViewPermission() {
        return LoginHelper.isSuperAdmin() || 
               permissionUtils.isEnterprise() || 
               permissionUtils.isSchool();
    }

    /**
     * 检查当前用户是否有设计师详情查看权限
     * 设计师可以查看自己的详情
     */
    private boolean hasDesignerDetailPermission() {
        return LoginHelper.isSuperAdmin() || 
               permissionUtils.isEnterprise() || 
               permissionUtils.isSchool() || 
               permissionUtils.isDesigner();
    }

    /**
     * 检查当前用户是否为系统管理员
     * 只有系统管理员才能进行增删改操作
     */
    private void checkAdminPermission() {
        if (!LoginHelper.isSuperAdmin()) {
            throw new RuntimeException("权限不足：设计师增删改操作仅限系统管理员访问");
        }
    }

    /**
     * 数据绑定初始化器
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // 自定义Date属性编辑器
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        
        // 自定义Map属性编辑器
        binder.registerCustomEditor(Map.class, "params", new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (text == null || text.trim().isEmpty()) {
                    setValue(new HashMap<String, Object>());
                } else {
                    // 这里可以添加JSON解析逻辑
                    setValue(new HashMap<String, Object>());
                }
            }
        });
    }

    /**
     * 查询设计师列表
     * 权限矩阵：
     * - 系统管理员：查看所有设计师
     * - 企业管理员：查看公开信息（用于招聘）
     * - 院校管理员：查看本校设计师
     * - 设计师：无权查看列表
     */
    @Operation(
        summary = "查询设计师列表",
        description = "分页查询设计师信息列表，支持按条件筛选",
        parameters = {
            @Parameter(name = "designerName", description = "设计师姓名"),
            @Parameter(name = "profession", description = "职业类型"),
            @Parameter(name = "skillTags", description = "技能标签"),
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10")
        }
    )
    @SaCheckPermission("designer:designer:list")
    @GetMapping("/list")
    public TableDataInfo<Designer> list(Designer designer) {
        if (!hasDesignerViewPermission()) {
            throw new RuntimeException("权限不足：无权查看设计师列表");
        }
        
        Long userId = LoginHelper.getUserId();
        
        if (LoginHelper.isSuperAdmin()) {
            // 系统管理员可以查看所有设计师
            return designerService.selectDesignerList(designer);
        } else if (permissionUtils.isEnterprise()) {
            // 企业管理员可以查看公开信息（用于招聘）
            return designerService.selectPublicDesignerList(designer);
        } else if (permissionUtils.isSchool()) {
            // 院校管理员可以查看本校设计师
            Long schoolId = permissionUtils.getCurrentSchoolId();
            return designerService.selectDesignerListBySchool(designer, schoolId);
        } else {
            // 设计师用户无权查看列表
            throw new RuntimeException("权限不足：设计师用户无权查看设计师列表");
        }
    }

    /**
     * 获取设计师详细信息
     * 权限矩阵：
     * - 系统管理员：查看所有设计师详情
     * - 企业管理员：查看设计师公开信息
     * - 院校管理员：查看本校设计师详情
     * - 设计师：查看自己的详情
     */
    @Operation(
        summary = "获取设计师详情",
        description = "根据设计师ID获取详细信息",
        parameters = @Parameter(name = "designerId", description = "设计师ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:designer:query")
    @GetMapping("/{designerId}")
    public R<Designer> getInfo(@PathVariable Long designerId) {
        if (!hasDesignerDetailPermission()) {
            return R.fail("权限不足：无权查看设计师详情");
        }
        
        Long userId = LoginHelper.getUserId();
        
        if (LoginHelper.isSuperAdmin()) {
            // 系统管理员可以查看所有设计师详情
            return R.ok(designerService.selectDesignerById(designerId));
        } else if (permissionUtils.isDesigner()) {
            // 设计师只能查看自己的详情
            Long currentDesignerId = permissionUtils.getCurrentDesignerId();
            if (currentDesignerId == null || !currentDesignerId.equals(designerId)) {
                return R.fail("权限不足：只能查看自己的设计师信息");
            }
            return R.ok(designerService.selectDesignerById(designerId));
        } else if (permissionUtils.isEnterprise()) {
            // 企业管理员可以查看设计师公开信息
            Designer designer = designerService.selectDesignerById(designerId);
            if (designer == null) {
                return R.fail("设计师不存在");
            }
            // 返回公开信息（可以考虑创建一个专门的方法来处理）
            return R.ok(designer);
        } else if (permissionUtils.isSchool()) {
            // 院校管理员可以查看本校设计师详情
            Long schoolId = permissionUtils.getCurrentSchoolId();
            Designer designer = designerService.selectDesignerById(designerId);
            if (designer == null) {
                return R.fail("设计师不存在");
            }
            if (designer.getSchoolId() == null || !designer.getSchoolId().equals(schoolId)) {
                return R.fail("权限不足：只能查看本校设计师信息");
            }
            return R.ok(designer);
        } else {
            return R.fail("权限不足：无权查看设计师详情");
        }
    }

    // 注意：原有的 /{designerId}/complete 接口已经迁移到 ProfileManagementController
    // 新的接口路径保持不变：/designer/designer/{designerId}/complete
    // 优化后的接口提供更好的性能和权限控制

    /**
     * 新增设计师
     */
    @Operation(
        summary = "新增设计师",
        description = "添加新的设计师信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "设计师信息",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Designer.class),
                examples = @ExampleObject(
                    name = "新增设计师示例",
                    value = """
                        {
                            "designerName": "李四",
                            "gender": "女",
                            "birthDate": "1990-03-20",
                            "phone": "13900139000",
                            "email": "lisi@example.com",
                            "description": "资深交互设计师",
                            "profession": "INTERACTION_DESIGNER",
                            "skillTags": "[\\"user_research\\", \\"prototype_design\\"]",
                            "workYears": 5
                        }
                        """
                )
            )
        )
    )
    @SaCheckPermission("designer:designer:add")
    @Log(title = "设计师管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody Designer designer) {
        checkAdminPermission();
        return toAjax(designerService.insertDesigner(designer));
    }

    /**
     * 修改设计师
     */
    @Operation(
        summary = "修改设计师",
        description = "更新设计师信息",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "设计师信息（需包含designerId）",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Designer.class),
                examples = @ExampleObject(
                    name = "修改设计师示例",
                    value = """
                        {
                            "designerId": 1,
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
                            "portfolioUrl": "https://portfolio.example.com",
                            "socialLinks": "{\"github\":\"https://github.com/zhangsan\",\"behance\":\"https://behance.net/zhangsan\"}",
                            "status": "0"
                        }
                        """
                )
            )
        )
    )
    @SaCheckPermission("designer:designer:edit")
    @Log(title = "设计师管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody Designer designer) {
        checkAdminPermission();
        // 清除系统自动填充的字段，避免前端误传
        designer.setCreateTime(null);
        designer.setUpdateTime(null);
        designer.setCreateBy(null);
        designer.setUpdateBy(null);
        designer.setCreateDept(null);
        
        return toAjax(designerService.updateDesigner(designer));
    }

    /**
     * 删除设计师
     */
    @Operation(
        summary = "删除设计师",
        description = "根据设计师ID删除设计师信息（支持批量删除）",
        parameters = @Parameter(name = "designerIds", description = "设计师ID数组", required = true, example = "1,2,3")
    )
    @SaCheckPermission("designer:designer:remove")
    @Log(title = "设计师管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{designerIds}")
    public R<Void> remove(@PathVariable Long[] designerIds) {
        checkAdminPermission();
        return toAjax(designerService.deleteDesignerByIds(Arrays.asList(designerIds)));
    }

    /**
     * 根据职业查询设计师
     */
    @Operation(
        summary = "按职业查询设计师",
        description = "根据职业类型查询设计师列表",
        parameters = @Parameter(name = "profession", description = "职业类型", required = true, 
                               example = "UI_UX_DESIGNER",
                               schema = @Schema(allowableValues = {"ILLUSTRATOR", "INTERACTION_DESIGNER", 
                                                                 "BRAND_DESIGNER", "UI_DESIGNER", "UX_DESIGNER", 
                                                                 "UI_UX_DESIGNER", "GRAPHIC_DESIGNER", "PRODUCT_DESIGNER", 
                                                                 "MOTION_DESIGNER", "VISUAL_DESIGNER", "THREE_D_DESIGNER"}))
    )
    @SaCheckPermission("designer:designer:query")
    @GetMapping("/profession/{profession}")
    public R<List<Designer>> getByProfession(@PathVariable String profession) {
        checkAdminPermission();
        return R.ok(designerService.selectDesignerByProfession(profession));
    }

    /**
     * 根据技能标签查询设计师
     */
    @Operation(
        summary = "按技能查询设计师",
        description = "根据技能标签查询设计师列表",
        parameters = @Parameter(name = "skillTags", description = "技能标签列表", required = true,
                               example = "prototype_design,visual_design")
    )
    @SaCheckPermission("designer:designer:query")
    @GetMapping("/skills")
    public R<List<Designer>> getBySkills(@RequestParam List<String> skillTags) {
        checkAdminPermission();
        return R.ok(designerService.selectDesignerBySkillTags(skillTags));
    }

    /**
     * 根据院校查询设计师
     */
    @Operation(
        summary = "按院校查询设计师",
        description = "根据院校ID查询该院校的设计师列表",
        parameters = @Parameter(name = "schoolId", description = "院校ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:designer:query")
    @GetMapping("/school/{schoolId}")
    public R<List<Designer>> getBySchool(@PathVariable Long schoolId) {
        checkAdminPermission();
        return R.ok(designerService.selectDesignerBySchool(schoolId));
    }

    /**
     * 根据企业查询设计师
     */
    @Operation(
        summary = "按企业查询设计师",
        description = "根据企业ID查询该企业的设计师列表",
        parameters = @Parameter(name = "enterpriseId", description = "企业ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:designer:query")
    @GetMapping("/enterprise/{enterpriseId}")
    public R<List<Designer>> getByEnterprise(@PathVariable Long enterpriseId) {
        checkAdminPermission();
        return R.ok(designerService.selectDesignerByEnterprise(enterpriseId));
    }

    /**
     * 获取所有职业选项
     */
    @Operation(
        summary = "获取职业选项",
        description = "获取所有可用的设计师职业类型选项（仅限系统管理员）"
    )
    @SaCheckPermission("designer:designer:query")
    @GetMapping("/professions")
    public R<List<DesignerProfession>> getProfessions() {
        checkAdminPermission();
        return R.ok(Arrays.asList(DesignerProfession.values()));
    }

    /**
     * 获取所有技能标签选项
     */
    @Operation(
        summary = "获取技能标签选项",
        description = "获取所有可用的技能标签选项（仅限系统管理员）"
    )
    @SaCheckPermission("designer:designer:query")
    @GetMapping("/skillTags")
    public R<List<SkillTag>> getSkillTags() {
        checkAdminPermission();
        return R.ok(Arrays.asList(SkillTag.values()));
    }

    // ==================== 新增状态控制接口 ====================

    /**
     * 修改设计师状态（启用/停用）
     */
    @Operation(
        summary = "修改设计师状态",
        description = "启用或停用设计师账户",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "状态修改请求",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = ChangeStatusRequest.class),
                examples = @ExampleObject(
                    name = "修改状态示例",
                    value = """
                        {
                            "designerId": 1,
                            "status": "0"
                        }
                        """
                )
            )
        )
    )
    @SaCheckPermission("designer:designer:edit")
    @Log(title = "设计师管理", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public R<Void> changeStatus(@Validated @RequestBody ChangeStatusRequest request) {
        try {
            boolean result = designerService.updateDesignerStatus(request.getDesignerId(), request.getStatus());
            if (result) {
                String operation = "0".equals(request.getStatus()) ? "启用" : "停用";
                log.info("设计师状态修改成功，设计师ID: {}, 操作: {}", request.getDesignerId(), operation);
                return R.ok();
            } else {
                log.error("设计师状态修改失败，设计师ID: {}", request.getDesignerId());
                return R.fail("状态修改失败");
            }
        } catch (Exception e) {
            log.error("设计师状态修改异常，设计师ID: {}", request.getDesignerId(), e);
            return R.fail("状态修改失败：" + e.getMessage());
        }
    }

    /**
     * 批量修改设计师状态
     */
    @Operation(
        summary = "批量修改设计师状态",
        description = "批量启用或停用设计师账户",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "批量状态修改请求",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = BatchChangeStatusRequest.class),
                examples = @ExampleObject(
                    name = "批量修改状态示例",
                    value = """
                        {
                            "designerIds": [1, 2, 3],
                            "status": "1"
                        }
                        """
                )
            )
        )
    )
    @SaCheckPermission("designer:designer:edit")
    @Log(title = "设计师管理", businessType = BusinessType.UPDATE)
    @PutMapping("/batchChangeStatus")
    public R<Void> batchChangeStatus(@Validated @RequestBody BatchChangeStatusRequest request) {
        try {
            boolean result = designerService.batchUpdateDesignerStatus(request.getDesignerIds(), request.getStatus());
            if (result) {
                String operation = "0".equals(request.getStatus()) ? "启用" : "停用";
                log.info("设计师状态批量修改成功，设计师IDs: {}, 操作: {}", request.getDesignerIds(), operation);
                return R.ok();
            } else {
                log.error("设计师状态批量修改失败，设计师IDs: {}", request.getDesignerIds());
                return R.fail("批量状态修改失败");
            }
        } catch (Exception e) {
            log.error("设计师状态批量修改异常，设计师IDs: {}", request.getDesignerIds(), e);
            return R.fail("批量状态修改失败：" + e.getMessage());
        }
    }

    // ==================== 新增回收站管理接口 ====================

    /**
     * 恢复已删除的设计师
     */
    @Operation(
        summary = "恢复设计师",
        description = "恢复已删除的设计师数据（仅限管理员）",
        parameters = @Parameter(name = "designerIds", description = "设计师ID数组", required = true, example = "1,2,3")
    )
    @SaCheckPermission("designer:designer:restore")
    @Log(title = "设计师管理", businessType = BusinessType.UPDATE)
    @PostMapping("/restore/{designerIds}")
    public R<Void> restore(@PathVariable Long[] designerIds) {
        checkAdminPermission();
        try {
            boolean result = designerService.restoreDesignerByIds(Arrays.asList(designerIds));
            if (result) {
                log.info("设计师恢复成功，设计师IDs: {}", Arrays.toString(designerIds));
                return R.ok();
            } else {
                log.error("设计师恢复失败，设计师IDs: {}", Arrays.toString(designerIds));
                return R.fail("恢复失败");
            }
        } catch (Exception e) {
            log.error("设计师恢复异常，设计师IDs: {}", Arrays.toString(designerIds), e);
            return R.fail("恢复失败：" + e.getMessage());
        }
    }

    /**
     * 查询回收站数据
     */
    @Operation(
        summary = "查询回收站",
        description = "查询已删除的设计师数据（仅限管理员）"
    )
    @SaCheckPermission("designer:designer:recycle:list")
    @GetMapping("/recycle/list")
    public R<TableDataInfo<Designer>> getRecycleList() {
        checkAdminPermission();
        try {
            TableDataInfo<Designer> recycleData = designerService.selectRecycleDesignerList();
            return R.ok(recycleData);
        } catch (Exception e) {
            log.error("查询回收站数据异常", e);
            return R.fail("查询回收站失败：" + e.getMessage());
        }
    }

    /**
     * 查询停用的设计师列表
     */
    @Operation(
        summary = "查询停用设计师",
        description = "查询被停用的设计师数据（仅限管理员）"
    )
    @SaCheckPermission("designer:designer:list")
    @GetMapping("/disabled/list")
    public R<TableDataInfo<Designer>> getDisabledList() {
        checkAdminPermission();
        try {
            TableDataInfo<Designer> disabledData = designerService.selectDisabledDesignerList();
            return R.ok(disabledData);
        } catch (Exception e) {
            log.error("查询停用设计师数据异常", e);
            return R.fail("查询停用设计师失败：" + e.getMessage());
        }
    }

    // ==================== 请求对象定义 ====================

    /**
     * 状态修改请求对象
     */
    @Data
    @Schema(description = "状态修改请求")
    public static class ChangeStatusRequest {
        @Schema(description = "设计师ID", required = true, example = "1")
        private Long designerId;

        @Pattern(regexp = "^[01]$", message = "状态值必须为0或1")
        @Schema(description = "状态（0正常 1停用）", required = true, example = "0", allowableValues = {"0", "1"})
        private String status;
    }

    /**
     * 批量状态修改请求对象
     */
    @Data
    @Schema(description = "批量状态修改请求")
    public static class BatchChangeStatusRequest {
        @Schema(description = "设计师ID列表", required = true, example = "[1,2,3]")
        private List<Long> designerIds;

        @Pattern(regexp = "^[01]$", message = "状态值必须为0或1")
        @Schema(description = "状态（0正常 1停用）", required = true, example = "0", allowableValues = {"0", "1"})
        private String status;
    }
} 