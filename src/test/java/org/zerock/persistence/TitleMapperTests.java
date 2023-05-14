package org.zerock.persistence;

import java.util.Calendar;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.vo.TitleVO;
import org.zerock.mapper.TitleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TitleMapperTests {

	@Setter(onMethod_ = @Autowired)
	private TitleMapper titleMapper;

	@Test
	public void testInsert() {
		Calendar cal = Calendar.getInstance();
		TitleVO title = TitleVO.builder().emp_no(10001L).title("Staff").from_date(cal.getTime()).build();
		titleMapper.insert(title);
	}

	@Test
	public void testGetTitle() {
		titleMapper.getTitles(10009L).forEach(x -> log.info(x));
	}

	@Test
	public void testInsertChange() {
		TitleVO title = TitleVO.builder().emp_no(500001L).title("Manager").build();
		titleMapper.insertChange(title);
	}

	@Test
	public void testUpdate() {
		TitleVO title = TitleVO.builder().emp_no(500001L).build();
		titleMapper.update(title);
	}

}
