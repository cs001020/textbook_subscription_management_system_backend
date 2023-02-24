package com.chen.graduation.service;

import com.chen.graduation.beans.PO.SecondaryCollege;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_secondary_college(教学组)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface SecondaryCollegeService extends IService<SecondaryCollege> {

    /**
     * 得到列表
     *
     * @return {@link AjaxResult}<{@link List}<{@link SecondaryCollegeVO}>>
     */
    AjaxResult<List<SecondaryCollegeVO>> getList();
}
