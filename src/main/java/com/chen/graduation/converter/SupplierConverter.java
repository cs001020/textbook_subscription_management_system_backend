package com.chen.graduation.converter;

import com.chen.graduation.beans.DTO.SupplierDTO;
import com.chen.graduation.beans.PO.Supplier;
import com.chen.graduation.beans.VO.SupplierVO;
import org.mapstruct.Mapper;

import java.util.List;

/**
 * 教材转换器
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Mapper(componentModel = "spring")
public interface SupplierConverter {

    /**
     * po2vo
     *
     * @param supplier 供应商
     * @return {@link SupplierVO}
     */
    SupplierVO po2vo(Supplier supplier);


    /**
     * pos2vos
     *
     * @param supplierList 供应商列表
     * @return {@link List}<{@link SupplierVO}>
     */
    List<SupplierVO> pos2vos(List<Supplier> supplierList);

    /**
     * dto2po
     *
     * @param supplierDTO 供应商dto
     * @return {@link Supplier}
     */
    Supplier dto2po(SupplierDTO supplierDTO);
}
