package com.chen.graduation.beans.VO;

import com.alibaba.fastjson.serializer.ToStringSerializer;
import com.alibaba.fastjson2.annotation.JSONField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 图形验证码VO
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Data
@ApiModel("图形验证码")
public class CaptchaVO implements Serializable {
    @ApiModelProperty("图片验证码唯一id")
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long uid;
    @ApiModelProperty("图片验证码base64格式")
    private String captcha;

    private static final long serialVersionUID = 1L;
}
