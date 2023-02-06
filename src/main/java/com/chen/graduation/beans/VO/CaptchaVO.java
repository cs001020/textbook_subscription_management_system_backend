package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 图形验证码VO
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Data
@ApiModel("图形验证码")
public class CaptchaVO {
    @ApiModelProperty("图片验证码唯一id")
    private Long uid;
    @ApiModelProperty("图片验证码base64格式")
    private String captcha;
}
