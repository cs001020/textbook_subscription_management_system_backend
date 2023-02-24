package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.OpeningPlanDTO;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OpeningPlanVO;

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
}
