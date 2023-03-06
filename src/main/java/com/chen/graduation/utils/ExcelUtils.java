package com.chen.graduation.utils;

import cn.hutool.core.io.IORuntimeException;
import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.BigExcelWriter;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.chen.graduation.beans.VO.OperateLogVO;
import org.apache.poi.xssf.streaming.SXSSFSheet;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

/**
 * excel工具
 *
 * @author CHEN
 * @date 2023/03/06
 */
public class ExcelUtils {
    // FIXME: 2023/3/6 导出乱码
    public static void exportOperateLog(HttpServletResponse response, List<OperateLogVO> operateLogVOList) throws IOException {
        ExcelWriter writer = null;
        ServletOutputStream out = null;
        try {
            writer = ExcelUtil.getWriter(true);
            writer.write(operateLogVOList, true);
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename=test.xlsx");
            out = response.getOutputStream();

            writer.flush(out, true);
        } finally {
            assert writer != null;
            writer.close();
            IoUtil.close(out);
        }
    }
}
