package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OpeningPlanVO;
import com.chen.graduation.converter.OpeningPlanConverter;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.mapper.OpeningPlanMapper;
import com.chen.graduation.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 10065
 * @description 针对表【tb_opening_plan(开课计划)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
public class OpeningPlanServiceImpl extends ServiceImpl<OpeningPlanMapper, OpeningPlan>
        implements OpeningPlanService {
    @Resource
    private UserService userService;
    @Resource
    private OpeningPlanConverter openingPlanConverter;

    @Override
    public AjaxResult<List<OpeningPlanVO>> getPlan() {
        //查询当前登陆用户
        Long userId = UserHolderContext.getUserId();
        User user = userService.getById(userId);
        //查询开课计划
        List<OpeningPlan> openingPlanList = baseMapper.getPlanByUser(user);
        //封装结果
        List<OpeningPlanVO> openingPlanVOS = openingPlanConverter.pos2vos(openingPlanList);
        //打印日志
        //返回结果
        return AjaxResult.success(openingPlanVOS);
    }
}




