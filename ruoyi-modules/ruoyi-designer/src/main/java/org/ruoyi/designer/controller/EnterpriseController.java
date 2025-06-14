package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaCheckRole;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.Enterprise;
import org.ruoyi.designer.service.IEnterpriseService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * 企业管理Controller
 * 
 * 权限说明：
 * - 系统管理员：可以管理所有企业信息
 * - 企业管理员：只能管理自己绑定的企业信息
 *
 * @author ruoyi
 */
@Tag(name = "企业管理", description = "企业信息的增删改查操作")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/enterprise")
public class EnterpriseController extends BaseController {

    private final IEnterpriseService enterpriseService;
    private final DesignerPermissionUtils permissionUtils;

    /**
     * 查询企业列表
     * 权限矩阵：
     * - 系统管理员：查看所有企业
     * - 企业管理员：查看自己的企业
     */
    @Operation(summary = "查询企业列表", description = "分页查询企业信息列表")
    @SaCheckPermission("designer:enterprise:list")
    @GetMapping("/list")
    public TableDataInfo<Enterprise> list(Enterprise enterprise, PageQuery pageQuery) {
        Long userId = LoginHelper.getUserId();
        
        if (LoginHelper.isSuperAdmin()) {
            // 系统管理员可以查看所有企业
            return enterpriseService.selectEnterpriseList(enterprise, pageQuery);
        } else if (permissionUtils.isEnterprise()) {
            // 企业管理员只能查看自己绑定的企业
            Long enterpriseId = permissionUtils.getCurrentEnterpriseId();
            if (enterpriseId != null) {
                // 设置查询条件为当前用户的企业ID
                enterprise.setEnterpriseId(enterpriseId);
                return enterpriseService.selectEnterpriseList(enterprise, pageQuery);
            } else {
                return TableDataInfo.build();
            }
        } else {
            throw new RuntimeException("权限不足：无权查看企业列表");
        }
    }

    /**
     * 获取企业详细信息
     * 权限矩阵：
     * - 系统管理员：查看任意企业详情
     * - 企业管理员：查看自己的企业详情
     */
    @Operation(summary = "获取企业详情", description = "根据企业ID获取详细信息")
    @Parameter(name = "enterpriseId", description = "企业ID", required = true)
    @SaCheckPermission("designer:enterprise:query")
    @GetMapping("/{enterpriseId}")
    public R<Enterprise> getInfo(@PathVariable Long enterpriseId) {
        Long userId = LoginHelper.getUserId();
        
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限访问该企业
            if (!permissionUtils.hasEnterprisePermission(enterpriseId)) {
                return R.fail("权限不足：无权访问该企业信息");
            }
        }
        
        return R.ok(enterpriseService.selectEnterpriseById(enterpriseId));
    }

    /**
     * 新增企业
     * 仅管理员可以访问
     */
    @Operation(summary = "新增企业", description = "添加新的企业信息")
    @SaCheckRole("admin")
    @SaCheckPermission("designer:enterprise:add")
    @Log(title = "企业管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody Enterprise enterprise) {
        return toAjax(enterpriseService.insertEnterprise(enterprise));
    }

    /**
     * 修改企业
     * 权限矩阵：
     * - 系统管理员：修改任意企业信息
     * - 企业管理员：修改自己的企业信息
     */
    @Operation(summary = "修改企业", description = "更新企业信息")
    @SaCheckPermission("designer:enterprise:edit")
    @Log(title = "企业管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody Enterprise enterprise) {
        Long userId = LoginHelper.getUserId();
        
        if (!LoginHelper.isSuperAdmin()) {
            // 非管理员用户，检查是否有权限修改该企业
            if (!permissionUtils.hasEnterprisePermission(enterprise.getEnterpriseId())) {
                return R.fail("权限不足：无权修改该企业信息");
            }
        }
        
        return toAjax(enterpriseService.updateEnterprise(enterprise));
    }

    /**
     * 删除企业
     * 仅管理员可以访问
     */
    @Operation(summary = "删除企业", description = "批量删除企业")
    @Parameter(name = "enterpriseIds", description = "企业ID数组", required = true)
    @SaCheckRole("admin")
    @SaCheckPermission("designer:enterprise:remove")
    @Log(title = "企业管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{enterpriseIds}")
    public R<Void> remove(@PathVariable Long[] enterpriseIds) {
        return toAjax(enterpriseService.deleteEnterpriseByIds(Arrays.asList(enterpriseIds)));
    }

    /**
     * 根据用户ID查询企业
     * 仅管理员可以访问
     */
    @Operation(summary = "根据用户ID查询企业", description = "获取用户绑定的企业信息")
    @Parameter(name = "userId", description = "用户ID", required = true)
    @SaCheckRole("admin")
    @SaCheckPermission("designer:enterprise:query")
    @GetMapping("/user/{userId}")
    public R<Enterprise> getByUserId(@PathVariable Long userId) {
        return R.ok(enterpriseService.selectEnterpriseByUserId(userId));
    }
} 