package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Grade;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.GradeVO;
import com.chen.graduation.converter.GradeConverter;
import com.chen.graduation.service.GradeService;
import com.chen.graduation.mapper.GradeMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_grade(班级)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class GradeServiceImpl extends ServiceImpl<GradeMapper, Grade>
    implements GradeService{

    @Resource
    private GradeConverter gradeConverter;

    @Override
    public AjaxResult<List<GradeVO>> listByMajorId(Long id) {
        List<Grade> list = lambdaQuery().eq(Grade::getMajorId, id).list();
        List<GradeVO> gradeVOList = gradeConverter.po2vos(list);
        log.info("GradeServiceImpl.listByMajorId业务结束，结果:{}",gradeVOList);
        return AjaxResult.success(gradeVOList);
    }
}




