package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_opening_plan
 */
@TableName(value ="tb_opening_plan")
@Data
public class OpeningPlan implements Serializable {
    private Long id;

    private String description;

    private Long teacherId;

    private Long gradeId;

    private String name;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}