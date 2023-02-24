package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Major;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.MajorVO;
import com.chen.graduation.converter.MajorConverter;
import com.chen.graduation.service.MajorService;
import com.chen.graduation.mapper.MajorMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_major(专业)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class MajorServiceImpl extends ServiceImpl<MajorMapper, Major>
    implements MajorService{

    @Resource
    private MajorConverter majorConverter;

    // TODO: 2023/2/23 缓存 注释
    @Override
    public AjaxResult<List<MajorVO>> listBySecondaryId(Long id) {
        List<Major> list = lambdaQuery().eq(Major::getSecondaryCollegeId, id).list();
        List<MajorVO> majorVOList = majorConverter.po2vos(list);
        log.info("MajorServiceImpl.listBySecondaryId业务结束，结果:{}",majorVOList);
        return AjaxResult.success(majorVOList);
    }
}




