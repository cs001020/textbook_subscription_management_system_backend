package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 图形验证码VO
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Data
@ApiModel("token")
@AllArgsConstructor
public class TokenVO {
    @ApiModelProperty("token")
    private String token;

    @ApiModelProperty("请将token携带于该请求头上")
    private String requestHand;
}
