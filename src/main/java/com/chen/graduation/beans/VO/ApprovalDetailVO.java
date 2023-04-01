package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 审批详情
 *
 * @author CHEN
 * @date 2023/03/30
 */
@ApiModel("审批详情")
@Data
public class ApprovalDetailVO {
    @ApiModelProperty("审批")
    private ApprovalVO approval;
    @ApiModelProperty("开课计划")
    private OpeningPlanVO openingPlan;
}
