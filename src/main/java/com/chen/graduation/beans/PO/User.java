package com.chen.graduation.beans.PO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.enums.UserTypeEnums;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

/**
 * @TableName tb_user
 */
@TableName(value ="tb_user")
@Data
public class User implements Serializable {

    @TableId(type = IdType.AUTO)
    @NotNull(message = "id不能为空")
    private Long id;
    @NotBlank(message = "用户账号不能为空")
    @Size(min = 2, max = 30, message = "用户账号长度不能超过30个字符")
    private String account;
    @JSONField(serialize = false)
    @Size(min = 2, max = 30, message = "密码长度不能超过30个字符")
    private String password;
    @Size( max = 11, message = "手机号码长度不能超过11个字符")
    @Pattern(regexp = SystemConstants.PHONE_REGEXP,message = "手机号码格式错误")
    private String phoneNumber;

    private Long teachingGroupId;

    private Long secondaryCollegeId;

    private Long gradeId;
    @Size(min = 2, max = 30, message = "用户昵称长度不能超过30个字符")
    private String name;

    private String icon;

    private String introduction;
    private UserStateEnums state;
    private UserTypeEnums type;
    private Date createTime;

    private Date updateTime;
    @JSONField(serialize = false)
    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}
