package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.*;
import com.chen.graduation.beans.PO.Approval;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.*;
import com.chen.graduation.converter.ApprovalConverter;
import com.chen.graduation.converter.TextbookConverter;
import com.chen.graduation.enums.ApprovalStateEnums;
import com.chen.graduation.enums.ApprovalTotalStateEnums;
import com.chen.graduation.enums.OpenPlanStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.ApprovalService;
import com.chen.graduation.mapper.ApprovalMapper;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.service.TextbookOrderService;
import com.chen.graduation.service.TextbookService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author 10065
 * @description 针对表【tb_approval(审批)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class ApprovalServiceImpl extends ServiceImpl<ApprovalMapper, Approval>
        implements ApprovalService {

    @Resource
    private TextbookService textbookService;
    @Resource
    private TextbookConverter textbookConverter;
    @Resource
    private ApprovalConverter approvalConverter;
    @Resource
    private OpeningPlanService openingPlanService;
    @Resource
    private TextbookOrderService textbookOrderService;

    // FIXME: 2023/2/22 图书id校验
    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> submit(ApprovalInsertDTO approvalInsertDTO) {
        //参数校验
        if (CollectionUtil.isEmpty(approvalInsertDTO.getTextBookIds()) && CollectionUtil.isEmpty(approvalInsertDTO.getTextbookDTOList())) {
            throw new ServiceException("请选择教材");
        }
        //添加教材
        if (CollectionUtil.isNotEmpty(approvalInsertDTO.getTextbookDTOList())) {
            List<TextbookDTO> textbookDTOList = approvalInsertDTO.getTextbookDTOList();
            List<Textbook> textbookList = textbookConverter.dto2vos(textbookDTOList);
            textbookService.saveBatch(textbookList);
            //获取教材ids
            List<Long> textbookIds = textbookList.stream().map(Textbook::getId).collect(Collectors.toList());
            if (CollectionUtil.isEmpty(approvalInsertDTO.getTextBookIds())) {
                approvalInsertDTO.setTextBookIds(textbookIds);
            } else {
                approvalInsertDTO.getTextBookIds().addAll(textbookIds);
            }
        }
        String join = StrUtil.join(",", approvalInsertDTO.getTextBookIds());
        //构建插入对象
        Approval approval = new Approval();
        approval.setOpeningPlanId(approvalInsertDTO.getOpeningPlanId());
        approval.setTextbookIds(join);
        //插入
        boolean save = this.save(approval);
        //更新开课计划
        LambdaUpdateWrapper<OpeningPlan> updateWrapper=new LambdaUpdateWrapper<>();
        updateWrapper.eq(OpeningPlan::getId,approvalInsertDTO.getOpeningPlanId()).set(OpeningPlan::getState, OpenPlanStateEnums.WAITING_FOR_APPROVAL);
        openingPlanService.update(updateWrapper);
        //打印日志
        log.info("ApprovalServiceImpl.submit业务结束，结果:{}", save);
        //响应
        if (!save) {
            throw new ServiceException("插入异常");
        }
        return AjaxResult.success();
    }

    // FIXME: 2023/2/22 校验。。。。。
    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> teachingGroupApproval(Long id, ApprovalDTO approvalDTO) {
        //参数校验
        if (ApprovalStateEnums.UNAPPROVED.equals(approvalDTO.getApprovalStateEnums())) {
            throw new ServiceException("参数异常");
        }
        //获取代审批记录
        Approval approval = this.getById(id);
        //判断是否待审批
        if (!ApprovalTotalStateEnums.WAIT_GROUP.equals(approval.getState())) {
            throw new ServiceException("参数异常");
        }
        //修改
        approval.setTeachingGroupState(approvalDTO.getApprovalStateEnums());
        approval.setTeachingGroupMessage(approvalDTO.getMessage());
        approval.setState(ApprovalStateEnums.REJECT.equals(approvalDTO.getApprovalStateEnums()) ? ApprovalTotalStateEnums.REJECT : ApprovalTotalStateEnums.WAIT_SECONDARY);
        if (ApprovalStateEnums.ADOPT.equals(approvalDTO.getApprovalStateEnums())) {
            LambdaUpdateWrapper<OpeningPlan> updateWrapper=new LambdaUpdateWrapper<>();
            updateWrapper.eq(OpeningPlan::getId,approval.getOpeningPlanId()).set(OpeningPlan::getState, OpenPlanStateEnums.APPROVAL_COMPLETED);
            openingPlanService.update(updateWrapper);
        }
        //插入
        boolean b = this.updateById(approval);
        log.info("ApprovalServiceImpl.teachingGroupApproval业务结束，结果:{}", b);
        if (!b) {
            throw new ServiceException("操作失败");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> secondaryCollegeApproval(Long id, ApprovalDTO approvalDTO) {
        //参数校验
        if (ApprovalStateEnums.UNAPPROVED.equals(approvalDTO.getApprovalStateEnums())) {
            throw new ServiceException("参数异常");
        }
        //获取代审批记录
        Approval approval = this.getById(id);
        //判断是否待审批
        if (!ApprovalTotalStateEnums.WAIT_SECONDARY.equals(approval.getState())) {
            throw new ServiceException("参数异常");
        }
        //修改
        approval.setSecondaryCollegeState(approvalDTO.getApprovalStateEnums());
        approval.setSecondaryCollegeMessage(approvalDTO.getMessage());
        approval.setState(ApprovalStateEnums.REJECT.equals(approvalDTO.getApprovalStateEnums()) ? ApprovalTotalStateEnums.REJECT : ApprovalTotalStateEnums.WAIT_OFFICE);
        //教务处审核通过 更新开课计划
        if (ApprovalStateEnums.ADOPT.equals(approvalDTO.getApprovalStateEnums())) {
            LambdaUpdateWrapper<OpeningPlan> updateWrapper=new LambdaUpdateWrapper<>();
            updateWrapper.eq(OpeningPlan::getId,approval.getOpeningPlanId()).set(OpeningPlan::getState, OpenPlanStateEnums.APPROVAL_COMPLETED);
            openingPlanService.update(updateWrapper);
        }
        //插入
        boolean b = this.updateById(approval);
        log.info("ApprovalServiceImpl.teachingGroupApproval业务结束，结果:{}", b);
        if (!b) {
            throw new ServiceException("操作失败");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> academicAffairsOfficeApproval(Long id, ApprovalDTO approvalDTO) {
        //参数校验
        if (ApprovalStateEnums.UNAPPROVED.equals(approvalDTO.getApprovalStateEnums())) {
            throw new ServiceException("参数异常");
        }
        //获取代审批记录
        Approval approval = this.getById(id);
        //判断是否待审批
        if (!ApprovalTotalStateEnums.WAIT_OFFICE.equals(approval.getState())) {
            throw new ServiceException("参数异常");
        }
        //修改
        approval.setDeansOfficeState(approvalDTO.getApprovalStateEnums());
        approval.setDeansOfficeMessage(approvalDTO.getMessage());
        approval.setState(ApprovalStateEnums.REJECT.equals(approvalDTO.getApprovalStateEnums()) ? ApprovalTotalStateEnums.REJECT : ApprovalTotalStateEnums.ADOPT);
        // TODO: 2023/2/27 优化
        //教务处审核通过 更新开课计划
        if (ApprovalStateEnums.ADOPT.equals(approvalDTO.getApprovalStateEnums())) {
            LambdaUpdateWrapper<OpeningPlan> updateWrapper=new LambdaUpdateWrapper<>();
            updateWrapper.eq(OpeningPlan::getId,approval.getOpeningPlanId()).set(OpeningPlan::getState, OpenPlanStateEnums.APPROVAL_COMPLETED);
            openingPlanService.update(updateWrapper);
            // TODO: 2023/2/26 教材订单
            textbookOrderService.generateTextbooksOrderByApproval(approval);
        }
        //更新
        boolean b = this.updateById(approval);
        log.info("ApprovalServiceImpl.teachingGroupApproval业务结束，结果:{}", b);
        if (!b) {
            throw new ServiceException("操作失败");
        }
        return AjaxResult.success();
    }

    // TODO: 2023/2/26 教学组的id 匹配
    @Override
    public AjaxResult<List<ApprovalVO>> getApprovalByState(ApprovalTotalStateEnums approvalTotalStateEnums) {
        //条件构造器
        LambdaQueryWrapper<Approval> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(!Objects.isNull(approvalTotalStateEnums),Approval::getState, approvalTotalStateEnums);
        //查询
        List<Approval> approvalList = list(queryWrapper);
        //转换
        List<ApprovalVO> approvalVOList = approvalConverter.po2vos(approvalList);
        //打印日志
        log.info("ApprovalServiceImpl.getUnApproval业务结束，结果:{}", approvalVOList);
        //响应
        return AjaxResult.success(approvalVOList);
    }

    @Override
    public AjaxResult<List<ApprovalVO>> getApprovalByUser() {
        //获取用户
        Long userId = UserHolderContext.getUserId();
        //获取用户的开课计划
        List<OpeningPlan> openingPlanList = openingPlanService.lambdaQuery().eq(OpeningPlan::getTeacherId, userId).list();
        //如果不存在开课计划 返回空列表
        if (CollectionUtil.isEmpty(openingPlanList)){
            return AjaxResult.success(Collections.emptyList());
        }
        //获取开课计划id列表
        List<Long> openingPlanIdList = openingPlanList.stream().map(OpeningPlan::getId).collect(Collectors.toList());
        //查询申请
        List<Approval> approvalList = this.lambdaQuery().in(Approval::getOpeningPlanId, openingPlanIdList).list();
        //转换
        List<ApprovalVO> approvalVOList = approvalConverter.po2vos(approvalList);
        //打印日志
        log.info("ApprovalServiceImpl.getUnApproval业务结束，结果:{}", approvalVOList);
        //响应
        return AjaxResult.success(approvalVOList);
    }

    @Override
    public AjaxResult<List<ApprovalVO>> getApprovalList(PageParamDTO pageParamDTO, ApprovalSearchDTO approvalSearchDTO) {
        //查询
        Page<ApprovalVO> approvalVOList=baseMapper.list(pageParamDTO.toPage(ApprovalVO.class),approvalSearchDTO);
        //封装对象
        AjaxResult<List<ApprovalVO>> success = AjaxResult.success(approvalVOList.getRecords());
        success.setTotal(approvalVOList.getTotal());
        //响应
        return success;
    }

    @Override
    public AjaxResult<ApprovalDetailVO> getApprovalDetailsById(Long id) {
        //获取审批
        Approval approval = getById(id);
        if (Objects.isNull(approval)){
            throw new ServiceException("错误请求");
        }
        ApprovalVO approvalVO = approvalConverter.po2vo(approval);
        //获取开课计划
        OpeningPlanVO openingPlanVO = openingPlanService.getPlanById(approval.getOpeningPlanId()).getData();
        //封装对象
        ApprovalDetailVO approvalDetailVO = new ApprovalDetailVO();
        approvalDetailVO.setApproval(approvalVO);
        approvalDetailVO.setOpeningPlan(openingPlanVO);
        //响应
        return AjaxResult.success(approvalDetailVO);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> adminDelete(Long id) {
        Approval approval = lambdaQuery().eq(Approval::getId, id).last("for update").one();
        if (ApprovalTotalStateEnums.ADOPT.equals(approval.getState())){
            throw new ServiceException("已完成审核，无法删除");
        }
        //修改开课计划
        openingPlanService
                .lambdaUpdate()
                .eq(OpeningPlan::getId,approval.getOpeningPlanId())
                .set(OpeningPlan::getState,OpenPlanStateEnums.TEXTBOOKS_TO_BE_SELECT)
                .update();
        //删除审核
        boolean remove = removeById(id);
        log.info("ApprovalServiceImpl.adminDelete业务结束，结果:{}",remove);
        return AjaxResult.success(remove);
    }

    @Override
    public AjaxResult<List<TextbookVO>> getTextbookList(Long id) {
        //查询审核表
        Approval approval = getById(id);
        return textbookService.getByIds(approval.getTextbookIds());
    }

}




