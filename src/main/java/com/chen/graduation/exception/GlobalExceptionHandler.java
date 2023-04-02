package com.chen.graduation.exception;

import com.chen.graduation.beans.VO.AjaxResult;
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
public class GlobalExceptionHandler{
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
     * 业务异常
     *
     * @param e e
     * @return {@link AjaxResult}<{@link Object}>
     */
    @ExceptionHandler(ServiceException.class)
    public AjaxResult<Object> handleServiceException(ServiceException e) {
        String message = e.getMessage();
        log.error(message, e);
        return AjaxResult.error(message);
    }

    /**
     * 业务异常
     *
     * @param e e
     * @return {@link AjaxResult}<{@link Object}>
     */
    @ExceptionHandler(UnAuthenticationException.class)
    public AjaxResult<Object> handleUnAuthenticationException(UnAuthenticationException e) {
        log.error("未登录异常",e);
        return new AjaxResult<>(AjaxResult.ResponseType.UN_AUTH,"尚未登录，请登录",null);
    }

    /**
     * 鉴权异常
     *
     * @return {@link AjaxResult}<{@link Object}>
     */
    @ExceptionHandler(AuthorizationException.class)
    public AjaxResult<Object> handleUnAuthorizationException() {
        log.warn("鉴权异常");
        return new AjaxResult<>(AjaxResult.ResponseType.UN_AUTHORIZATION,"无权限访问",null);
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
