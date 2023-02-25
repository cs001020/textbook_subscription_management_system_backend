package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.ApprovalDTO;
import com.chen.graduation.beans.DTO.ApprovalInsertDTO;
import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.PO.Approval;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.ApprovalVO;
import com.chen.graduation.converter.ApprovalConverter;
import com.chen.graduation.converter.TextbookConverter;
import com.chen.graduation.enums.ApprovalStateEnums;
import com.chen.graduation.enums.ApprovalTotalStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.ApprovalService;
import com.chen.graduation.mapper.ApprovalMapper;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.service.TextbookService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
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
        //插入
        boolean b = this.updateById(approval);
        log.info("ApprovalServiceImpl.teachingGroupApproval业务结束，结果:{}", b);
        if (!b) {
            throw new ServiceException("操作失败");
        }
        // FIXME: 2023/2/22 教材order
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

}




