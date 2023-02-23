package com.chen.graduation.beans.VO;

import com.alibaba.fastjson.serializer.ToStringSerializer;
import com.alibaba.fastjson2.annotation.JSONField;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


/**
 * 二级学院签证官
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Data
public class SecondaryCollegeVO implements Serializable {
    @ApiModelProperty("id")
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long id;
    @ApiModelProperty("学院名")
    private String name;

    private static final long serialVersionUID = 1L;
}
