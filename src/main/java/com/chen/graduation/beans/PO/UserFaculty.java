package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_user_faculty
 */
@TableName(value ="tb_user_faculty")
@Data
public class UserFaculty implements Serializable {
    private Long id;

    private String account;

    private String password;

    private String phoneNumber;

    private Long teachingGroupId;

    private Long secondaryCollegeId;

    private String name;

    private String icon;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}