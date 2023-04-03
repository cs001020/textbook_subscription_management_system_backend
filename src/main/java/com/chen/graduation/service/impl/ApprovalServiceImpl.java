package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.*;
import com.chen.graduation.beans.PO.Approval;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.*;
import com.chen.graduation.converter.ApprovalConverter;
import com.chen.graduation.converter.TextbookConverter;
import com.chen.graduation.enums.*;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.*;
import com.chen.graduation.mapper.ApprovalMapper;
import com.chen.graduation.utils.AsyncFactory;
import com.chen.graduation.utils.AsyncManager;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
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
    @Resource
    private UserService userService;

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> submit(ApprovalInsertDTO approvalInsertDTO) {
        //参数校验
        if (CollectionUtil.isEmpty(approvalInsertDTO.getTextBookIds()) && CollectionUtil.isEmpty(approvalInsertDTO.getTextbookDTOList())) {
            throw new ServiceException("请选择教材");
        }
        if (Objects.isNull(approvalInsertDTO.getOpeningPlanId())){
            throw new ServiceException("非法请求");
        }
        //检查开课计划
        OpeningPlan openingPlan = openingPlanService
                .lambdaQuery()
                .eq(OpeningPlan::getId,approvalInsertDTO.getOpeningPlanId())
                .last("for update")
                .one();
        if (Objects.isNull(openingPlan)){
            throw new ServiceException("非法请求!!");
        }
        //检查开课计划 是否属于当前用户
        Long userId = UserHolderContext.getUserId();
        if (!userId.equals(openingPlan.getTeacherId())){
            throw new ServiceException("非法请求!!");
        }
        //检查开课计划状态
        if (!OpenPlanStateEnums.TEXTBOOKS_TO_BE_SELECT.equals(openingPlan.getState())){
            throw new ServiceException("当前开课计划已选择教材，请勿重复申请");
        }
        //初始化 审核教材ids
        List<Long> approvalInsertTextbookIds=new ArrayList<>();
        //检查教材
        List<Long> textBookIds = approvalInsertDTO.getTextBookIds();
        if(CollectionUtil.isNotEmpty(textBookIds)){
            String textBookIdsString = StrUtil.join(",", textBookIds);
            List<TextbookVO> textbookList = textbookService.getByIds(textBookIdsString).getData();
            //禁止选择重复教材
            if (textBookIds.size()!=textbookList.size()){
                throw new ServiceException("禁止选择重复教材");
            }
            for (TextbookVO textbookVO : textbookList) {
                //非状态状态图书无法选择
                if (!TextbookStateEnums.NORMAL.getStateName().equals(textbookVO.getState())){
                    throw new ServiceException("《"+textbookVO.getBookName()+"》，非正常状态无法选择");
                }
            }
            approvalInsertTextbookIds.addAll(textBookIds);
        }
        //添加新教材
        List<TextbookDTO> textbookDTOList = approvalInsertDTO.getTextbookDTOList();
        if (CollectionUtil.isNotEmpty(textbookDTOList)) {
            //绕过前端验证  纯在于旧图书同名的新图书
            if (UniqueEnums.UN_UNIQUE.equals(checkNewBookNameUnique(textbookDTOList))){
                throw new ServiceException("非法请求！！");
            }
            //列表同名判断
            if (checkHasSameName(textbookDTOList)){
                throw new ServiceException("请勿添加同名图书");
            }
            //插入数据
            List<Textbook> textbookList = textbookConverter.dto2vos(textbookDTOList);
            textbookService.saveBatch(textbookList);
            //获取教材ids
            List<Long> textbookIds = textbookList.stream().map(Textbook::getId).collect(Collectors.toList());
            approvalInsertTextbookIds.addAll(textbookIds);
        }
        String join = StrUtil.join(",", approvalInsertTextbookIds);
        //构建插入对象
        Approval approval = new Approval();
        approval.setOpeningPlanId(openingPlan.getId());
        approval.setTextbookIds(join);
        //插入
        boolean save = this.save(approval);
        //更新开课计划
        openingPlan.setState(OpenPlanStateEnums.WAITING_FOR_APPROVAL);
        openingPlanService.updateById(openingPlan);
        //打印日志
        log.info("ApprovalServiceImpl.submit业务结束，结果:{}", save);
        //响应
        if (!save) {
            throw new ServiceException("插入异常");
        }
        return AjaxResult.success();
    }

    @Override
    public AjaxResult<Object> reSubmit(ApprovalInsertDTO approvalInsertDTO, Long id) {
        //参数校验
        if (CollectionUtil.isEmpty(approvalInsertDTO.getTextBookIds()) && CollectionUtil.isEmpty(approvalInsertDTO.getTextbookDTOList())) {
            throw new ServiceException("请选择教材");
        }
        //检查 当前申请
        Approval approval = getById(id);
        if (Objects.isNull(approval)){
            throw new ServiceException("非法请求!!");
        }
        if (!ApprovalTotalStateEnums.REJECT.equals(approval.getState())){
            throw new ServiceException("非法请求!!");
        }
        //检查开课计划
        OpeningPlan openingPlan = openingPlanService
                .lambdaQuery()
                .eq(OpeningPlan::getId,approval.getOpeningPlanId())
                .last("for update")
                .one();
        if (Objects.isNull(openingPlan)){
            throw new ServiceException("非法请求!!");
        }
        //检查开课计划 是否属于当前用户
        Long userId = UserHolderContext.getUserId();
        if (!userId.equals(openingPlan.getTeacherId())){
            throw new ServiceException("非法请求!!");
        }
        //初始化 审核教材ids
        List<Long> approvalInsertTextbookIds=new ArrayList<>();
        //旧图书ids
        List<Long> oldTextBookIds = Arrays.stream(approval.getTextbookIds().split(",")).map(Long::valueOf).collect(Collectors.toList());
        //初始化被删除的教材
        List<Long> discardIds=new ArrayList<>(oldTextBookIds);
        //检查教材
        List<Long> textBookIds = approvalInsertDTO.getTextBookIds();
        if(CollectionUtil.isNotEmpty(textBookIds)){
            String textBookIdsString = StrUtil.join(",", textBookIds);
            List<TextbookVO> newTextbookList = textbookService.getByIds(textBookIdsString).getData();
            //禁止选择重复教材
            if (textBookIds.size()!=newTextbookList.size()){
                throw new ServiceException("禁止选择重复教材");
            }
            for (TextbookVO textbookVO : newTextbookList) {
                discardIds.remove(textbookVO.getId());
                if (oldTextBookIds.contains(textbookVO.getId())){
                    continue;
                }
                //非状态状态图书无法选择 且旧图书id不包含该图书
                if (!TextbookStateEnums.NORMAL.getStateName().equals(textbookVO.getState())){
                    throw new ServiceException("《"+textbookVO.getBookName()+"》，非正常状态无法选择");
                }
            }
            approvalInsertTextbookIds.addAll(textBookIds);
        }
        //添加新教材
        List<TextbookDTO> textbookDTOList = approvalInsertDTO.getTextbookDTOList();
        if (CollectionUtil.isNotEmpty(textbookDTOList)) {
            //绕过前端验证  纯在于旧图书同名的新图书
            if (UniqueEnums.UN_UNIQUE.equals(checkNewBookNameUnique(textbookDTOList))){
                throw new ServiceException("非法请求！！");
            }
            //列表同名判断
            if (checkHasSameName(textbookDTOList)){
                throw new ServiceException("请勿添加同名图书");
            }
            //插入数据
            List<Textbook> textbookList = textbookConverter.dto2vos(textbookDTOList);
            textbookService.saveBatch(textbookList);
            //获取教材ids
            List<Long> textbookIds = textbookList.stream().map(Textbook::getId).collect(Collectors.toList());
            approvalInsertTextbookIds.addAll(textbookIds);
        }
        String join = StrUtil.join(",", approvalInsertTextbookIds);
        //异步删除旧图书
        if (CollectionUtil.isNotEmpty(discardIds)){
            String discard = StrUtil.join(",", discardIds);
            AsyncManager.me().execute(AsyncFactory.deleteAuditTextbook(discard));
        }
        //修改对象
        approval.setTextbookIds(join);
        approval.setState(ApprovalTotalStateEnums.WAIT_GROUP);
        approval.setTeachingGroupState(ApprovalStateEnums.UNAPPROVED);
        approval.setTeachingGroupMessage("");
        approval.setSecondaryCollegeState(ApprovalStateEnums.UNAPPROVED);
        approval.setSecondaryCollegeMessage("");
        approval.setDeansOfficeState(ApprovalStateEnums.UNAPPROVED);
        approval.setDeansOfficeMessage("");
        //修改
        boolean update = this.updateById(approval);
        //打印日志
        log.info("ApprovalServiceImpl.submit业务结束，结果:{}", update);
        //响应
        if (!update) {
            throw new ServiceException("插入异常");
        }
        return AjaxResult.success();
    }

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
        //教务处审核通过 更新开课计划
        if (ApprovalStateEnums.ADOPT.equals(approvalDTO.getApprovalStateEnums())) {
            LambdaUpdateWrapper<OpeningPlan> updateWrapper=new LambdaUpdateWrapper<>();
            updateWrapper.eq(OpeningPlan::getId,approval.getOpeningPlanId()).set(OpeningPlan::getState, OpenPlanStateEnums.APPROVAL_COMPLETED);
            openingPlanService.update(updateWrapper);
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

    @Override
    public AjaxResult<List<ApprovalVO>> getApprovalByStateAndUser(ApprovalTotalStateEnums approvalTotalStateEnums) {
        //获取当前用户
        Long userId = UserHolderContext.getUserId();
        User user = userService.getById(userId);
        //非教师用户 视为非法请求
        if (UserTypeEnums.STUDENT.equals(user.getType())){
            throw new ServiceException("非法请求");
        }
        //转换
        List<ApprovalVO> approvalVOList = baseMapper.getApprovalByStateAndUser(user,approvalTotalStateEnums);
        //打印日志
        log.info("ApprovalServiceImpl.getUnApproval业务结束，结果:{}", approvalVOList);
        //响应
        return AjaxResult.success(approvalVOList);
    }

    @Override
    public AjaxResult<List<ApprovalVO>> getApprovalByUser() {
        //获取用户
        Long userId = UserHolderContext.getUserId();
        //查询
        List<ApprovalVO> approvalVOList = baseMapper.getApprovalByUser(userId);
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
        //异步删除审核中图书
        AsyncManager.me().execute(AsyncFactory.deleteAuditTextbook(approval.getTextbookIds()));
        log.info("ApprovalServiceImpl.adminDelete业务结束，结果:{}",remove);
        return AjaxResult.success(remove);
    }

    @Override
    public AjaxResult<List<TextbookVO>> getTextbookList(Long id) {
        //查询审核表
        Approval approval = getById(id);
        return textbookService.getByIds(approval.getTextbookIds());
    }

    /**
     * 检查新书名字独一无二
     *
     * @param textbookDTOList 教科书dtolist
     * @return {@link UniqueEnums}
     */
    private UniqueEnums checkNewBookNameUnique(List<TextbookDTO> textbookDTOList) {
        if (CollectionUtil.isEmpty(textbookDTOList)){
            throw new ServiceException("参数异常");
        }
        //获取图书名列表
        List<String> bookNameList = textbookDTOList.stream().map(TextbookDTO::getBookName).collect(Collectors.toList());
        //查询数据库
        Page<Textbook> page = textbookService.lambdaQuery().in(Textbook::getBookName, bookNameList).page(new Page<>(1, 1));
        List<Textbook> textbookList = page.getRecords();
        if (CollectionUtil.isEmpty(textbookList)){
            return UniqueEnums.UNIQUE;
        }
        return UniqueEnums.UN_UNIQUE;
    }

    /**
     * 检查该图书Dto列表是否存在同名
     *
     * @param textbookDTOList 教科书dtolist
     * @return boolean 存在同名放回tue
     */
    private boolean checkHasSameName(List<TextbookDTO> textbookDTOList) {
        if (CollectionUtil.isEmpty(textbookDTOList)){
            throw new ServiceException("参数异常");
        }
        Set<String> bookNameSet = textbookDTOList.stream().map(TextbookDTO::getBookName).collect(Collectors.toSet());
        return bookNameSet.size() != textbookDTOList.size();
    }

}




