package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.SecondaryCollege;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;
import com.chen.graduation.converter.SecondaryCollegeConverter;
import com.chen.graduation.service.SecondaryCollegeService;
import com.chen.graduation.mapper.SecondaryCollegeMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_secondary_college(教学组)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class SecondaryCollegeServiceImpl extends ServiceImpl<SecondaryCollegeMapper, SecondaryCollege>
    implements SecondaryCollegeService{

    @Resource
    private SecondaryCollegeConverter secondaryCollegeConverter;

    // TODO: 2023/2/23 缓存
    @Override
    @Cacheable(value = "second.list")
    public AjaxResult<List<SecondaryCollegeVO>> getList() {
        List<SecondaryCollege> list = this.list();
        List<SecondaryCollegeVO> secondaryCollegeVOList = secondaryCollegeConverter.po2vos(list);
        log.info("SecondaryCollegeServiceImpl.getList业务结束，结果:{}",secondaryCollegeVOList);
        return AjaxResult.success(secondaryCollegeVOList);
    }
}




