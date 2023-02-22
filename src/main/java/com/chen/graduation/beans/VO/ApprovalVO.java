package com.chen.graduation.beans.VO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.chen.graduation.enums.ApprovalStateEnums;
import com.chen.graduation.enums.ApprovalTotalStateEnums;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @TableName tb_approval
 */
@TableName(value = "tb_approval")
@Data
public class ApprovalVO implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long openingPlanId;

    private String textbookIds;

    private ApprovalStateEnums teachingGroupState;

    private String teachingGroupMessage;

    private ApprovalStateEnums secondaryCollegeState;

    private String secondaryCollegeMessage;

    private ApprovalStateEnums deansOfficeState;

    private String deansOfficeMessage;

    private ApprovalTotalStateEnums state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}
