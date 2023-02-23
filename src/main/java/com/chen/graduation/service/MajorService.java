package com.chen.graduation.service;

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
}
