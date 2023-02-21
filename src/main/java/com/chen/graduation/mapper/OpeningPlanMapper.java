package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.OpeningPlan;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.chen.graduation.beans.PO.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author CHEN
* @description 针对表【tb_opening_plan(开课计划)】的数据库操作Mapper
* @createDate 2023-02-21 13:57:15
* @Entity com.chen.graduation.beans.PO.OpeningPlan
*/
public interface OpeningPlanMapper extends BaseMapper<OpeningPlan> {

    /**
     * 根据用户获取开课计划
     *
     * @param user 用户
     * @return {@link List}<{@link OpeningPlan}>
     */
    List<OpeningPlan> getPlanByUser(@Param("user") User user);
}




