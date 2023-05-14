package org.zerock.service;

import java.util.List;

import org.zerock.domain.vo.TitleVO;

public interface TitleService {
	public List<TitleVO> getTitles(Long emp_no);
}
