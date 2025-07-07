package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.common.idempotent.annotation.RepeatSubmit;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.Award;
import org.ruoyi.designer.service.IAwardService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 获奖记录管理（已废弃）
 *
 * @deprecated 请使用 ProfileManagementController 中的新接口
 * @author ruoyi
 */
@Deprecated
@Tag(name = "获奖记录管理（已废弃）", description = "请使用 ProfileManagementController 中的新接口")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/award")
public class AwardController extends BaseController {

    private final IAwardService awardService;
    private final DesignerPermissionUtils designerPermissionUtils;

    /**
     * 查询获奖记录列表
     */
    // @SaCheckPermission("designer:award:list") // 移除严格权限注解
    @GetMapping("/list")
    public TableDataInfo<Award> list(Award award) {
        // 权限检查：管理员 OR 设计师查询自己的记录
        if (award.getDesignerId() != null) {
            if (!LoginHelper.isSuperAdmin()) {
                if (!designerPermissionUtils.hasDesignerPermission(award.getDesignerId())) {
                    return TableDataInfo.build(); // 返回空列表，不暴露权限错误
                }
            }
        } else {
            // 如果没有指定designerId，只有管理员可以查看所有获奖记录
            if (!LoginHelper.isSuperAdmin()) {
                return TableDataInfo.build();
            }
        }
        
        return awardService.selectAwardList(award);
    }

    /**
     * 获取获奖记录详细信息
     */
    @SaCheckPermission("designer:award:query")
    @GetMapping("/{awardId}")
    public R<Award> getInfo(@PathVariable Long awardId) {
        return R.ok(awardService.selectAwardById(awardId));
    }

    /**
     * 根据设计师ID查询获奖记录列表
     */
    @SaCheckPermission("designer:award:list")
    @GetMapping("/designer/{designerId}")
    public R<List<Award>> getAwardsByDesignerId(@PathVariable Long designerId) {
        List<Award> awards = awardService.selectAwardByDesignerId(designerId);
        return R.ok(awards);
    }

    /**
     * 新增获奖记录
     */
    @SaCheckPermission("designer:award:add")
    @Log(title = "获奖记录", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody Award award) {
        return toAjax(awardService.insertAward(award));
    }

    /**
     * 修改获奖记录
     */
    // @SaCheckPermission("designer:award:edit") // 移除严格权限注解
    @Log(title = "获奖记录", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody Award award) {
        // 权限检查：管理员 OR 设计师本人
        if (!LoginHelper.isSuperAdmin()) {
            // 检查获奖记录是否存在
            Award existing = awardService.selectAwardById(award.getAwardId());
            if (existing == null) {
                return R.fail("获奖记录不存在");
            }
            
            // 检查是否是设计师本人
            if (!designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                return R.fail("无权限编辑此获奖记录");
            }
            
            // 确保不能修改设计师ID（防止恶意修改）
            award.setDesignerId(existing.getDesignerId());
        }
        
        return toAjax(awardService.updateAward(award));
    }

    /**
     * 调整获奖记录排序
     */
    @SaCheckPermission("designer:award:edit")
    @Log(title = "获奖记录排序", businessType = BusinessType.UPDATE)
    @PutMapping("/{awardId}/sort")
    public R<Void> updateSort(@PathVariable Long awardId, @RequestBody Award award) {
        award.setAwardId(awardId);
        return toAjax(awardService.updateAward(award));
    }

    /**
     * 删除获奖记录
     */
    // @SaCheckPermission("designer:award:remove") // 移除严格权限注解
    @Log(title = "获奖记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{awardIds}")
    public R<Void> remove(@PathVariable List<Long> awardIds) {
        if (!LoginHelper.isSuperAdmin()) {
            // 检查所有要删除的记录是否都属于当前用户
            for (Long id : awardIds) {
                Award existing = awardService.selectAwardById(id);
                if (existing == null || !designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                    return R.fail("无权限删除获奖记录");
                }
            }
        }
        
        return toAjax(awardService.deleteAwardByIds(awardIds));
    }
}