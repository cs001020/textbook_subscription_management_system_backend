package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.*;
import com.chen.graduation.beans.TextbookIdsAndGradePeople;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.enums.TextbookOrderStateEnums;
import com.chen.graduation.enums.TextbookStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.service.TextbookOrderService;
import com.chen.graduation.mapper.TextbookOrderMapper;
import com.chen.graduation.service.TextbookService;
import com.chen.graduation.service.UserService;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
* @author 10065
* @description 针对表【tb_textbook_order(教材订单)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class TextbookOrderServiceImpl extends ServiceImpl<TextbookOrderMapper, TextbookOrder>
    implements TextbookOrderService{
    @Resource
    @Lazy
    private TextbookService textbookService;
    @Resource
    private OpeningPlanService openingPlanService;
    @Resource
    private UserService userService;

    @Override
    public void generateTextbooksOrderByApproval(Approval approval) {
        //获取教材ids
        List<Long> textbookIds=new ArrayList<>();
        for (String s : approval.getTextbookIds().split(",")) {
            textbookIds.add(Long.valueOf(s));
        }
        //修改新增图书状态
        boolean update = textbookService.lambdaUpdate().in(Textbook::getId, textbookIds).eq(Textbook::getState, TextbookStateEnums.AUDIT).set(Textbook::getState, TextbookStateEnums.UNDER_STOCK).update();
        //查询开课计划为了获取班级
        OpeningPlan openingPlan = openingPlanService.getById(approval.getOpeningPlanId());
        //生成订单
        TextbookOrder textbookOrder = new TextbookOrder();
        textbookOrder.setGradeId(openingPlan.getGradeId());
        textbookOrder.setTextbookIds(approval.getTextbookIds());
        textbookOrder.setState(TextbookOrderStateEnums.WAIT_GRANT);
        //插入数据
        boolean save = this.save(textbookOrder);
    }

    @Override
    public AjaxResult<List<TextbookOrder>> pageQuery(PageParamDTO pageParamDTO) {
        Page<TextbookOrder> page = page(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()));
        AjaxResult<List<TextbookOrder>> success = AjaxResult.success(page.getRecords());
        success.setTotal(page.getTotal());
        return success;
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> grant(Long id) {
        //查询订单信息
        TextbookOrder textbookOrder = this.getById(id);
        if (Objects.isNull(textbookOrder)){
            throw new ServiceException("参数异常");
        }
        //判断状态是否为代发放
        if (!TextbookOrderStateEnums.WAIT_GRANT.equals(textbookOrder.getState())) {
            //订单不为待发放
            throw new ServiceException("参数异常");
        }
        //
        //查询班级人数
        Long count = userService.lambdaQuery().eq(User::getGradeId, textbookOrder.getGradeId()).count();
        //查询教材信息
        List<Long> textbookIds = Arrays.stream(textbookOrder.getTextbookIds().split(",")).map(Long::valueOf).collect(Collectors.toList());
        List<Textbook> textbookList = textbookService.lambdaQuery().in(Textbook::getId, textbookIds).list();
        //判断库存是否充足
        for (Textbook textbook : textbookList) {
            if (TextbookStateEnums.UNDER_STOCK.equals(textbook.getState())||textbook.getStock()<count){
                throw new ServiceException("库存不足");
            }
            textbook.setStock((int) (textbook.getStock()-count));
        }
        //发放教材
        textbookOrder.setState(TextbookOrderStateEnums.GRANTED);
        boolean updateById = this.updateById(textbookOrder);
        //扣减库存
        boolean updateBatchById = textbookService.updateBatchById(textbookList);
        if (!updateBatchById||!updateById){
            throw new ServiceException("发生未知异常");
        }
        return AjaxResult.success();
    }
}




