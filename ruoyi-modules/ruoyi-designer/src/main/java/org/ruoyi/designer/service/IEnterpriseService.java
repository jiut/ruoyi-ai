package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.Enterprise;

import java.util.List;

/**
 * 企业Service接口
 *
 * @author ruoyi
 */
public interface IEnterpriseService extends IService<Enterprise> {

    /**
     * 查询企业列表
     *
     * @param enterprise 企业
     * @param pageQuery 分页参数
     * @return 企业集合
     */
    TableDataInfo<Enterprise> selectEnterpriseList(Enterprise enterprise, PageQuery pageQuery);

    /**
     * 根据企业ID查询企业信息
     *
     * @param enterpriseId 企业ID
     * @return 企业信息
     */
    Enterprise selectEnterpriseById(Long enterpriseId);

    /**
     * 新增企业
     *
     * @param enterprise 企业
     * @return 结果
     */
    Boolean insertEnterprise(Enterprise enterprise);

    /**
     * 修改企业
     *
     * @param enterprise 企业
     * @return 结果
     */
    Boolean updateEnterprise(Enterprise enterprise);

    /**
     * 批量删除企业
     *
     * @param enterpriseIds 需要删除的企业ID
     * @return 结果
     */
    Boolean deleteEnterpriseByIds(List<Long> enterpriseIds);

    /**
     * 根据用户ID查询企业
     *
     * @param userId 用户ID
     * @return 企业信息
     */
    Enterprise selectEnterpriseByUserId(Long userId);
} 