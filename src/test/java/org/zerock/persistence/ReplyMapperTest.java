package org.zerock.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {
	private Long[] bnoArr = { 2L, 3L, 4L, 5L, 6L };

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;

	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setAmount(10);
		cri.setPageNum(1);
		List<ReplyVO> replies = replyMapper.getListWithPaging(cri, 3L);
		replies.forEach(i -> log.info(i));
	}

	@Test
	public void testCount() {
		Long b_no = 3L;
		log.info(replyMapper.getCountByBno(b_no));
	}

	@Test
	public void testUpdate() {
		Long rno = 11L;
		ReplyVO reply = replyMapper.read(rno);
		reply.setReply("update reply......");
		int count = replyMapper.update(reply);
		log.info("......update count : " + count);
	}

	@Test
	public void testDelete() {
		replyMapper.delete(10L);
	}

	@Test
	public void testRead() {
		replyMapper.read(10L);
	}

	@Test
	public void testInsert() {
//		log.info(replyMapper);
//		IntStream.rangeClosed(1, 10).forEach(i -> {
//			ReplyVO reply = ReplyVO.builder().b_no(bnoArr[i % 5]).reply("테스트" + i).emp_no("테스트" + i).build();
//			replyMapper.insert(reply);
//		});
		ReplyVO reply = ReplyVO.builder().b_no(2L).emp_no(500000L).reply("!!!!!!!!!!!!!!!").build();

		replyMapper.insert(reply);

	}
}
