package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.ApprovalDTO;
import com.chen.graduation.beans.DTO.ApprovalInsertDTO;
import com.chen.graduation.beans.DTO.ApprovalSearchDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Approval;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.ApprovalDetailVO;
import com.chen.graduation.beans.VO.ApprovalVO;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.enums.ApprovalTotalStateEnums;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_approval(审批)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface ApprovalService extends IService<Approval> {

    /**
     * 提交申请
     *
     * @param approvalInsertDTO 批准dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> submit(ApprovalInsertDTO approvalInsertDTO);

    /**
     * 教学组批准
     *
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> teachingGroupApproval(Long id, ApprovalDTO approvalDTO);

    /**
     * 二级学院批准
     *
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> secondaryCollegeApproval(Long id, ApprovalDTO approvalDTO);

    /**
     * 教务处批准
     *
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> academicAffairsOfficeApproval(Long id, ApprovalDTO approvalDTO);


    /**
     * 根据状态获取审核列表
     * 如果不传参，则会查询所有
     *
     * @param approvalTotalStateEnums 总批准状态枚举
     * @return {@link AjaxResult}<{@link List}<{@link ApprovalVO}>>
     */
    AjaxResult<List<ApprovalVO>> getApprovalByState(ApprovalTotalStateEnums approvalTotalStateEnums);

    /**
     * 获得用户教材申请
     *
     * @return {@link AjaxResult}<{@link List}<{@link ApprovalVO}>>
     */
    AjaxResult<List<ApprovalVO>> getApprovalByUser();


    /**
     * 获得批准列表
     *
     * @param pageParamDTO      页面参数dto
     * @param approvalSearchDTO 搜索dto批准
     * @return {@link AjaxResult}<{@link List}<{@link ApprovalVO}>>
     */
    AjaxResult<List<ApprovalVO>> getApprovalList(PageParamDTO pageParamDTO, ApprovalSearchDTO approvalSearchDTO);

    /**
     * 根据id获得批准详情
     *
     * @param id id
     * @return {@link AjaxResult}<{@link List}<{@link ApprovalVO}>>
     */
    AjaxResult<ApprovalDetailVO> getApprovalDetailsById(Long id);

    /**
     * 管理员删除
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> adminDelete(Long id);

    /**
     * 获得课本列表
     *
     * @param id id
     * @return {@link AjaxResult}<{@link List}<{@link TextbookVO}>>
     */
    AjaxResult<List<TextbookVO>> getTextbookList(Long id);
}
