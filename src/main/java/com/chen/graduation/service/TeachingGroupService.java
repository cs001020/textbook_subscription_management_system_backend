package com.chen.graduation.service;

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
}
