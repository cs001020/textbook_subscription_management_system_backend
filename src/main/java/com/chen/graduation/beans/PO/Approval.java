package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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

    @TableId(type = IdType.AUTO)
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
