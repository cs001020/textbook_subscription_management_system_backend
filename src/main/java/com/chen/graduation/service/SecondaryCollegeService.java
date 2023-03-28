package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.SecondaryCollegeDTO;
import com.chen.graduation.beans.PO.SecondaryCollege;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_secondary_college(教学组)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface SecondaryCollegeService extends IService<SecondaryCollege> {

    /**
     * 得到列表
     *
     * @return {@link AjaxResult}<{@link List}<{@link SecondaryCollegeVO}>>
     */
    AjaxResult<List<SecondaryCollegeVO>> getList();

    /**
     * 删除通过id
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deleteById(Long id);

    /**
     * 添加
     *
     * @param secondaryCollegeDTO 二级学院dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> add(SecondaryCollegeDTO secondaryCollegeDTO);

    /**
     * 更新通过id
     *
     * @param secondaryCollegeDTO 二级学院dto
     * @param id                  id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateById(SecondaryCollegeDTO secondaryCollegeDTO, Long id);

    /**
     * 查询班级
     *
     * @return {@link AjaxResult}<{@link List}<{@link SecondaryCollege}>>
     */
    AjaxResult<List<SecondaryCollege>> getGrade();
}
