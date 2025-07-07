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
import org.ruoyi.designer.domain.Work;
import org.ruoyi.designer.service.IWorkService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 作品管理（已废弃）
 *
 * @deprecated 请使用 ProfileManagementController 中的新接口
 * @author ruoyi
 */
@Deprecated
@Tag(name = "作品管理（已废弃）", description = "请使用 ProfileManagementController 中的新接口")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/work")
public class WorkController extends BaseController {

    private final IWorkService workService;
    private final DesignerPermissionUtils designerPermissionUtils;

    /**
     * 查询作品列表
     */
    // @SaCheckPermission("designer:work:list") // 移除严格权限注解
    @GetMapping("/list")
    public TableDataInfo<Work> list(Work work) {
        // 权限检查：管理员 OR 设计师查询自己的记录
        if (work.getDesignerId() != null) {
            if (!LoginHelper.isSuperAdmin()) {
                if (!designerPermissionUtils.hasDesignerPermission(work.getDesignerId())) {
                    return TableDataInfo.build(); // 返回空列表，不暴露权限错误
                }
            }
        } else {
            // 如果没有指定designerId，只有管理员可以查看所有作品
            if (!LoginHelper.isSuperAdmin()) {
                return TableDataInfo.build();
            }
        }
        
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
    // @SaCheckPermission("designer:work:edit") // 移除严格权限注解
    @Log(title = "作品", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody Work work) {
        // 权限检查：管理员 OR 设计师本人
        if (!LoginHelper.isSuperAdmin()) {
            // 检查作品是否存在
            Work existing = workService.selectWorkById(work.getWorkId());
            if (existing == null) {
                return R.fail("作品不存在");
            }
            
            // 检查是否是设计师本人
            if (!designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                return R.fail("无权限编辑此作品");
            }
            
            // 确保不能修改设计师ID（防止恶意修改）
            work.setDesignerId(existing.getDesignerId());
        }
        
        return toAjax(workService.updateWork(work));
    }

    /**
     * 删除作品
     */
    // @SaCheckPermission("designer:work:remove") // 移除严格权限注解
    @Log(title = "作品", businessType = BusinessType.DELETE)
    @DeleteMapping("/{workIds}")
    public R<Void> remove(@PathVariable List<Long> workIds) {
        if (!LoginHelper.isSuperAdmin()) {
            // 检查所有要删除的记录是否都属于当前用户
            for (Long id : workIds) {
                Work existing = workService.selectWorkById(id);
                if (existing == null || !designerPermissionUtils.hasDesignerPermission(existing.getDesignerId())) {
                    return R.fail("无权限删除作品");
                }
            }
        }
        
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