package com.chen.graduation.beans.DTO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.chen.graduation.beans.PO.UserInfo;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.enums.UserTypeEnums;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * 添加用户dto
 *
 * @author CHEN
 * @date 2023/04/03
 */
@Data
@ApiModel("添加用户dto")
public class UserInsertDTO implements Serializable {

    @NotNull(message = "用状态不能为空")
    private UserTypeEnums type;
    @NotBlank(message = "用户账号不能为空")
    @Size(min = 2, max = 30, message = "用户账号长度不能超过30个字符")
    private String account;
    @NotBlank(message = "密码不能为空")
    @Size(min = 2, max = 30, message = "密码长度不能超过30个字符")
    private String password;
    @Size( max = 11, message = "手机号码长度不能超过11个字符")
    @Pattern(regexp = SystemConstants.PHONE_REGEXP,message = "手机号码格式错误")
    private String phoneNumber;
    @Email(message = "邮箱格式错误")
    private String email;
    @NotBlank(message = "用户昵称不能为空")
    @Size(min = 2, max = 30, message = "用户昵称长度不能超过30个字符")
    private String name;
    private Integer sex;
    private Long teachingGroupId;
    private Long secondaryCollegeId;
    private Long gradeId;
    @NotNull(message = "用户状态不能为空")
    private UserStateEnums state;
    private List<Long> roleIds;
    private String introduction;


    private static final long serialVersionUID = 1L;
}
