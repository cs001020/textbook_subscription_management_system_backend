package com.chen.graduation.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.graduation.beans.DTO.ApprovalSearchDTO;
import com.chen.graduation.beans.PO.Approval;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.ApprovalVO;
import com.chen.graduation.enums.ApprovalTotalStateEnums;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_approval(审批)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.Approval
*/
public interface ApprovalMapper extends BaseMapper<Approval> {
    /**
     * 列表
     *
     * @param toPage            到另一个页面
     * @param approvalSearchDTO 搜索dto批准
     * @return {@link Page}<{@link ApprovalVO}>
     */
    Page<ApprovalVO> list(Page<ApprovalVO> toPage,@Param("dto") ApprovalSearchDTO approvalSearchDTO);

    /**
     * 查询属于当前用户的教材申请
     *
     * @param id id
     * @return {@link List}<{@link ApprovalVO}>
     */
    List<ApprovalVO> getApprovalByUser(@Param("id") Long id);

    /**
     * 根据状态以及当前用户获取教材申请
     *
     * @param user                    用户
     * @param approvalTotalStateEnums 总批准状态枚举
     * @return {@link List}<{@link ApprovalVO}>
     */
    List<ApprovalVO> getApprovalByStateAndUser(@Param("user") User user,@Param("state") ApprovalTotalStateEnums approvalTotalStateEnums);
}




