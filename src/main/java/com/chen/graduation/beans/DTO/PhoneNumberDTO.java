package com.chen.graduation.beans.DTO;

import com.chen.graduation.constants.SystemConstants;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 * 电话号码dto
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Data
public class PhoneNumberDTO {
    @ApiModelProperty(value = "手机号，需要输入正确格式",required = true,example = "17612341234")
    @Pattern(regexp = SystemConstants.PHONE_REGEXP,message = "手机号格式错误")
    @NotBlank(message = "手机号不能为空")
    private String phoneNumber;
}
