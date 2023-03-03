package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.Grade;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.chen.graduation.beans.VO.GradeVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_grade(班级)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.Grade
*/
public interface GradeMapper extends BaseMapper<Grade> {

    /**
     * 获取所有班级信息
     *
     * @return {@link List}<{@link GradeVO}>
     */
    List<GradeVO> listAll();
}




