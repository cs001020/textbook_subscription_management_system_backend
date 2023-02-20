package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * 简单用户信息
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Data
@ApiModel("简易用户信息")
public class SimpleUserInfoVO {
    private String name;
    private String icon;
    private String sate;
    private String token;
}
