package com.chen.graduation.controller;

import com.chen.graduation.beans.PO.SecondaryCollege;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;
import com.chen.graduation.service.SecondaryCollegeService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
@ApiSupport(author = "1006596474@qq.com")
@RestController
@RequestMapping("/secondaryCollege")
public class SecondaryCollegeController {

    @Resource
    private SecondaryCollegeService secondaryCollegeService;

    @GetMapping("/list")
    @ApiOperation(value = "获取二级学院列表")
    public AjaxResult<List<SecondaryCollegeVO>> list() {
        return secondaryCollegeService.getList();
    }
}
