package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.SecondaryCollege;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_secondary_college(教学组)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.SecondaryCollege
*/
public interface SecondaryCollegeMapper extends BaseMapper<SecondaryCollege> {

    /**
     * 获取班级
     *
     * @return {@link List}<{@link SecondaryCollege}>
     */
    List<SecondaryCollege> getGrade();
}




