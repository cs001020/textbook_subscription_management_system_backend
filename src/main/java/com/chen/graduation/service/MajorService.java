package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.MajorDTO;
import com.chen.graduation.beans.DTO.SecondaryCollegeDTO;
import com.chen.graduation.beans.PO.Major;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.MajorVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_major(专业)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface MajorService extends IService<Major> {

    /**
     * 通过二级学院id获取列表
     *
     * @return {@link AjaxResult}<{@link List}<{@link MajorVO}>>
     */
    AjaxResult<List<MajorVO>> listBySecondaryId(Long id);

    /**
     * 获取专业列表
     *
     * @return {@link AjaxResult}<{@link List}<{@link MajorVO}>>
     */
    AjaxResult<List<MajorVO>> getList();

    /**
     * 删除通过id
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deleteById(Long id);


    /**
     * 添加
     *
     * @param majorDTO 主要dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> add(MajorDTO majorDTO);

    /**
     * 更新通过id
     *
     * @param majorDTO 主要dto
     * @param id       id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateById(MajorDTO majorDTO, Long id);
}
