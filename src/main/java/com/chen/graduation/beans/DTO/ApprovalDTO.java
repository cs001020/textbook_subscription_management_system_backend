package com.chen.graduation.beans.DTO;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 审批dto
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Data
public class ApprovalDTO implements Serializable {

    private Long id;

    private Long openingPlanId;

    private Long textbookIds;

    private Integer teachingGroupState;

    private String teachingGroupMessage;

    private Integer secondaryCollegeState;

    private String secondaryCollegeMessage;

    private Integer deansOfficeState;

    private String deansOfficeMessage;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}
