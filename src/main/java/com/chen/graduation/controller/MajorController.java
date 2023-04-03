package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.MajorDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.MajorVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.MajorService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * teaching组控制器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Slf4j
@Api(tags = "专业")
@ApiSupport(author = "1006596474@qq.com",order = 7)
@RestController
@RequestMapping("/major")
public class MajorController {
    @Resource
    private MajorService majorService;

    @Auth({"academic:major:list","academic:grade:add","academic:grade:edit"})
    @GetMapping("/list")
    @ApiOperation(value = "获取专业列表")
    public AjaxResult<List<MajorVO>> list() {
        return majorService.getList();
    }

    @Auth({"academic:major:remove"})
    @Log(title = "专业管理",businessTypeEnums = BusinessTypeEnums.DELETE)
    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "根据id删除专业")
    public AjaxResult<Object> deleteById(@PathVariable Long id) {
        return majorService.deleteById(id);
    }

    @Auth({"academic:major:add"})
    @Log(title = "专业管理",businessTypeEnums = BusinessTypeEnums.INSERT)
    @PostMapping("/add")
    @ApiOperation(value = "添加专业")
    public AjaxResult<Object> add(@Validated @RequestBody MajorDTO majorDTO) {
        return majorService.add(majorDTO);
    }

    @Auth({"academic:major:edit"})
    @Log(title = "专业管理",businessTypeEnums = BusinessTypeEnums.UPDATE)
    @PutMapping("/update/{id}")
    @ApiOperation(value = "根据id更新专业")
    public AjaxResult<Object> updateById(@RequestBody MajorDTO majorDTO, @PathVariable Long id) {
        return majorService.updateById(majorDTO,id);
    }
}
