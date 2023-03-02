package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.Major;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.chen.graduation.beans.VO.MajorVO;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_major(专业)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.Major
*/
public interface MajorMapper extends BaseMapper<Major> {

    /**
     * 列表
     *
     * @return {@link List}<{@link MajorVO}>
     */
    List<MajorVO> list();
}




