package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.LoginLogSearchDTO;
import com.chen.graduation.beans.DTO.OperateLogSearchDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.LoginLogVO;
import com.chen.graduation.beans.VO.OperateLogVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.LoginLogService;
import com.chen.graduation.service.OperateLogService;
import com.chen.graduation.utils.ExcelUtils;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 日志控制器
 *
 * @author CHEN
 * @date 2023/03/06
 */
@Slf4j
@Api(tags = "日志")
@ApiSupport(author = "1006596474@qq.com", order = 7)
@RestController
@RequestMapping("/log")
public class LogController {
    @Resource
    private OperateLogService operateLogService;

    @Resource
    private LoginLogService loginLogService;
    @Auth({"system:operateLog:list"})
    @ApiOperation("操作日志查询")
    @GetMapping("/operate/list")
    public AjaxResult<List<OperateLogVO>> operateLogList(@Validated OperateLogSearchDTO operateLogSearchDTO) {
        //查询日志
        return operateLogService.selectOperLogList(operateLogSearchDTO);
    }

    /**
     * 导出日志
     * 注意 请勿使用swagger2接口文档调试 存在bug
     * 请使用postman或者浏览器访问
     *
     * @param response 响应
     */
    @Auth({"system:operateLog:export"})
    @ApiOperation("操作日志导出(请勿使用swagger调试，存在bug，请使用postman等工具调试)")
    @Log(title = "操作日志", businessTypeEnums = BusinessTypeEnums.EXPORT)
    @PostMapping("/operate/export")
    public void operateLogExport(HttpServletResponse response, @RequestBody @Validated OperateLogSearchDTO operateLogSearchDTO) {
        //查询日志
        AjaxResult<List<OperateLogVO>> listAjaxResult = operateLogService.selectOperLogList(operateLogSearchDTO);
        List<OperateLogVO> listAjaxResultData = listAjaxResult.getData();
        //导出日志
        try {
            ExcelUtils.exportOperateLog(response, listAjaxResultData);
        } catch (IOException e) {
            throw new ServiceException("导出发生未知异常");
        }
    }

    @Auth({"system:loginLog:list"})
    @ApiOperation("登陆日志查询")
    @GetMapping("/login/list")
    public AjaxResult<List<LoginLogVO>> loginLogList(@Validated LoginLogSearchDTO loginLogSearchDTO) {
        //查询日志
        return loginLogService.selectLoginLogList(loginLogSearchDTO);
    }

    /**
     * 导出日志
     * 注意 请勿使用swagger2接口文档调试 存在bug
     * 请使用postman或者浏览器访问
     *
     * @param response 响应
     */
    @Auth({"system:loginLog:export"})
    @ApiOperation("登陆日志导出(请勿使用swagger调试，存在bug，请使用postman等工具调试)")
    @Log(title = "登陆日志", businessTypeEnums = BusinessTypeEnums.EXPORT)
    @PostMapping("/login/export")
    public void loginLogExport(HttpServletResponse response,@RequestBody @Validated LoginLogSearchDTO loginLogSearchDTO) {
        //查询日志
        AjaxResult<List<LoginLogVO>> listAjaxResult = loginLogService.selectLoginLogList(loginLogSearchDTO);
        List<LoginLogVO> listAjaxResultData = listAjaxResult.getData();
        //导出日志
        try {
            ExcelUtils.exportLoginLog(response, listAjaxResultData);
        } catch (IOException e) {
            throw new ServiceException("导出发生未知异常");
        }
    }

}
