package com.chen.graduation.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.service.TextbookService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.validation.annotation.Validated;
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
@Api(tags = "测试")
@ApiSupport(author = "1006596474@qq.com")
@RestController
@RequestMapping("/test")
public class TestController {
    @Resource
    private TextbookService textbookService;
    @Resource
    private StringRedisTemplate stringRedisTemplate;

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

    @PostMapping("/page")
    @ApiOperation("教材数据分页查询")
    @Cacheable(value = RedisConstants.TEXTBOOK_PAGE_CACHE_KET,key = "#pageParamDTO.page+'-'+#pageParamDTO.size")
    public AjaxResult<List<Textbook>> get(@RequestBody @Validated PageParamDTO pageParamDTO){
        //String json = stringRedisTemplate.opsForValue().get("test."+pageParamDTO.getPage()+pageParamDTO.getSize());
        //if (StrUtil.isNotEmpty(json)){
        //    return JSON.parseObject(json,AjaxResult.class);
        //}
        Page<Textbook> page = textbookService.page(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()));
        AjaxResult<List<Textbook>> success = AjaxResult.success(page.getRecords());
        success.setTotal(page.getTotal());
        log.info("TestController.get业务结束，结果:{}",success);
        //stringRedisTemplate.opsForValue().set("test.1", JSON.toJSONString(success));
        return success;
    }
}
