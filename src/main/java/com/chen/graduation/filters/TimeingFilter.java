package com.chen.graduation.filters;

import lombok.Data;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * 耗时过滤器
 *
 * @author CHEN
 * @date 2023/01/31
 */
@WebFilter("/")
@Slf4j
@Setter
@Component
@ConditionalOnProperty(value = "timing.enable", havingValue = "true")
@ConfigurationProperties(prefix = "timing")
public class TimeingFilter implements Filter {
    /**
     * 警告时间
     * 接口响应超过该时间，打印警告日志
     */
    private int warningTime = 300;
    /**
     * 启用该过滤器
     */
    private boolean enable = false;

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        //获取当前时间
        long start = System.currentTimeMillis();
        //放行
        filterChain.doFilter(servletRequest, servletResponse);
        //计算耗时
        long total = System.currentTimeMillis() - start;
        //获取请求路径
        String requestUri = ((HttpServletRequest) servletRequest).getRequestURI();
        //判断时候超过警告时间
        if (total > warningTime) {
            log.warn(requestUri + "接口耗时:{}ms", total);
            return;
        }
        log.info(requestUri + "接口耗时:{}ms", total);
    }
}
