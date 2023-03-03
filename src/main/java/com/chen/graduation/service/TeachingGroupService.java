package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.TeachingGroupDTO;
import com.chen.graduation.beans.PO.TeachingGroup;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TeachingGroupVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_teaching_group】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface TeachingGroupService extends IService<TeachingGroup> {

    /**
     * 得到列表
     *
     * @return {@link AjaxResult}<{@link List}<{@link TeachingGroupVO}>>
     */
    AjaxResult<List<TeachingGroupVO>> getList();

    /**
     * 删除通过id
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> deleteById(Long id);

    /**
     * 添加教学组
     *
     * @param teachingGroupDTO 教学组dto
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> add(TeachingGroupDTO teachingGroupDTO);

    /**
     * 根据id跟新教学组
     *
     * @param teachingGroupDTO 教学组dto
     * @param id               id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> updateById(TeachingGroupDTO teachingGroupDTO, Long id);
}
