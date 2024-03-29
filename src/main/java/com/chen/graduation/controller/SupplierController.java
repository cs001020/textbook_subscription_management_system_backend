package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.SupplierDTO;
import com.chen.graduation.beans.DTO.group.SupplierDtoAddGroup;
import com.chen.graduation.beans.DTO.group.SupplierDtoUpdateGroup;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SupplierVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.SupplierService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 供应商控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "供应商")
@ApiSupport(author = "1006596474@qq.com",order = 6)
@RestController
@RequestMapping("/supplier")
public class SupplierController {

    @Resource
    private SupplierService supplierService;

    @Auth({"academic:supplier:add"})
    @ApiOperation("添加供应商")
    @PostMapping("/add")
    @Log(title = "供应商模块",businessTypeEnums = BusinessTypeEnums.INSERT)
    public AjaxResult<Object> addSupplier(@Validated(value = SupplierDtoAddGroup.class) @RequestBody SupplierDTO supplierDTO) {
        return supplierService.addSupplier(supplierDTO);
    }

    @Auth({"academic:supplier:remove"})
    @ApiOperation("根据id删除供应商")
    @DeleteMapping("/delete/{id}")
    @Log(title = "供应商模块",businessTypeEnums = BusinessTypeEnums.DELETE)
    public AjaxResult<Object> deleteById(@PathVariable("id") Long id) {
        return supplierService.deleteById(id);
    }

    @Auth({"academic:supplier:edit"})
    @ApiOperation("根据id更新供应商")
    @PutMapping("/update/{id}")
    @Log(title = "供应商模块",businessTypeEnums = BusinessTypeEnums.UPDATE)
    public AjaxResult<Object> updateSupplier(@Validated(value = SupplierDtoUpdateGroup.class) @RequestBody SupplierDTO supplierDTO, @PathVariable("id") Long id) {
        return supplierService.updateSupplierById(supplierDTO, id);
    }

    @Auth({"academic:supplier:list"})
    @ApiOperation("获取供应商列表")
    @GetMapping("/list")
    public AjaxResult<List<SupplierVO>> getList() {
        return supplierService.getList();
    }
}
