package com.chen.graduation.service.impl;

import cn.hutool.core.util.BooleanUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.OpeningPlanDTO;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.OpeningPlanDetail;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OpeningPlanVO;
import com.chen.graduation.converter.OpeningPlanConverter;
import com.chen.graduation.enums.OpenPlanStateEnums;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.OpeningPlanDetailService;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.mapper.OpeningPlanMapper;
import com.chen.graduation.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 10065
 * @description 针对表【tb_opening_plan(开课计划)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class OpeningPlanServiceImpl extends ServiceImpl<OpeningPlanMapper, OpeningPlan>
        implements OpeningPlanService {
    @Resource
    private UserService userService;
    @Resource
    private OpeningPlanConverter openingPlanConverter;
    @Resource
    private OpeningPlanDetailService openingPlanDetailService;

    @Override
    public AjaxResult<List<OpeningPlanVO>> getPlan() {
        //查询当前登陆用户
        Long userId = UserHolderContext.getUserId();
        User user = userService.getById(userId);
        //查询开课计划
        List<OpeningPlan> openingPlanList = baseMapper.getPlanByUser(user);
        //封装结果
        List<OpeningPlanVO> openingPlanVOList = openingPlanConverter.pos2vos(openingPlanList);
        openingPlanVOList.forEach(openingPlanVO -> {
            openingPlanVO.setCanAddApproval(openingPlanVO.getTeacher().getName().equals(user.getName()));
        });
        //打印日志
        log.info("OpeningPlanServiceImpl.getPlan业务结束，结果:{}", openingPlanVOList);
        //返回结果
        return AjaxResult.success(openingPlanVOList);
    }

    // TODO: 2023/2/21 各种id校验
    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> addPlan(OpeningPlanDTO openingPlanDTO) {
        //分解参数
        OpeningPlan openingPlan = openingPlanConverter.dto2po(openingPlanDTO);
        List<OpeningPlanDetail> openingPlanDetails = openingPlan.getOpeningPlanDetails();
        //添加开课计划(返回id)
        boolean save1 = this.save(openingPlan);
        //开课计划详情设置开课计划id
        openingPlanDetails.forEach(openingPlanDetail -> {
            openingPlanDetail.setOpeningPlanId(openingPlan.getId());
        });
        //添加开课计划详情
        boolean save2 = openingPlanDetailService.saveBatch(openingPlanDetails);
        //判断结果
        boolean success = (BooleanUtil.isTrue(save1) && save1 == save2);
        //打印日志
        log.info("OpeningPlanServiceImpl.addPlan业务结束，结果:{}", success);
        //返回结果
        if (success){
            return AjaxResult.success();
        }
        return AjaxResult.error();
    }

    @Override
    public AjaxResult<List<OpeningPlanVO>> getAllPlanList() {
        //查询开课计划
        List<OpeningPlan> openingPlanList = baseMapper.getPlanByUser(new User());
        //封装结果
        List<OpeningPlanVO> openingPlanVOList = openingPlanConverter.pos2vos(openingPlanList);
        openingPlanVOList.forEach(openingPlanVO -> {
            openingPlanVO.setCanAddApproval(false);
        });
        //打印日志
        log.info("OpeningPlanServiceImpl.getPlan业务结束，结果:{}", openingPlanVOList);
        //返回结果
        return AjaxResult.success(openingPlanVOList);
    }
}




