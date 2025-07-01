package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.ChartData;

/**
 * 图表数据Mapper接口
 *
 * @author ruoyi
 */
public interface ChartDataMapper extends BaseMapper<ChartData> {

    /**
     * 根据院校ID查询图表数据
     *
     * @param schoolId 院校ID
     * @return 图表数据
     */
    default ChartData selectBySchoolId(Long schoolId) {
        return selectOne(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<ChartData>()
                .eq(ChartData::getSchoolId, schoolId));
    }
} 