package com.chen.graduation.beans.DTO;

import com.chen.graduation.constants.SystemConstants;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 * 短信登录dto
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Data
@ApiModel("短信登陆参数")
public class SmsLoginDTO {
    @ApiModelProperty(value = "手机号，需要输入正确格式")
    @Pattern(regexp = SystemConstants.PHONE_REGEXP,message = "手机号格式错误")
    @NotNull(message = "手机号码不能为空")
    private String phoneNumber;
    @ApiModelProperty("验证码")
    @Length(max = 6,message = "验证码格式错误")
    @NotNull(message = "验证码不能为空")
    private Integer code;
}
