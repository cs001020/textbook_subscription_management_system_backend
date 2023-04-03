package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 简单用户信息
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Data
@ApiModel("简易用户信息")
public class SimpleUserInfoVO implements Serializable {

    @ApiModelProperty("昵称")
    private String name;
    @ApiModelProperty("头像url")
    private String avatar;
    @ApiModelProperty("简介")
    private String introduction;
    @ApiModelProperty("角色列表")
    private List<Object> roles;
    @ApiModelProperty("路由列表")
    private List<RouterVo> routers;
    @ApiModelProperty("权限列表列表")
    private List<String> permissions;

    private static final long serialVersionUID = 1L;
}
