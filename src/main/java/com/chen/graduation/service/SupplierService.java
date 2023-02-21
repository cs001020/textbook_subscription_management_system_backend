package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.SupplierDTO;
import com.chen.graduation.beans.PO.Supplier;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SupplierVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_supplier(供应商)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface SupplierService extends IService<Supplier> {

    /**
     * 获取供应商列表
     *
     * @return {@link AjaxResult}<{@link SupplierVO}>
     */
    AjaxResult<List<SupplierVO>> getList();

    /**
     * 根据id删除供应商
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deleteById(Long id);

    /**
     * 添加供应商
     *
     * @param supplierDTO 供应商dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> addSupplier(SupplierDTO supplierDTO);

    /**
     * 根据id更新供应商
     *
     * @param supplierDTO 供应商dto
     * @param id          id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateSupplierById(SupplierDTO supplierDTO, Long id);
}
