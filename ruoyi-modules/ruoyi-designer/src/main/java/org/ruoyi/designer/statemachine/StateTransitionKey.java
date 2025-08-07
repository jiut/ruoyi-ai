package org.ruoyi.designer.statemachine;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.designer.domain.enums.ApplicationStatus;
import org.ruoyi.designer.domain.enums.ReviewMode;
import org.ruoyi.designer.domain.enums.TransitionAction;

/**
 * 状态转换键
 * 用作转换规则矩阵的键
 * 
 * @author ruoyi
 */
@Data
@AllArgsConstructor
@EqualsAndHashCode
public class StateTransitionKey {
    
    /** 当前状态 */
    private ApplicationStatus fromStatus;
    
    /** 审核模式 */
    private ReviewMode reviewMode;
    
    /** 操作类型 */
    private TransitionAction action;
    
    @Override
    public String toString() {
        return String.format("TransitionKey[%s -> %s (%s)]", 
                fromStatus.getName(), action.getDescription(), reviewMode.getName());
    }
} 