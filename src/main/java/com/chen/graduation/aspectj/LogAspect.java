package com.chen.graduation.aspectj;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.support.spring.PropertyPreFilters;
import com.alibaba.fastjson2.JSON;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.PO.OperateLog;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.enums.OperateLogStateEnums;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.UserService;
import com.chen.graduation.utils.AsyncFactory;
import com.chen.graduation.utils.AsyncManager;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.CodeSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * 日志切面
 *
 * @author CHEN
 * @date 2023/03/05
 */
@Slf4j
@Component
@Aspect
public class LogAspect {

    @Resource
    private UserService userService;

    /**
     * 排除敏感属性字段
     */
    public static final String[] EXCLUDE_PROPERTIES = {"password", "oldPassword", "newPassword", "confirmPassword"};

    /**
     * 处理完请求后执行
     *
     * @param joinPoint 切点
     */
    @AfterReturning(pointcut = "@annotation(controllerLog)", returning = "jsonResult")
    public void doAfterReturning(JoinPoint joinPoint, Log controllerLog, Object jsonResult) {
        handleLog(joinPoint, controllerLog, null, jsonResult);
    }

    /**
     * 拦截异常操作
     *
     * @param joinPoint 切点
     * @param e         异常
     */
    @AfterThrowing(value = "@annotation(controllerLog)", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Log controllerLog, Exception e) {
        handleLog(joinPoint, controllerLog, e, null);
    }
    // FIXME: 2023/3/6 用户信息查询占用主线程

    protected void handleLog(final JoinPoint joinPoint, Log controllerLog, final Exception e, Object jsonResult) {
        try {
            //获取请求
            RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = ((ServletRequestAttributes) attributes).getRequest();
            // 获取当前的用户
            Long userId = UserHolderContext.getUserId();

            // *========数据库日志=========*//
            OperateLog operateLog = new OperateLog();
            operateLog.setStatus(OperateLogStateEnums.SUCCESS);
            // 请求的地址
            String ip = ServletUtil.getClientIP(request);
            if ("0:0:0:0:0:0:0:1".equals(ip)){
                ip="127.0.0.1";
            }
            operateLog.setOperateIp(ip);
            operateLog.setOperateUrl(StrUtil.sub(request.getRequestURI(), 0, 255));
            if (userId != null) {
                User user = userService.lambdaQuery().eq(User::getId, userId).one();
                operateLog.setOperatorName(user.getName());
            }
            //存在异常
            if (e != null) {
                operateLog.setStatus(OperateLogStateEnums.FAIL);
                operateLog.setErrorMsg(StrUtil.sub(e.getMessage(), 0, 2000));
            }
            // 设置方法名称
            String className = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            operateLog.setMethod(className + "." + methodName + "()");
            // 设置请求方式
            operateLog.setRequestMethod(request.getMethod());
            // 处理设置注解上的参数
            getControllerMethodDescription(joinPoint, controllerLog, operateLog, jsonResult);
            // 保存数据库
            AsyncManager.me().execute(AsyncFactory.recordOperate(operateLog));
        } catch (Exception exp) {
            // 记录本地异常日志
            log.error("异常信息:{}", exp.getMessage());
            exp.printStackTrace();
        }
    }

    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     *
     * @param log        日志
     * @param operateLog 操作日志
     * @throws Exception
     */
    public void getControllerMethodDescription(JoinPoint joinPoint, Log log, OperateLog operateLog, Object jsonResult) throws Exception {
        // 设置action动作
        operateLog.setBusinessType(log.businessTypeEnums());
        // 设置标题
        operateLog.setTitle(log.title());
        // 获取参数的信息，传入到数据库中。
        setRequestValue(joinPoint, operateLog);
        // 是否需要保存response，参数和值
        operateLog.setJsonResult(StrUtil.sub(JSON.toJSONString(jsonResult), 0, 2000));
    }

    /**
     * 获取请求的参数，放到log中
     *
     * @param operateLog 操作日志
     * @throws Exception 异常
     */
    private void setRequestValue(JoinPoint joinPoint, OperateLog operateLog) throws Exception {
        Object[] args = joinPoint.getArgs();
        String[] parameterNames = ((CodeSignature) joinPoint.getSignature()).getParameterNames();
        if (!Objects.isNull(args)) {
            String params = argsArrayToString(args,parameterNames);
            operateLog.setOperateParam(StrUtil.sub(params, 0, 2000));
        }
    }

    /**
     * 忽略敏感属性
     */
    public PropertyPreFilters.MySimplePropertyPreFilter excludePropertyPreFilter() {
        return new PropertyPreFilters().addFilter().addExcludes(EXCLUDE_PROPERTIES);
    }

    /**
     * 参数拼装
     */
    private String argsArrayToString(Object[] paramsArray,String[] parameterNames) {
        Map<String,Object> map=new HashMap<>(16);
        if (paramsArray != null) {
            for (int i = 0; i < paramsArray.length; i++)  {
                if (paramsArray[i] instanceof HttpServletRequest||paramsArray[i] instanceof HttpServletResponse){
                    continue;
                }
                if (!Objects.isNull(paramsArray[i])) {
                       map.put(parameterNames[i],paramsArray[i]);
                }
            }
        }
        return JSON.toJSONString(map,excludePropertyPreFilter());
    }

}
