package com.chen.graduation.beans.VO;

import com.alibaba.fastjson.serializer.ToStringSerializer;
import com.alibaba.fastjson2.annotation.JSONField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 主要签证官
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Data
@ApiModel("专业VO")
public class MajorVO implements Serializable {
    @ApiModelProperty("id")
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long id;
    @ApiModelProperty("专业名")
    private String name;
    @ApiModelProperty("创建时间")
    private Date createTime;

    private static final long serialVersionUID = 1L;
}
