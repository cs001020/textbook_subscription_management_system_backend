package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_grade
 */
@TableName(value ="tb_grade")
@Data
public class Grade implements Serializable {
    private Long id;

    private Long majorId;

    private Integer year;

    private String number;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}