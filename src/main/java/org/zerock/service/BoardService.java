package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	public List<BoardVO> getList(Criteria cri);

	public BoardVO get(Long b_no);

	public void register(BoardVO board);

	public boolean remove(Long b_no);

	public boolean modify(BoardVO board);

	public int getTotal(Criteria cri);

	public List<BoardAttachVO> getAttachList(Long b_no);
}
