package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.TrendData;

/**
 * 获奖趋势数据Mapper接口
 *
 * @author ruoyi
 */
public interface TrendDataMapper extends BaseMapper<TrendData> {

    /**
     * 根据院校ID查询获奖趋势数据
     *
     * @param schoolId 院校ID
     * @return 获奖趋势数据
     */
    default TrendData selectBySchoolId(Long schoolId) {
        return selectOne(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<TrendData>()
                .eq(TrendData::getSchoolId, schoolId));
    }
} 