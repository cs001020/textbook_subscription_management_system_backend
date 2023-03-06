package com.chen.graduation.beans.VO;

import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.enums.OperateLogStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 操作日志VO
 *
 * @author CHEN
 * @date 2023/03/06
 */
@Data
@ApiModel("操作日志VO")
public class OperateLogVO implements Serializable {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("模块标题")
    private String title;
    @ApiModelProperty("业务类型")
    private BusinessTypeEnums businessType;
    @ApiModelProperty("方法名称")
    private String method;
    @ApiModelProperty("请求方式")
    private String requestMethod;
    @ApiModelProperty("操作人员")
    private String operatorName;
    @ApiModelProperty("请求URL")
    private String operateUrl;
    @ApiModelProperty("主机地址")
    private String operateIp;
    @ApiModelProperty("请求参数")
    private String operateParam;
    @ApiModelProperty("返回参数")
    private String jsonResult;
    @ApiModelProperty("操作状态")
    private OperateLogStateEnums status;
    @ApiModelProperty("错误消息")
    private String errorMsg;
    @ApiModelProperty("操作时间")
    private Date operateTime;

}
