package com.chen.graduation.beans.VO;

import com.chen.graduation.enums.ApprovalStateEnums;
import com.chen.graduation.enums.ApprovalTotalStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 审批表VO
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Data
@ApiModel("审批表VO")
public class ApprovalVO implements Serializable {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("开课计划id")
    private Long openingPlanId;
    @ApiModelProperty("教材id")
    private String textbookIds;
    @ApiModelProperty("教学组审批状态")
    private ApprovalStateEnums teachingGroupState;
    @ApiModelProperty("教学组审批信息")
    private String teachingGroupMessage;
    @ApiModelProperty("二级学院审批状态")
    private ApprovalStateEnums secondaryCollegeState;
    @ApiModelProperty("二级学院审批信息")
    private String secondaryCollegeMessage;
    @ApiModelProperty("教务处审批状态")
    private ApprovalStateEnums deansOfficeState;
    @ApiModelProperty("教务处审批信息")
    private String deansOfficeMessage;
    @ApiModelProperty("审批状态")
    private ApprovalTotalStateEnums state;
    @ApiModelProperty("发起人")
    private TeacherVO teacher;
    @ApiModelProperty("创建时间")
    private Date createTime;
    @ApiModelProperty("更新时间")
    private Date updateTime;

    private static final long serialVersionUID = 1L;
}
