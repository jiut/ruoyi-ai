package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 获奖记录管理
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/award")
public class AwardController extends BaseController {

    private final IAwardService awardService;

    /**
     * 查询获奖记录列表
     */
    @SaCheckPermission("designer:award:list")
    @GetMapping("/list")
    public TableDataInfo<Award> list(Award award) {
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
    @SaCheckPermission("designer:award:edit")
    @Log(title = "获奖记录", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody Award award) {
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
    @SaCheckPermission("designer:award:remove")
    @Log(title = "获奖记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{awardIds}")
    public R<Void> remove(@PathVariable List<Long> awardIds) {
        return toAjax(awardService.deleteAwardByIds(awardIds));
    }
}