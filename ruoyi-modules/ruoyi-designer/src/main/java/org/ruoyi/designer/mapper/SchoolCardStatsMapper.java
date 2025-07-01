package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.ruoyi.designer.domain.SchoolCardStats;

/**
 * 卡片统计数据Mapper接口
 *
 * @author ruoyi
 */
public interface SchoolCardStatsMapper extends BaseMapper<SchoolCardStats> {

    /**
     * 根据院校ID查询卡片统计数据
     * 使用MyBatis Plus的标准查询方法，确保JacksonTypeHandler正确应用
     *
     * @param schoolId 院校ID
     * @return 卡片统计数据
     */
    default SchoolCardStats selectBySchoolId(Long schoolId) {
        return selectOne(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<SchoolCardStats>()
                .eq(SchoolCardStats::getSchoolId, schoolId));
    }
} 