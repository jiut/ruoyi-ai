package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.Employer;

import java.util.List;

/**
 * 代表性雇主Mapper接口
 *
 * @author ruoyi
 */
public interface EmployerMapper extends BaseMapper<Employer> {

    /**
     * 根据院校ID查询代表性雇主列表
     *
     * @param schoolId 院校ID
     * @return 代表性雇主列表
     */
    @Select("""
        SELECT id, school_id, name, industry,
               create_by, create_time, update_by, update_time
        FROM des_school_employer 
        WHERE school_id = #{schoolId}
        ORDER BY create_time ASC
    """)
    List<Employer> selectBySchoolId(@Param("schoolId") Long schoolId);

    /**
     * 批量插入代表性雇主
     *
     * @param employers 代表性雇主列表
     * @return 影响行数
     */
    int insertBatch(@Param("employers") List<Employer> employers);
} 