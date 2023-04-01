package com.chen.graduation.service.impl;

import cn.hutool.core.io.FileTypeUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.File;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.mapper.FileMapper;
import com.chen.graduation.service.FileService;
import com.chen.graduation.utils.FileUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Objects;

/**
 * 文件服务impl
 *
 * @author CHEN
 * @date 2023/03/26
 */
@Service
@Slf4j
public class FileServiceImpl extends ServiceImpl<FileMapper, File> implements FileService {
    @Resource
    private FileUtils fileUtils;

    @Override
    public AjaxResult<Object> uploadImg(MultipartFile file) {
        //空值判断
        if (Objects.isNull(file)) {
            log.warn("ProductController.adminUpload业务结束，结果:{}", "上传失败,空文件");
            return AjaxResult.error("文件上传失败");
        }
        InputStream inputStream=null;
        try {
            //构建文件名
            String fileName = IdUtil.simpleUUID() + "-" + file.getOriginalFilename();
            //获取输入流
            inputStream = file.getInputStream();
            //获取文件类型
            String fileType = FileTypeUtil.getType(inputStream);
            //文件类型判断
            if (!SystemConstants.IMG_TYPE.contains(fileType)) {
                //非图片禁止上传
                throw new ServiceException("禁止上传非图片类型文件");
            }
            //获取文件hash值
            String fileHash = SecureUtil.md5(inputStream);
            //查询数据库
            File oldFile = lambdaQuery().eq(File::getFileHash, fileHash).one();
            //存在同hash文件 直接返回
            if (!Objects.isNull(oldFile)) {
                return AjaxResult.success(oldFile.getFileUrl());
            }
            //新文件 上传至oss
            fileUtils.fileUpload(fileName, file.getInputStream());
            //数据库新增记录
            File newFile = new File();
            newFile.setFileUrl("/upload/" + fileName);
            newFile.setFileHash(fileHash);
            save(newFile);
            //响应
            log.info("FileServiceImpl.uploadImg业务结束，结果:{},{}", "上传成功", "/upload/" + fileName);
            return AjaxResult.success("/upload/" + fileName);
        } catch (ServiceException e) {
            //发生异常
            log.error("FileServiceImpl.uploadImg业务结束，结果:{}", "上传失败", e);
            throw new ServiceException(e.getMessage());
        } catch (Exception e) {
            //发生异常
            log.error("FileServiceImpl.uploadImg业务结束，结果:{}", "上传失败", e);
            throw new ServiceException("文件上传失败");
        }finally {
            IoUtil.close(inputStream);
        }
    }
}
