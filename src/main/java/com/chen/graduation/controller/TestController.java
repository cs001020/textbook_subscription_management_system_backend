package com.chen.graduation.controller;

import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.service.TextbookService;
import com.chen.graduation.utils.PermissionUtils;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 测试控制器
 *
 * @author CHEN
 * @date 2023/01/27
 */
@Slf4j
@Api(tags = "测试",hidden = true)
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
    public String hello2(@RequestParam(value = "name", required = false, defaultValue = "张三") String name) {
        return "hello," + name;
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

}
