package org.ruoyi.designer.statemachine;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.ruoyi.designer.domain.enums.ApplicationStatus;
import org.ruoyi.designer.domain.enums.TransitionAction;

/**
 * 状态转换路径
 * 
 * @author ruoyi
 */
@Data
@AllArgsConstructor
public class StateTransitionPath {
    
    /** 起始状态 */
    private ApplicationStatus fromStatus;
    
    /** 目标状态 */
    private ApplicationStatus toStatus;
    
    /** 转换操作 */
    private TransitionAction action;
    
    /** 路径描述 */
    private String description;
    
    /**
     * 简单构造函数（自动生成描述）
     * 
     * @param fromStatus 起始状态
     * @param toStatus 目标状态
     * @param action 转换操作
     */
    public StateTransitionPath(ApplicationStatus fromStatus, ApplicationStatus toStatus, TransitionAction action) {
        this(fromStatus, toStatus, action, 
             String.format("%s → %s (%s)", fromStatus.getName(), toStatus.getName(), action.getDescription()));
    }
    
    /**
     * 获取步骤编号（用于显示）
     * 
     * @return 步骤编号
     */
    public String getStepNumber() {
        // 这个方法可以在列表渲染时动态设置
        return "";
    }
    
    /**
     * 检查是否为最终步骤
     * 
     * @return 是否为最终步骤
     */
    public boolean isFinalStep() {
        return toStatus.isTerminal();
    }
    
    /**
     * 获取状态转换的预计时间
     * 
     * @return 预计时间描述
     */
    public String getEstimatedTime() {
        switch (action) {
            case ADMIN_REVIEW:
                return "1-2个工作日";
            case ENTERPRISE_REVIEW:
                return "2-3个工作日";
            case WITHDRAW:
                return "立即";
            case SYSTEM_AUTO:
                return "自动";
            default:
                return "未知";
        }
    }
} 