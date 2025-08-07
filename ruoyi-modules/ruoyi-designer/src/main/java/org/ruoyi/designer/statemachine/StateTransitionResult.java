package org.ruoyi.designer.statemachine;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.ruoyi.designer.domain.enums.ApplicationStatus;

import java.util.HashMap;
import java.util.Map;

/**
 * 状态转换操作结果
 * 
 * @author ruoyi
 */
@Data
@AllArgsConstructor
public class StateTransitionResult {
    
    /** 操作是否成功 */
    private boolean success;
    
    /** 结果消息 */
    private String message;
    
    /** 新状态 */
    private ApplicationStatus newStatus;
    
    /** 附加元数据 */
    private Map<String, Object> metadata;
    
    /**
     * 创建成功结果
     * 
     * @param message 成功消息
     * @param newStatus 新状态
     * @return 成功结果
     */
    public static StateTransitionResult success(String message, ApplicationStatus newStatus) {
        return new StateTransitionResult(true, message, newStatus, new HashMap<>());
    }
    
    /**
     * 创建失败结果
     * 
     * @param message 失败消息
     * @return 失败结果
     */
    public static StateTransitionResult failure(String message) {
        return new StateTransitionResult(false, message, null, new HashMap<>());
    }
    
    /**
     * 添加元数据
     * 
     * @param key 键
     * @param value 值
     * @return 当前对象（支持链式调用）
     */
    public StateTransitionResult withMetadata(String key, Object value) {
        if (this.metadata == null) {
            this.metadata = new HashMap<>();
        }
        this.metadata.put(key, value);
        return this;
    }
    
    /**
     * 获取元数据
     * 
     * @param key 键
     * @param clazz 值类型
     * @return 元数据值
     */
    @SuppressWarnings("unchecked")
    public <T> T getMetadata(String key, Class<T> clazz) {
        if (metadata == null) {
            return null;
        }
        Object value = metadata.get(key);
        if (value != null && clazz.isInstance(value)) {
            return (T) value;
        }
        return null;
    }
    
    /**
     * 检查是否包含指定的元数据
     * 
     * @param key 键
     * @return 是否包含
     */
    public boolean hasMetadata(String key) {
        return metadata != null && metadata.containsKey(key);
    }
} 