package com.chen.graduation.beans.VO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * 路由元数据VO
 *
 * @author CHEN
 * @date 2023/03/01
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("组件元信息VO")
public class MetaVo {
    @ApiModelProperty("设置该路由在侧边栏和面包屑中展示的名字")
    private String title;
    @ApiModelProperty("设置该路由的图标，对应路径src/assets/icons/svg")
    private String icon;

}

