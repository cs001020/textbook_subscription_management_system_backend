package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.TeachingGroup;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.converter.TeachingGroupConverter;
import com.chen.graduation.service.TeachingGroupService;
import com.chen.graduation.mapper.TeachingGroupMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_teaching_group】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class TeachingGroupServiceImpl extends ServiceImpl<TeachingGroupMapper, TeachingGroup>
    implements TeachingGroupService{
    @Resource
    private TeachingGroupConverter teachingGroupConverter;

    // TODO: 2023/2/23 缓存
    @Override
    public AjaxResult<List<TeachingGroupVO>> getList() {
        List<TeachingGroup> list = this.list();
        List<TeachingGroupVO> teachingGroupVOList = teachingGroupConverter.po2vos(list);
        log.info("TeachingGroupServiceImpl.getList业务结束，结果:{}",teachingGroupVOList);
        return AjaxResult.success(teachingGroupVOList);
    }
}




