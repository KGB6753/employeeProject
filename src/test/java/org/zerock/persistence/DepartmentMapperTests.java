package org.zerock.persistence;

import java.util.Calendar;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.vo.DepartmentVO;
import org.zerock.domain.vo.DeptEmpVO;
import org.zerock.mapper.DepartmentMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DepartmentMapperTests {

	@Setter(onMethod_ = @Autowired)
	private DepartmentMapper departmentMapper;

	@Test
	public void testGetDepartments() {
		List<DepartmentVO> list = departmentMapper.getDepartments();
		list.forEach(d -> {
			log.info(d);
		});
	}

	@Test
	public void testInsertDeptEmp() {
		Calendar cal = Calendar.getInstance();
//		cal.set(0, 0, 0);
		DeptEmpVO emp = DeptEmpVO.builder().emp_no(10001L).dept_no("d001").from_date(cal.getTime()).build();

		departmentMapper.insertDeptEmployee(emp);

	}

	@Test
	public void testDeptEmp() {
		List<DeptEmpVO> list = departmentMapper.getDeptEmployee(499992L);
		list.forEach(emp -> log.info(emp));
		// departmentMapper.getDeptEmployee(499992L).forEach(x -> log.info(x));
		;

	}

	@Test
	public void testChangeDeptInsert() {
		Calendar cal = Calendar.getInstance();
		DeptEmpVO emp = DeptEmpVO.builder().emp_no(500001L).dept_no("d005").build();

		departmentMapper.insertChangeDeptEmployee(emp);
	}

	@Test
	public void testUpdateDeptInsert() {
		Calendar cal = Calendar.getInstance();
		DeptEmpVO emp = DeptEmpVO.builder().emp_no(500001L).dept_no("d005").build();

		departmentMapper.updateDeptEmployee(emp);
	}

}
