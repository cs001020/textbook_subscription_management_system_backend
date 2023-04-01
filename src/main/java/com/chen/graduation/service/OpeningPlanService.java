package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.OpeningPlanDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.PO.OpeningPlanDetail;
import com.chen.graduation.beans.PO.SecondaryCollege;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OpeningPlanDetailVO;
import com.chen.graduation.beans.VO.OpeningPlanVO;
import com.chen.graduation.beans.VO.TeachingGroupVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_opening_plan(开课计划)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface OpeningPlanService extends IService<OpeningPlan> {

    /**
     * 获取开课计划
     *
     * @return {@link AjaxResult}<{@link OpeningPlanVO}>
     */
    AjaxResult<List<OpeningPlanVO>> getPlan();

    /**
     * 导入开课计划
     *
     * @param openingPlanDTO 开放计划dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> addPlan(OpeningPlanDTO openingPlanDTO);

    /**
     * 得到所有开课计划
     *
     * @return {@link AjaxResult}<{@link List}<{@link OpeningPlanVO}>>
     */
    AjaxResult<List<OpeningPlanVO>> getAllPlanList();

    /**
     * 通过id获取计划
     *
     * @param id id
     * @return {@link AjaxResult}<{@link List}<{@link OpeningPlanVO}>>
     */
    AjaxResult<OpeningPlanVO>  getPlanById(Long id);

    /**
     * 查询课程信息
     *
     * @param pageParamDTO      页面参数dto
     * @param openingPlanDetail
     * @return {@link AjaxResult}<{@link OpeningPlanDetail}>
     */
    AjaxResult<List<OpeningPlanDetail>> selectCourse(PageParamDTO pageParamDTO, OpeningPlanDetail openingPlanDetail);

    /**
     * 查询班级
     *
     * @return {@link AjaxResult}<{@link List}<{@link SecondaryCollege}>>
     */
    AjaxResult<List<SecondaryCollege>> getGrade();

    /**
     * 查询教学组
     *
     * @return {@link AjaxResult}<{@link List}<{@link SecondaryCollege}>>
     */
    AjaxResult<List<TeachingGroupVO>> getTeachingGroup();


    /**
     * 删除通过id
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deleteById(Long id);

    /**
     * 更新开课计划
     *
     * @param openingPlanDTO 开放计划dto
     * @param id             id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateOpeningPlan(OpeningPlanDTO openingPlanDTO, Long id);

    /**
     * 通过id获取课程
     *
     * @param id id
     * @return {@link AjaxResult}<{@link OpeningPlanDetailVO}>
     */
    AjaxResult<List<OpeningPlanDetail>> getCourseById(Long id);
}
