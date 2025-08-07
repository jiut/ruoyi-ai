package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.ruoyi.designer.domain.ApplicationStateLog;
import org.ruoyi.designer.domain.enums.TransitionAction;

import java.util.Date;
import java.util.List;

/**
 * 申请状态变更日志Mapper接口
 * 用于记录和查询状态转换历史
 *
 * @author ruoyi
 */
public interface ApplicationStateLogMapper extends BaseMapper<ApplicationStateLog> {

    /**
     * 查询申请的状态变更历史
     * 
     * @param applicationId 申请ID
     * @return 状态变更历史列表
     */
    List<ApplicationStateLog> selectStateHistoryByApplicationId(@Param("applicationId") Long applicationId);

    /**
     * 查询指定时间范围内的审核日志
     * 
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @param action 操作类型（可选）
     * @return 审核日志列表
     */
    List<ApplicationStateLog> selectLogsByDateRange(@Param("startDate") Date startDate,
                                                    @Param("endDate") Date endDate,
                                                    @Param("action") TransitionAction action);

    /**
     * 查询操作人的审核历史
     * 
     * @param operatorId 操作人ID
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 审核历史列表
     */
    List<ApplicationStateLog> selectLogsByOperator(@Param("operatorId") Long operatorId,
                                                   @Param("startDate") Date startDate,
                                                   @Param("endDate") Date endDate);

    /**
     * 统计审核效率数据
     * 
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @param action 操作类型
     * @return 效率统计数据
     */
    java.util.Map<String, Object> selectReviewEfficiencyStats(@Param("startDate") Date startDate,
                                                               @Param("endDate") Date endDate,
                                                               @Param("action") TransitionAction action);

    /**
     * 查询平均审核时长
     * 
     * @param action 操作类型
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 平均时长（毫秒）
     */
    Long selectAverageReviewDuration(@Param("action") TransitionAction action,
                                     @Param("startDate") Date startDate,
                                     @Param("endDate") Date endDate);

    /**
     * 查询审核通过率统计
     * 
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 通过率统计数据
     */
    java.util.Map<String, Object> selectApprovalRateStats(@Param("startDate") Date startDate,
                                                           @Param("endDate") Date endDate);

    /**
     * 查询最近的状态变更记录
     * 
     * @param applicationId 申请ID
     * @return 最新的状态变更记录
     */
    ApplicationStateLog selectLatestStateLog(@Param("applicationId") Long applicationId);

    /**
     * 统计指定操作类型的日志数量
     * 
     * @param action 操作类型
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 日志数量
     */
    Long countLogsByAction(@Param("action") TransitionAction action,
                          @Param("startDate") Date startDate,
                          @Param("endDate") Date endDate);
} 