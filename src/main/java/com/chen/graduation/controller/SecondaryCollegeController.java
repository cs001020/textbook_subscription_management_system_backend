package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.SecondaryCollegeDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.SecondaryCollegeService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 二级学院控制器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Slf4j
@Api(tags = "二级学院")
@ApiSupport(author = "1006596474@qq.com",order = 7)
@RestController
@RequestMapping("/secondaryCollege")
public class SecondaryCollegeController {

    @Resource
    private SecondaryCollegeService secondaryCollegeService;

    @Auth({"academic:secondaryCollege:list","academic:major:add","academic:major:edit"})
    @GetMapping("/list")
    @ApiOperation(value = "获取二级学院列表")
    public AjaxResult<List<SecondaryCollegeVO>> list() {
        return secondaryCollegeService.getList();
    }

    @Auth({"academic:secondaryCollege:remove"})
    @Log(title = "二级学院管理",businessTypeEnums = BusinessTypeEnums.DELETE)
    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "根据id删除二级学院")
    public AjaxResult<Object> deleteById(@PathVariable Long id) {
        return secondaryCollegeService.deleteById(id);
    }

    @Auth({"academic:secondaryCollege:add"})
    @Log(title = "二级学院管理",businessTypeEnums = BusinessTypeEnums.INSERT)
    @PostMapping("/add")
    @ApiOperation(value = "添加二级学院")
    public AjaxResult<Object> add(@Validated @RequestBody SecondaryCollegeDTO secondaryCollegeDTO) {
        return secondaryCollegeService.add(secondaryCollegeDTO);
    }

    @Auth({"academic:secondaryCollege:edit"})
    @Log(title = "二级学院管理",businessTypeEnums = BusinessTypeEnums.UPDATE)
    @PutMapping("/update/{id}")
    @ApiOperation(value = "根据id跟新二级学院")
    public AjaxResult<Object> updateById(@Validated @RequestBody SecondaryCollegeDTO secondaryCollegeDTO, @PathVariable Long id) {
        return secondaryCollegeService.updateById(secondaryCollegeDTO,id);
    }
}
