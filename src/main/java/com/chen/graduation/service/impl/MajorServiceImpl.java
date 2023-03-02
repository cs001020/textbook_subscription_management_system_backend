package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.MajorDTO;
import com.chen.graduation.beans.PO.Grade;
import com.chen.graduation.beans.PO.Major;
import com.chen.graduation.beans.PO.SecondaryCollege;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.MajorVO;
import com.chen.graduation.converter.MajorConverter;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.GradeService;
import com.chen.graduation.service.MajorService;
import com.chen.graduation.mapper.MajorMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

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
    @Resource
    private GradeService gradeService;

    // TODO: 2023/2/23 缓存 注释
    @Override
    public AjaxResult<List<MajorVO>> listBySecondaryId(Long id) {
        List<Major> list = lambdaQuery().eq(Major::getSecondaryCollegeId, id).list();
        List<MajorVO> majorVOList = majorConverter.po2vos(list);
        log.info("MajorServiceImpl.listBySecondaryId业务结束，结果:{}",majorVOList);
        return AjaxResult.success(majorVOList);
    }

    @Override
    public AjaxResult<List<MajorVO>> getList() {
        //查询
        List<MajorVO> list = baseMapper.list();
        //日志
        log.info("MajorServiceImpl.getList业务结束，结果:{}",list);
        //响应
        return AjaxResult.success(list);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> deleteById(Long id) {
        if (checkForGradePresence(id)){
            throw new ServiceException("该专业下存在班级，无法删除");
        }
        //校验通过
        //删除该班级
        boolean remove = this.removeById(id);
        //日志
        log.info("MajorServiceImpl.deleteById业务结束，结果:{}",remove);
        //响应
        if (!remove){
            throw new ServiceException("删除发生未知异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> add(MajorDTO majorDTO) {
        //参数校验
        if (Objects.isNull(majorDTO.getSecondaryCollegeId())|| StrUtil.isBlank(majorDTO.getName())){
            throw new ServiceException("参数异常");
        }
        //转换
        Major major = majorConverter.dto2po(majorDTO);
        //插入
        boolean save = this.save(major);
        //打印日志
        log.info("MajorServiceImpl.add业务结束，结果:{}",save);
        //响应
        if (!save){
            throw new ServiceException("新增异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> updateById(MajorDTO majorDTO, Long id) {
        //参数校验
        if (Objects.isNull(majorDTO.getSecondaryCollegeId())|| StrUtil.isBlank(majorDTO.getName())){
            throw new ServiceException("参数异常");
        }
        //封装
        Major major = majorConverter.dto2po(majorDTO);
        major.setId(id);
        //更新
        boolean update = this.updateById(major);
        //日志
        log.info("MajorServiceImpl.updateById业务结束，结果:{}",update);
        //响应
        if (!update){
            throw new ServiceException("更新发生未知异常，请稍后再试！");
        }
        return AjaxResult.success();
    }

    /**
     * 检查班级存在
     *
     * @param id id 存在返回true 不存在返回false
     * @return boolean
     */
    private boolean checkForGradePresence(Long id) {
        Page<Grade> page = gradeService.lambdaQuery().eq(Grade::getMajorId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }
}




