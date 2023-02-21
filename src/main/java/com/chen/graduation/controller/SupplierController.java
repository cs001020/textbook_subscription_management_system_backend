package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.SupplierDTO;
import com.chen.graduation.beans.DTO.group.SupplierDtoAddGroup;
import com.chen.graduation.beans.DTO.group.SupplierDtoUpdateGroup;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SupplierVO;
import com.chen.graduation.service.SupplierService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.cache.annotation.Cacheable;
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
@RestController
@RequestMapping("/supplier")
public class SupplierController {

    @Resource
    private SupplierService supplierService;

    @ApiOperation("添加供应商")
    @PostMapping("/add")
    public AjaxResult<Object> addSupplier(@Validated(value = SupplierDtoAddGroup.class) @RequestBody SupplierDTO supplierDTO) {
        return supplierService.addSupplier(supplierDTO);
    }

    @ApiOperation("根据id删除供应商")
    @DeleteMapping("/delete/{id}")
    public AjaxResult<Object> deleteById(@PathVariable("id") Long id) {
        return supplierService.deleteById(id);
    }

    @ApiOperation("根据id更新供应商")
    @PutMapping("/update/{id}")
    public AjaxResult<Object> updateSupplier(@Validated(value = SupplierDtoUpdateGroup.class) @RequestBody SupplierDTO supplierDTO, @PathVariable("id") Long id) {
        return supplierService.updateSupplierById(supplierDTO, id);
    }

    @ApiOperation("获取供应商列表")
    @GetMapping("/list")
    public AjaxResult<List<SupplierVO>> getList() {
        return supplierService.getList();
    }
}
