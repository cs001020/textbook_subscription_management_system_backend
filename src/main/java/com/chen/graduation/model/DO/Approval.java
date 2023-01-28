package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_approval
 */
@TableName(value ="tb_approval")
@Data
public class Approval implements Serializable {
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