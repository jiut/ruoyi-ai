package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
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
import org.ruoyi.designer.domain.Enterprise;
import org.ruoyi.designer.service.IEnterpriseService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * 企业管理Controller
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

    /**
     * 查询企业列表
     */
    @Operation(summary = "查询企业列表", description = "分页查询企业信息列表")
    @SaCheckPermission("designer:enterprise:list")
    @GetMapping("/list")
    public TableDataInfo<Enterprise> list(Enterprise enterprise, PageQuery pageQuery) {
        return enterpriseService.selectEnterpriseList(enterprise, pageQuery);
    }

    /**
     * 获取企业详细信息
     */
    @SaCheckPermission("designer:enterprise:query")
    @GetMapping("/{enterpriseId}")
    public R<Enterprise> getInfo(@PathVariable Long enterpriseId) {
        return R.ok(enterpriseService.selectEnterpriseById(enterpriseId));
    }

    /**
     * 新增企业
     */
    @SaCheckPermission("designer:enterprise:add")
    @Log(title = "企业管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody Enterprise enterprise) {
        return toAjax(enterpriseService.insertEnterprise(enterprise));
    }

    /**
     * 修改企业
     */
    @SaCheckPermission("designer:enterprise:edit")
    @Log(title = "企业管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated @RequestBody Enterprise enterprise) {
        return toAjax(enterpriseService.updateEnterprise(enterprise));
    }

    /**
     * 删除企业
     */
    @SaCheckPermission("designer:enterprise:remove")
    @Log(title = "企业管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{enterpriseIds}")
    public R<Void> remove(@PathVariable Long[] enterpriseIds) {
        return toAjax(enterpriseService.deleteEnterpriseByIds(Arrays.asList(enterpriseIds)));
    }

    /**
     * 根据用户ID查询企业
     */
    @SaCheckPermission("designer:enterprise:query")
    @GetMapping("/user/{userId}")
    public R<Enterprise> getByUserId(@PathVariable Long userId) {
        return R.ok(enterpriseService.selectEnterpriseByUserId(userId));
    }
} 