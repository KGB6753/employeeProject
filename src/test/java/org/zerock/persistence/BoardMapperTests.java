package org.zerock.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;

	@Test
	public void testGetList() {
		log.info("----------------------------------------------");
		boardMapper.getList().forEach(b -> log.info(b));
		log.info("----------------------------------------------");

	}

	@Test
	public void testGetTotal() {
		Criteria cri = new Criteria();
		log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + boardMapper.getTotalCount(cri));
	}

	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setType("E");
		cri.setKeyword("500000");
		cri.setPageNum(1);
		boardMapper.getListWithPaging(cri);
	}

	@Test
	public void testRead() {
//		log.info(boardMapper.read(Long.valueOf(2)));
		// 숫자 뒤에 L을 붙이면 롱타입으로...
		log.info(boardMapper.read(1L));
	}

	@Test
	public void testInsert() {

		log.info("----------------------------------------------");
//		BoardVO board = new BoardVO();
//		board.setTitle("ASDF");
//		board.setContent("QWER");
//		board.setemp_no("ZXCV");
		BoardVO board = BoardVO.builder().title("ASDF").content("QWER").emp_no(500000L).build();
//		boardMapper.insert(board);
		boardMapper.insertSelectKey(board);
		log.info("----------------------------------------------");

	}

	@Test
	public void testDelete() {
		boardMapper.delete(1L);
	}

	@Test
	public void testUpdate() {
		BoardVO vo = BoardVO.builder().b_no(1L).title("난나난").content("무나난").emp_no(500000L).build();
		int result = boardMapper.update(vo);
		log.info("===========================================================");
		log.info("count.............." + result);
		log.info("===========================================================");
	}

}
