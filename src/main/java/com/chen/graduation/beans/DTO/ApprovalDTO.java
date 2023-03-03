package com.chen.graduation.beans.DTO;

import com.chen.graduation.enums.ApprovalStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
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
@ApiModel("申请表DTO")
public class ApprovalDTO implements Serializable {
    @ApiModelProperty("审批状态")
    @NotNull(message = "状态参数异常")
    private ApprovalStateEnums approvalStateEnums;

    @ApiModelProperty("消息")
    @NotBlank(message = "消息参数异常")
    private String message;
    private static final long serialVersionUID = 1L;
}
