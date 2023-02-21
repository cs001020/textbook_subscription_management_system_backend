package com.chen.graduation.converter;

import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.TextbookVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * 教材转换器
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Mapper(componentModel = "spring")
public interface TextbookConverter {
    /**
     * po2vo
     *
     * @param textbook 教科书
     * @return {@link TextbookVO}
     */
    @Mapping(target = "state",expression = "java(textbook.getState().getStateName())")
    TextbookVO po2vo(Textbook textbook);

    /**
     * dto2po
     *
     * @param textbookDTO 教科书dto
     * @return {@link Textbook}
     */
    Textbook dto2po(TextbookDTO textbookDTO);

    /**
     * pos2vos
     *
     * @param textbookList 教科书列表
     * @return {@link List}<{@link Textbook}>
     */
    List<TextbookVO> pos2vos(List<Textbook> textbookList);

    /**
     * dto2vos
     *
     * @param textbookDTOList 教科书dtolist
     * @return {@link List}<{@link Textbook}>
     */
    List<Textbook> dto2vos(List<TextbookDTO> textbookDTOList);
}
