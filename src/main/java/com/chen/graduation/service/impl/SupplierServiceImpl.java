package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.SupplierDTO;
import com.chen.graduation.beans.PO.Supplier;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SupplierVO;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.converter.SupplierConverter;
import com.chen.graduation.service.SupplierService;
import com.chen.graduation.mapper.SupplierMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_supplier(供应商)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class SupplierServiceImpl extends ServiceImpl<SupplierMapper, Supplier>
    implements SupplierService{
    @Resource
    private SupplierConverter supplierConverter;

    @Override
    @Cacheable(value = RedisConstants.SUPPLIER_CACHE_KEY,key = "'list'")
    public AjaxResult<List<SupplierVO>> getList() {
        //查询
        List<Supplier> supplierList = this.lambdaQuery().orderByAsc(Supplier::getId).list();
        //转换vo
        List<SupplierVO> supplierVOList = supplierConverter.pos2vos(supplierList);
        //打印日志
        log.info("SupplierServiceImpl.getList业务结束，结果:{}",supplierVOList);
        //返回结果
        return AjaxResult.success(supplierVOList);
    }

    @Override
    @CacheEvict( value = RedisConstants.SUPPLIER_CACHE_KEY,key = "'list'")
    public AjaxResult<Object> deleteById(Long id) {
        //删除
        boolean success = this.removeById(id);
        //打印日志
        log.info("SupplierServiceImpl.deleteById业务结束，结果:{}",success);
        //返回结果
        return AjaxResult.success(success);
    }

    @Override
    @CacheEvict( value = RedisConstants.SUPPLIER_CACHE_KEY,key = "'list'")
    public AjaxResult<Object> addSupplier(SupplierDTO supplierDTO) {
        //转换
        Supplier supplier = supplierConverter.dto2po(supplierDTO);
        //插入
        boolean save = this.save(supplier);
        //打印日志
        log.info("SupplierServiceImpl.addSupplier业务结束，结果:{}",save);
        //返回结果
        return AjaxResult.success(save);
    }

    @Override
    @CacheEvict( value = RedisConstants.SUPPLIER_CACHE_KEY,key = "'list'")
    public AjaxResult<Object> updateSupplierById(SupplierDTO supplierDTO, Long id) {
        //转换
        Supplier supplier = supplierConverter.dto2po(supplierDTO);
        supplier.setId(id);
        //更新
        boolean update = this.updateById(supplier);
        //打印日志
        log.info("SupplierServiceImpl.updateSupplierById业务结束，结果:{}",update);
        //返回结果
        return AjaxResult.success(update);
    }
}




