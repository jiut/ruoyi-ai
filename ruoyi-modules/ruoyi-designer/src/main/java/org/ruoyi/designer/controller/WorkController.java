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
import org.ruoyi.designer.domain.Work;
import org.ruoyi.designer.service.IWorkService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 作品管理
 *
 * @author ruoyi
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/work")
public class WorkController extends BaseController {

    private final IWorkService workService;

    /**
     * 查询作品列表
     */
    @SaCheckPermission("designer:work:list")
    @GetMapping("/list")
    public TableDataInfo<Work> list(Work work) {
        return workService.selectWorkList(work);
    }

    /**
     * 获取作品详细信息
     */
    @SaCheckPermission("designer:work:query")
    @GetMapping("/{workId}")
    public R<Work> getInfo(@PathVariable Long workId) {
        // 增加浏览数
        workService.incrementViewCount(workId);
        return R.ok(workService.selectWorkById(workId));
    }

    /**
     * 根据设计师ID查询作品列表
     */
    @SaCheckPermission("designer:work:list")
    @GetMapping("/designer/{designerId}")
    public R<List<Work>> getWorksByDesignerId(@PathVariable Long designerId) {
        List<Work> works = workService.selectWorkByDesignerId(designerId);
        return R.ok(works);
    }

    /**
     * 新增作品
     */
    @SaCheckPermission("designer:work:add")
    @Log(title = "作品", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody Work work) {
        return toAjax(workService.insertWork(work));
    }

    /**
     * 修改作品
     */
    @SaCheckPermission("designer:work:edit")
    @Log(title = "作品", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody Work work) {
        return toAjax(workService.updateWork(work));
    }

    /**
     * 删除作品
     */
    @SaCheckPermission("designer:work:remove")
    @Log(title = "作品", businessType = BusinessType.DELETE)
    @DeleteMapping("/{workIds}")
    public R<Void> remove(@PathVariable List<Long> workIds) {
        return toAjax(workService.deleteWorkByIds(workIds));
    }

    /**
     * 作品点赞
     */
    @SaCheckPermission("designer:work:like")
    @Log(title = "作品点赞", businessType = BusinessType.UPDATE)
    @PostMapping("/{workId}/like")
    public R<Void> likeWork(@PathVariable Long workId) {
        return toAjax(workService.incrementLikeCount(workId));
    }
} 