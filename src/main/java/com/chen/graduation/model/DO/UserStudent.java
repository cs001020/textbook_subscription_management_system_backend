package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_user_student
 */
@TableName(value ="tb_user_student")
@Data
public class UserStudent implements Serializable {
    private Long id;

    private String account;

    private String password;

    private String phoneNumber;

    private Long gradeId;

    private String name;

    private String icon;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}