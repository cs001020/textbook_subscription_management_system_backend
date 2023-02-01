package com.chen.graduation.model.VO;

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
    @ApiModelProperty("图片验证码uid")
    private String uid;
    @ApiModelProperty("图片验证码base64格式")
    private String captcha;
}
