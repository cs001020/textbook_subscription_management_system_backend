package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.service.RoleService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 角色控制器
 *
 * @author CHEN
 * @date 2023/03/16
 */
@Slf4j
@Api(tags = "角色")
@ApiSupport(author = "1006596474@qq.com",order = 7)
@RestController
@RequestMapping("/role")
public class RoleController {

    @Resource
    private RoleService roleService;

    @ApiOperation("角色列表")
    @GetMapping("list")
    public AjaxResult<List<Role>> getList(@Validated PageParamDTO pageParamDTO){
       return    roleService.pageQuery(pageParamDTO);
    }

}
