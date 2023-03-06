package com.chen.graduation.beans.VO;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.format.DateTimeFormat;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.enums.OperateLogStateEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.format.DateTimeFormatter;
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
    @ExcelProperty("日志序号")
    private Long id;
    @ApiModelProperty("模块标题")
    @ExcelProperty("模块")
    private String title;
    @ApiModelProperty("业务类型")
    @ExcelProperty("业务类型")
    private String businessType;
    @ApiModelProperty("方法名称")
    @ExcelProperty("方法名称")
    @ColumnWidth(52)
    private String method;
    @ApiModelProperty("请求方式")
    @ExcelProperty("请求方式")
    private String requestMethod;
    @ApiModelProperty("操作人员")
    @ExcelProperty("操作人员")
    private String operatorName;
    @ApiModelProperty("请求URL")
    @ExcelProperty("请求URL")
    @ColumnWidth(17)
    private String operateUrl;
    @ApiModelProperty("主机地址")
    @ExcelProperty("主机地址")
    private String operateIp;
    @ApiModelProperty("请求参数")
    @ExcelProperty("请求参数")
    @ColumnWidth(13)
    private String operateParam;
    @ApiModelProperty("返回参数")
    @ExcelProperty("返回参数")
    @ColumnWidth(13)
    private String jsonResult;
    @ApiModelProperty("操作状态")
    @ExcelProperty("操作状态")
    private String status;
    @ApiModelProperty("错误消息")
    @ExcelProperty("错误消息")
    @ColumnWidth(15)
    private String errorMsg;
    @ApiModelProperty("操作时间")
    @ExcelProperty("操作时间")
    @DateTimeFormat("yyyy-MM-dd HH:ss:mm")
    @ColumnWidth(18)
    private Date operateTime;

}
