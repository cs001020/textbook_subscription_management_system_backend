package com.chen.graduation.utils;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.extra.spring.SpringUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.chen.graduation.beans.PO.LoginLog;
import com.chen.graduation.beans.PO.OperateLog;

import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.enums.LoginLogStateEnums;
import com.chen.graduation.enums.TextbookStateEnums;
import com.chen.graduation.service.LoginLogService;
import com.chen.graduation.service.TeachingGroupService;
import com.chen.graduation.service.TextbookService;
import com.chen.graduation.service.impl.OperateLogServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;
import java.util.TimerTask;
import java.util.stream.Collectors;

/**
 * 异步工厂（产生任务用）
 *
 * @author CHEN
 * @date 2023/03/05
 */
@Slf4j
public class AsyncFactory {
    /**
     * 操作日志记录
     *
     * @param operateLog 操作日志信息
     * @return 任务task
     */
    public static TimerTask recordOperate(final OperateLog operateLog) {
        return new TimerTask() {
            @Override
            public void run() {
                SpringUtil.getBean(OperateLogServiceImpl.class).save(operateLog);
            }
        };
    }

    /**
     * 记录登录信息
     *
     * @param username 用户名
     * @param status   状态
     * @param message  消息
     * @return 任务task
     */
    public static TimerTask recordLoginLog(final String username, final LoginLogStateEnums status, final String message) {
        //获取请求
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes) attributes).getRequest();
        //获取userAgent
        final UserAgent userAgent = UserAgentUtil.parse(request.getHeader("User-Agent"));
        //获取ip地址
        String ip1 = ServletUtil.getClientIP(request);
        final String ip = "0:0:0:0:0:0:0:1".equals(ip1) ? "127.0.0.1" : ip1;
        return new TimerTask() {
            @Override
            public void run() {
                //获取地址
                String address = "";
                if ("127.0.0.1".equals(ip)) {
                    address = "内网ip";
                } else {
                    address = AddressUtils.getRealAddressByIp(ip);
                }
                // 获取客户端操作系统
                String os = userAgent.getOs().toString();
                // 获取客户端浏览器
                String browser = userAgent.getBrowser().getName();
                // 封装对象
                LoginLog loginLog = new LoginLog();
                loginLog.setAccount(username);
                loginLog.setIp(ip);
                loginLog.setLoginLocation(address);
                loginLog.setBrowser(browser);
                loginLog.setOs(os);
                loginLog.setMessage(message);
                loginLog.setState(status);
                // 插入数据
                SpringUtil.getBean(LoginLogService.class).save(loginLog);
            }
        };
    }

    /**
     * 删除审核中的教材
     *
     * @param ids ids
     * @return {@link TimerTask}
     */
    public static TimerTask deleteAuditTextbook(final String ids) {
        return new TimerTask() {
            @Override
            public void run() {
                List<Long> collect = Arrays.stream(ids.split(",")).map(Long::valueOf).collect(Collectors.toList());
                SpringUtil.getBean(TextbookService.class)
                        .lambdaUpdate()
                        .eq(Textbook::getState, TextbookStateEnums.AUDIT)
                        .in(Textbook::getId,collect)
                        .remove();
            }
        };
    }
}
