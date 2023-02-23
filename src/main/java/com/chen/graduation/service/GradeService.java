package com.chen.graduation.service;

import com.chen.graduation.beans.PO.Grade;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.GradeVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_grade(班级)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface GradeService extends IService<Grade> {

    /**
     * 由主要id列表
     *
     * @param id id
     * @return {@link AjaxResult}<{@link List}<{@link GradeVO}>>
     */
    AjaxResult<List<GradeVO>> listByMajorId(Long id);
}
