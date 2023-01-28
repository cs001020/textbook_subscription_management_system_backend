package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.model.DO.Major;
import com.chen.graduation.service.MajorService;
import com.chen.graduation.mapper.MajorMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_major(专业)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class MajorServiceImpl extends ServiceImpl<MajorMapper, Major>
    implements MajorService{

}




