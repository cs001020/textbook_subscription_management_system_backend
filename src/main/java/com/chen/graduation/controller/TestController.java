package com.chen.graduation.controller;

import cn.hutool.extra.servlet.ServletUtil;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.PhoneNumberDTO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.service.TextbookService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

/**
 * 测试控制器
 *
 * @author CHEN
 * @date 2023/01/27
 */
@Slf4j
@Api(tags = "测试", hidden = true)
@ApiSupport(author = "1006596474@qq.com")
@RestController
@RequestMapping("/test")
public class TestController {
    @Resource
    private TextbookService textbookService;
    @Resource
    private StringRedisTemplate stringRedisTemplate;
    @Resource
    private PermissionService permissionService;

    @GetMapping("/hello1")
    @ApiOperation(value = "hello测试接口1")
    public String hello1() {
        return "hello";
    }

    @GetMapping("/hello2")
    @ApiOperation("hello测试接口2")
    @ApiImplicitParams(
            @ApiImplicitParam(name = "name", value = "姓名", required = false, defaultValue = "张三")
    )
    @Log(title = "测试", businessTypeEnums = BusinessTypeEnums.OTHER)
    public String hello2(@RequestParam(value = "name", required = false, defaultValue = "张三") String name, HttpServletRequest request) {
        String clientIP = ServletUtil.getClientIP(request);
        return "hello," + name + "..." + clientIP;
    }

    @GetMapping("/hello3")
    @ApiOperation("hello测试接口3")
    @ApiImplicitParams(
            @ApiImplicitParam(name = "name", value = "姓名", allowMultiple = true, required = true)
    )
    public String hello3(@RequestParam(value = "name", required = true) String[] name) {
        StringBuilder res = new StringBuilder("hell,");
        for (String s : name) {
            res.append(s).append("||");
        }
        return res.toString();
    }

    @PostMapping("/logTest/{id}")
    @ApiOperation("log测试接口")
    @Log(title = "测试", businessTypeEnums = BusinessTypeEnums.OTHER)
    public HashMap<String, Object> logTest(@RequestParam(value = "name", required = false) String name, @RequestParam(value = "e", required = true) boolean e, @RequestBody PhoneNumberDTO phoneNumberDTO, @PathVariable String id) {
        if (e){
            throw new ServiceException("测试错误");
        }
        HashMap<String, Object> map = new HashMap<>();
        map.put("name",name);
        map.put("id",id);
        map.put("e",e);
        map.put("phone",phoneNumberDTO.getPhoneNumber());
        return map;
    }

}
