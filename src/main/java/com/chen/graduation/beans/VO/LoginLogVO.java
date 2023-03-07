package com.chen.graduation.beans.VO;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.format.DateTimeFormat;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.chen.graduation.enums.LoginLogStateEnums;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 登录日志VO
 *
 * @author CHEN
 * @date 2023/03/06
 */
@Data
public class LoginLogVO implements Serializable {
    @ApiModelProperty("id")
    @ExcelProperty("日志序号")
    private Long id;
    @ApiModelProperty("用户")
    @ExcelProperty("用户")
    @ColumnWidth(12)
    private String account;
    @ApiModelProperty("登陆ip")
    @ExcelProperty("登陆ip")
    private String ip;
    @ApiModelProperty("浏览器")
    @ExcelProperty("浏览器")
    private String browser;
    @ApiModelProperty("操作系统")
    @ExcelProperty("操作系统")
    @ColumnWidth(30)
    private String os;
    @ApiModelProperty("登陆地点")
    @ExcelProperty("登陆地点")
    private String loginLocation;
    @ApiModelProperty("登录状态")
    @ExcelProperty("登录状态")
    private String state;
    @ApiModelProperty("提示信息")
    @ExcelProperty("提示信息")
    @ColumnWidth(16)
    private String message;
    @ApiModelProperty("登录时间")
    @ExcelProperty("登录时间")
    @DateTimeFormat("yyyy-MM-dd HH:ss:mm")
    @ColumnWidth(18)
    private Date accessTime;



    private static final long serialVersionUID = 1L;

}
