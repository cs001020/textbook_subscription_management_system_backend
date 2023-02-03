package com.chen.graduation.model.DTO;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
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
    @Pattern(regexp = "0?(13|14|15|18|17)[0-9]{9}",message = "手机号格式错误")
    @NotNull
    private String phoneNumber;
}
