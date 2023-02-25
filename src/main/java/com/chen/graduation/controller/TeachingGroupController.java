package com.chen.graduation.controller;

import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.service.TeachingGroupService;
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
 * teaching组控制器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Slf4j
@Api(tags = "教学组")
@ApiSupport(author = "1006596474@qq.com",order = 7)
@RestController
@RequestMapping("/teachingGroup")
public class TeachingGroupController {
    @Resource
    private TeachingGroupService teachingGroupService;

    @GetMapping("/list")
    @ApiOperation(value = "获取教学组列表")
    public AjaxResult<List<TeachingGroupVO>> list() {
        return teachingGroupService.getList();
    }
}
