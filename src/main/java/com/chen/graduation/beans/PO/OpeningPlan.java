package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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

    @TableId(type = IdType.AUTO)
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
