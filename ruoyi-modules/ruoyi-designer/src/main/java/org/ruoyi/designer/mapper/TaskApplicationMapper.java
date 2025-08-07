package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.ruoyi.designer.domain.TaskApplication;
import org.ruoyi.designer.domain.vo.EnterpriseApplicationView;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
import java.util.List;

/**
 * 任务申请Mapper接口
 *
 * @author ruoyi
 */
public interface TaskApplicationMapper extends BaseMapper<TaskApplication> {

    /**
     * 查询任务申请
     *
     * @param applicationId 任务申请主键
     * @return 任务申请
     */
    TaskApplication selectTaskApplicationById(Long applicationId);

    /**
     * 查询任务申请列表
     *
     * @param taskApplication 任务申请
     * @return 任务申请集合
     */
    List<TaskApplication> selectTaskApplicationList(TaskApplication taskApplication);

    /**
     * 新增任务申请
     *
     * @param taskApplication 任务申请
     * @return 结果
     */
    int insertTaskApplication(TaskApplication taskApplication);

    /**
     * 修改任务申请
     *
     * @param taskApplication 任务申请
     * @return 结果
     */
    int updateTaskApplication(TaskApplication taskApplication);

    /**
     * 删除任务申请
     *
     * @param applicationId 任务申请主键
     * @return 结果
     */
    int deleteTaskApplicationById(Long applicationId);

    /**
     * 批量删除任务申请
     *
     * @param applicationIds 需要删除的数据主键集合
     * @return 结果
     */
    int deleteTaskApplicationByIds(@Param("applicationIds") Collection<Long> applicationIds);

    /**
     * 查询企业管理员待审核申请列表
     *
     * @param enterpriseId 企业ID
     * @return 待审核申请列表
     */
    List<TaskApplication> selectEnterprisePendingApplications(@Param("enterpriseId") Long enterpriseId);

    /**
     * 根据任务ID和设计师ID查询申请
     *
     * @param taskId 任务ID
     * @param designerId 设计师ID
     * @return 任务申请
     */
    TaskApplication selectApplicationByTaskAndDesigner(@Param("taskId") Long taskId, @Param("designerId") Long designerId);

    /**
     * 根据设计师ID查询申请列表
     *
     * @param designerId 设计师ID
     * @return 申请列表
     */
    List<TaskApplication> selectApplicationsByDesignerId(@Param("designerId") Long designerId);

    /**
     * 根据企业ID查询申请列表
     *
     * @param enterpriseId 企业ID
     * @return 申请列表
     */
    List<TaskApplication> selectApplicationsByEnterpriseId(@Param("enterpriseId") Long enterpriseId);

    /**
     * 查询系统管理员待审核申请列表
     *
     * @return 待审核申请列表
     */
    List<TaskApplication> selectPendingAdminReviewApplications();

    /**
     * 查询企业管理员待审核申请列表
     *
     * @param enterpriseId 企业ID
     * @return 待审核申请列表
     */
    List<TaskApplication> selectPendingEnterpriseReviewApplications(@Param("enterpriseId") Long enterpriseId);

    /**
     * 查询系统管理员审核统计数据
     *
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 统计数据Map
     */
    java.util.Map<String, Object> selectAdminReviewStats(@Param("startDate") java.util.Date startDate, @Param("endDate") java.util.Date endDate);

    /**
     * 查询企业管理员待审核申请列表（严格隐藏系统管理员信息）
     *
     * @param enterpriseId 企业ID
     * @param pageNum 页码
     * @param pageSize 页大小
     * @return 企业视图申请列表
     */
    List<EnterpriseApplicationView> selectEnterprisePendingApplicationsView(
        @Param("enterpriseId") Long enterpriseId, 
        @Param("pageNum") Integer pageNum, 
        @Param("pageSize") Integer pageSize);

    /**
     * 查询系统管理员待审核申请列表
     *
     * @param pageNum 页码
     * @param pageSize 页大小
     * @return 申请列表
     */
    List<TaskApplication> selectAdminPendingApplications(
        @Param("pageNum") Integer pageNum, 
        @Param("pageSize") Integer pageSize);

    /**
     * 统计企业管理员待审核申请数量
     *
     * @param enterpriseId 企业ID
     * @return 申请数量
     */
    Long countEnterprisePendingApplications(@Param("enterpriseId") Long enterpriseId);

    /**
     * 统计系统管理员待审核申请数量
     *
     * @return 申请数量
     */
    Long countAdminPendingApplications();
} 