package com.chen.graduation.converter;

import com.chen.graduation.beans.PO.Approval;
import com.chen.graduation.beans.VO.ApprovalVO;
import org.mapstruct.Mapper;

import java.util.List;


/**
 * 批准转换器
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Mapper(componentModel = "spring")
public interface ApprovalConverter {


    /**
     * po2vo
     *
     * @param approval 批准
     * @return {@link ApprovalVO}
     */
    ApprovalVO po2vo(Approval approval);

    /**
     * po2vos
     *
     * @param approvalList 审批列表
     * @return {@link List}<{@link ApprovalVO}>
     */
    List<ApprovalVO> po2vos(List<Approval> approvalList);
}
