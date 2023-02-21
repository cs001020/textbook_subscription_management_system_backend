package com.chen.graduation.beans.DTO;

import com.chen.graduation.constants.SystemConstants;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * 账户登录dto
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Data
@ApiModel("账号密码登录参数")
public class AccountLoginDTO {
    @ApiModelProperty("账号")
    @Length(max = 20,message = "非法参数")
    @NotBlank(message = "账号不能为空")
    private String account;
    @ApiModelProperty("密码")
    @Length(max = SystemConstants.PASSWORD_MAX_SIZE,message = "非法参数")
    @NotBlank(message = "密码不能为空")
    private String password;
    @ApiModelProperty("验证码uid")
    @NotBlank(message = "验证码不能为空")
    private String captchaUid;
    @ApiModelProperty("验证码")
    @Length(max = 10,message = "验证码异常")
    @NotBlank(message = "验证码不能为空")
    private String captcha;

}
