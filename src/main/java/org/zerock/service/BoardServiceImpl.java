package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {
	private BoardMapper boardMapper;
	private BoardAttachMapper boardAttachMapper;
	private ReplyMapper replyMapper;

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public BoardVO get(Long b_no) {
		return boardMapper.read(b_no);
	}

	@Transactional
	@Override
	public void register(BoardVO board) {
		boardMapper.insert(board);

		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}

		board.getAttachList().forEach(attach -> {
			attach.setB_no(board.getB_no());
			boardAttachMapper.insert(attach);
		});
	}

	@Transactional
	@Override
	public boolean remove(Long b_no) {
		boardAttachMapper.deleteAll(b_no);
		replyMapper.deleteAll(b_no);
		return boardMapper.delete(b_no) == 1;
	}

	@Override
	public boolean modify(BoardVO board) {
		boardAttachMapper.deleteAll(board.getB_no());
		boolean modifyResult = boardMapper.update(board) == 1;

		if (modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setB_no(board.getB_no());
				boardAttachMapper.insert(attach);
			});
		}

		return modifyResult;
	}

	@Override
	public int getTotal(Criteria cri) {
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long b_no) {
		log.info("get attach list by bno : " + b_no);
		log.info("!!!!!");
		return boardAttachMapper.findByB_no(b_no);
	}
}
