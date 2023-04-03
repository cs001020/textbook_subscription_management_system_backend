package com.chen.graduation.beans.DTO;

import com.chen.graduation.constants.SystemConstants;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 * 用户资料更新dto
 *
 * @author CHEN
 * @date 2023/04/03
 */
@Data
@ApiModel("用户资料更新dto")
public class UserProfileUpdateDTO {
    @ApiModelProperty("用户名称")
    @NotBlank(message = "参数异常")
    @Length(max = 20,message = "用户名长度不能20")
    private String name;
    @ApiModelProperty("手机号码")
    @NotBlank(message = "参数异常")
    @Pattern(regexp = SystemConstants.PHONE_REGEXP,message =  "手机号码格式错误")
    private String phoneNumber;
    @ApiModelProperty("邮箱")
    @NotBlank(message = "参数异常")
    @Email(message = "邮箱格式错误")
    private String email;
    @ApiModelProperty("性别")
    @NotNull(message = "参数异常")
    private Integer sex;

}
