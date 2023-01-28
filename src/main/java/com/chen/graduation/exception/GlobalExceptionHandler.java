package com.chen.graduation.exception;

import com.chen.graduation.model.VO.AjaxResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;

/**
 * 全局异常处理程序
 *
 * @author CHEN
 * @date 2023/01/28
 */

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
    /**
     * z自定义参数校验异常
     *
     * @param e e
     * @return {@link AjaxResult}<{@link Object}>
     */
    @ExceptionHandler(BindException.class)
    public AjaxResult<Object> handleBindException(BindException e) {
        log.error(e.getMessage(), e);
        String message = e.getAllErrors().get(0).getDefaultMessage();
        return AjaxResult.error(message);
    }


    /**
     * 请求方法不支持
     *
     * @param e       e
     * @param request 请求
     * @return {@link AjaxResult}
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public AjaxResult<Object> handleHttpRequestMethodNotSupported(HttpRequestMethodNotSupportedException e,
                                                          HttpServletRequest request) {
        String requestUri = request.getRequestURI();
        log.error("请求地址'{}',不支持'{}'请求", requestUri, e.getMethod());
        return AjaxResult.error("请求地址'"+requestUri+"',不支持'"+e.getMethod()+"'请求");
    }


    /**
     * 拦截未知的运行时异常
     *
     * @param e       e
     * @param request 请求
     * @return {@link AjaxResult}
     */
    @ExceptionHandler(RuntimeException.class)
    public AjaxResult<Object> handleRuntimeException(RuntimeException e, HttpServletRequest request) {
        String requestUri = request.getRequestURI();
        log.error("请求地址'{}',发生未知异常.", requestUri, e);
        return AjaxResult.error("请求地址'" + requestUri + "',发生未知异常");
    }


    /**
     * 系统异常
     *
     * @param e       e
     * @param request 请求
     * @return {@link AjaxResult}
     */
    @ExceptionHandler(Exception.class)
    public AjaxResult<Object> handleException(Exception e, HttpServletRequest request) {
        String requestUri = request.getRequestURI();
        log.error("请求地址'{}',发生系统异常.", requestUri, e);
        return AjaxResult.error("请求地址'" + requestUri + "',发生未知异常");
    }
}
