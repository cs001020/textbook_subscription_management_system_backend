package com.chen.graduation.config;


import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import com.chen.graduation.interceptor.AuthorizeInterceptor;
import com.chen.graduation.interceptor.LoginAuthenticationInterceptor;
import com.chen.graduation.interceptor.RefreshTokenInterceptor;
import com.chen.graduation.service.PermissionService;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import springfox.bean.validators.configuration.BeanValidatorPluginsConfiguration;

import javax.annotation.Resource;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;


/**
 * web mvc配置
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Setter
@Configuration
@ConfigurationProperties(prefix = "jwt")
public class WebMvcConfiguration extends WebMvcConfigurationSupport {
    @Resource
    private StringRedisTemplate stringRedisTemplate;
    @Resource
    private PermissionService permissionService;
    private List<String> requestWhiteList;
    private String hand;
    private String key;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //鉴权拦截器
        registry.addInterceptor(new AuthorizeInterceptor(permissionService))
                .excludePathPatterns(requestWhiteList)
                .order(2);
        //登陆拦截器
        registry.addInterceptor(new LoginAuthenticationInterceptor())
                .excludePathPatterns(requestWhiteList)
                .order(1);
        //Token续命拦截器
        registry.addInterceptor(new RefreshTokenInterceptor(stringRedisTemplate, hand, key))
                .addPathPatterns("/**")
                .order(0);
    }

    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        FastJsonHttpMessageConverter converter = new FastJsonHttpMessageConverter();
        FastJsonConfig config = new FastJsonConfig();
        config.setSerializerFeatures(
               /* // 保留map空的字段
                SerializerFeature.WriteMapNullValue,
                // 将String类型的null转成""
                SerializerFeature.WriteNullStringAsEmpty,
                // 将Number类型的null转成0
                SerializerFeature.WriteNullNumberAsZero,
                // 将List类型的null转成[]
                SerializerFeature.WriteNullListAsEmpty,
                // 将Boolean类型的null转成false
                SerializerFeature.WriteNullBooleanAsFalse,*/
                // 避免循环引用
                SerializerFeature.DisableCircularReferenceDetect);

        converter.setFastJsonConfig(config);
        converter.setDefaultCharset(StandardCharsets.UTF_8);
        List<MediaType> mediaTypeList = new ArrayList<>();
        // 解决中文乱码问题，相当于在Controller上的@RequestMapping中加了个属性produces = "application/json"
        mediaTypeList.add(MediaType.APPLICATION_JSON);
        converter.setSupportedMediaTypes(mediaTypeList);
        converters.add(converter);
    }


    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("swagger-ui.html", "index.html").addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("doc.html").addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/META-INF/resources/static/");
    }
}
