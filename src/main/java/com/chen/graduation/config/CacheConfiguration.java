package com.chen.graduation.config;

import com.alibaba.fastjson.support.spring.FastJsonRedisSerializer;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.jsontype.impl.LaissezFaireSubTypeValidator;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;

import java.time.Duration;

/**
 * 缓存配置
 *
 * @author CHEN
 * @date 2023/01/28
 */
@Configuration
@EnableCaching
public class CacheConfiguration {


    /**
     * 主缓存管理器
     * 默认
     * 缓存一小时
     *
     * @param redisConnectionFactory redis连接工厂
     * @return {@link RedisCacheManager}
     */
    @Bean
    @Primary
    public RedisCacheManager redisCacheManagerForHour(RedisConnectionFactory redisConnectionFactory) {
        //缓存时间1小时
        RedisCacheConfiguration instanceConfig = jacksonInstanceConfig(3600L);

        //构建缓存对象
        return RedisCacheManager.builder(redisConnectionFactory)
                .cacheDefaults(instanceConfig)
                .transactionAware()
                .build();
    }

    /**
     * 缓存管理器一天
     *
     * @param redisConnectionFactory redis连接工厂
     * @return {@link RedisCacheManager}
     */
    @Bean
    public RedisCacheManager redisCacheManagerForDay(RedisConnectionFactory redisConnectionFactory) {
        //缓存时间1小时
        RedisCacheConfiguration instanceConfig = jacksonInstanceConfig(24 * 3600L);

        //构建缓存对象
        return RedisCacheManager.builder(redisConnectionFactory)
                .cacheDefaults(instanceConfig)
                .transactionAware()
                .build();
    }


    /**
     * 实例配置
     * 实例化具体的缓存配置!
     * 设置缓存方式JSON
     * 设置缓存时间 单位秒
     *
     * @param ttl ttl
     * @return {@link org.springframework.data.redis.cache.RedisCacheConfiguration}
     */
    private RedisCacheConfiguration fastJsonInstanceConfig(Long ttl) {

        ////设用fastjson 序列化
        FastJsonRedisSerializer<Object> objectFastJsonRedisSerializer = new FastJsonRedisSerializer<>(Object.class);
        return RedisCacheConfiguration.defaultCacheConfig()
                //设置缓存时间
                .entryTtl(Duration.ofSeconds(ttl))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(objectFastJsonRedisSerializer));
    }

    private RedisCacheConfiguration jacksonInstanceConfig(Long ttl) {
        //设置jackson序列化工具
        Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer
                = new Jackson2JsonRedisSerializer<Object>(Object.class);
        //常见jackson的对象映射器,并设置一些基本属性
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.configure(MapperFeature.USE_ANNOTATIONS, false);
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        objectMapper.activateDefaultTyping(LaissezFaireSubTypeValidator.instance,
                ObjectMapper.DefaultTyping.NON_FINAL, JsonTypeInfo.As.PROPERTY);

        jackson2JsonRedisSerializer.setObjectMapper(objectMapper);

        return RedisCacheConfiguration.defaultCacheConfig()
                //设置缓存时间
                .entryTtl(Duration.ofSeconds(ttl))
                .disableCachingNullValues()
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(jackson2JsonRedisSerializer));
    }

}
