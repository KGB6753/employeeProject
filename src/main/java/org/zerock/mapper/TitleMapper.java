package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.vo.TitleVO;

public interface TitleMapper {

	public int insert(TitleVO title);

	public List<TitleVO> getTitles(Long emp_no);

	public int insertChange(TitleVO title);

	public int update(TitleVO title);

}
