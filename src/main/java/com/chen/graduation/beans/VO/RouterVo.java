package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;


/**
 * 路由VO
 *
 * @author CHEN
 * @date 2023/03/01
 */
@Data
@ApiModel("路由")
public class RouterVo {
    @ApiModelProperty("路由名字")
    private String name;
    @ApiModelProperty("路由重定向")
    private String redirect;
    @ApiModelProperty("路由地址")
    private String path;
    @ApiModelProperty("是否隐藏路由，当设置 true 的时候该路由不会再侧边栏出现")
    private boolean hidden;
    @ApiModelProperty("组件地址")
    private String component;
    @ApiModelProperty("当你一个路由下面的 children 声明的路由大于1个时，自动会变成嵌套的模式--如组件页面")
    private Boolean alwaysShow;
    @ApiModelProperty("组件元信息")
    private MetaVo meta;
    @ApiModelProperty("子路由")
    private List<RouterVo> children;


}
