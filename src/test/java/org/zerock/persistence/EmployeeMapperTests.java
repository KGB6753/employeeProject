package org.zerock.persistence;

import java.util.Calendar;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.EmployeeDTO;
import org.zerock.domain.vo.EmployeeVO;
import org.zerock.mapper.EmployeeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class EmployeeMapperTests {

	@Setter(onMethod_ = @Autowired)
	private EmployeeMapper mapper;
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Test
	public void testChangPwd() {
		EmployeeVO vo = new EmployeeVO();
		vo.setEmp_no(500002L);
		vo.setEmp_pw("qwer");
		mapper.changePwd(vo);

	}

	@Test
	public void testInsert() {
		Calendar cal = Calendar.getInstance();
		cal.set(2020, 1, 1);

		EmployeeVO vo = new EmployeeVO();
		vo.setFirst_name("First");
		vo.setLast_name("Last");
		vo.setGender("M");
		vo.setTitle("Staff");
		vo.setDept_no("d001");
		vo.setBirth_date(cal.getTime());
		cal.set(2022, 11, 7);
		vo.setHire_date(cal.getTime());
		mapper.insertSelectKey(vo);

	}

	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(2);
//		cri.setType("N");
//		cri.setKeyword("facello");
		log.info(mapper.getListWithPaging(cri));
	}

	@Test
	public void testGetTotalCount() {
		Criteria cri = new Criteria();
//		cri.setKeyword("facello");
//		cri.setType("N");
		log.info("..........total:" + mapper.getTotalCount(cri));
	}

	@Test
	public void testRead() {
		EmployeeVO vo = mapper.read(500000L);
		log.info(vo);
	}

	@Test
	public void testUpdate() {
		Calendar cal = Calendar.getInstance();
		cal.set(2020, 1, 1);

		EmployeeVO vo = new EmployeeVO();
		vo.setEmp_no(500001L);
		vo.setFirst_name("First");
		vo.setLast_name("Last");
		vo.setGender("M");
		vo.setTitle("Staff");
		vo.setDept_no("d001");
		vo.setBirth_date(cal.getTime());
		cal.set(2022, 11, 7);
		vo.setHire_date(cal.getTime());

		mapper.update(vo);
	}

	@Test
	public void testlogRead() {
		EmployeeDTO dto = mapper.logRead(500000L);
		log.info(dto);

		dto.getAuthList().forEach(authVO -> log.info(authVO));
	}

}
