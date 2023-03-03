package com.chen.graduation.beans.DTO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;


/**
 * 审批dto
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Data
@ApiModel("申请表添加DTO")
public class ApprovalInsertDTO implements Serializable {
    @ApiModelProperty("开课计划id")
    @NotNull(message = "未选定开课计划")
    private Long openingPlanId;

    @ApiModelProperty("教材ids(从教材库选取的)")
    private List<Long> textBookIds;
    @ApiModelProperty("新教材列表")
    @Valid
    private List<TextbookDTO> textbookDTOList;

    private static final long serialVersionUID = 1L;
}
