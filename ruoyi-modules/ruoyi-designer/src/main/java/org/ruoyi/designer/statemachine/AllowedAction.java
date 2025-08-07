package org.ruoyi.designer.statemachine;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.ruoyi.designer.domain.enums.TransitionAction;

/**
 * 允许的操作
 * 
 * @author ruoyi
 */
@Data
@AllArgsConstructor
public class AllowedAction {
    
    /** 操作类型 */
    private TransitionAction action;
    
    /** 操作标签 */
    private String label;
    
    /** 操作描述 */
    private String description;
    
    /** 是否需要确认 */
    private boolean requiresConfirmation;
    
    /** 确认消息 */
    private String confirmationMessage;
    
    /**
     * 简单构造函数（不需要确认）
     * 
     * @param action 操作类型
     * @param label 操作标签
     * @param description 操作描述
     */
    public AllowedAction(TransitionAction action, String label, String description) {
        this(action, label, description, false, null);
    }
    
    /**
     * 需要确认的操作构造函数
     * 
     * @param action 操作类型
     * @param label 操作标签
     * @param description 操作描述
     * @param confirmationMessage 确认消息
     */
    public AllowedAction(TransitionAction action, String label, String description, String confirmationMessage) {
        this(action, label, description, true, confirmationMessage);
    }
} 