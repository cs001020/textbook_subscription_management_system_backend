package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_user
 */
@TableName(value ="tb_user")
@Data
public class User implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String account;

    private String password;

    private String phoneNumber;

    private Long teachingGroupId;

    private Long secondaryCollegeId;

    private Long gradeId;

    private String name;

    private String icon;

    private String introduction;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}
