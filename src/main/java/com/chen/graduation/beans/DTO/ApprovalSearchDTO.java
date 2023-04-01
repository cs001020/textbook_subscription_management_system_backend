package com.chen.graduation.beans.DTO;

import com.chen.graduation.enums.ApprovalStateEnums;
import com.chen.graduation.enums.ApprovalTotalStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;


/**
 * 申请表搜索DTO
 *
 * @author CHEN
 * @date 2023/03/30
 */
@Data
@ApiModel("申请表搜索DTO")
public class ApprovalSearchDTO implements Serializable {
    @ApiModelProperty("审批状态 1待审核 2通过 3驳回")
    private String state;
    @ApiModelProperty("发起人")
    private String name;
    @ApiModelProperty("开始时间,请输入正确格式(yyyy-MM-dd)")
    private String beginTime;
    @ApiModelProperty("结束时间,请输入正确格式(yyyy-MM-dd)")
    private String endTime;
    private static final long serialVersionUID = 1L;
}
