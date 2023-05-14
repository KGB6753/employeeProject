package org.zerock.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.EmployeeDTO;
import org.zerock.domain.vo.DeptEmpVO;
import org.zerock.domain.vo.EmployeeVO;
import org.zerock.domain.vo.TitleVO;
import org.zerock.mapper.DepartmentMapper;
import org.zerock.mapper.EmployeeMapper;
import org.zerock.mapper.TitleMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class EmployeeServiceImpl implements EmployeeService {

	private final EmployeeMapper employeeMapper;
	private final DepartmentMapper departmentMapper;
	private final TitleMapper titleMapper;
	private final PasswordEncoder pwencoder;

	@Override
	public List<EmployeeVO> getList(Criteria cri) {
		return employeeMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return employeeMapper.getTotalCount(cri);
	}

	@Transactional
	@Override
	public int register(EmployeeDTO dto) {
		EmployeeVO vo = dto.toEmployeeVO();
		String pw = "password";
		vo.setEmp_pw(pwencoder.encode(pw));
		employeeMapper.insertSelectKey(vo);
		employeeMapper.insertAuth(vo);
		dto.setEmp_no(vo.getEmp_no());
		departmentMapper.insertDeptEmployee(dto.toDeptEmpVO());
		return titleMapper.insert(dto.toTitleVO());
	}

	@Override
	public EmployeeVO get(Long emp_no) {
		return employeeMapper.read(emp_no);
	}

	@Override
	public List<String> getDeptNames(Long emp_no) {
		// TODO Auto-generated method stub
		return employeeMapper.getDeptNames(emp_no);
	}

	@Override
	public List<String> getTitles(Long emp_no) {
		// TODO Auto-generated method stub
		return employeeMapper.getTitles(emp_no);
	}

	@Transactional
	@Override
	public int modify(EmployeeDTO dto) {
		DeptEmpVO deptEmpVO = dto.toDeptEmpVO();
		TitleVO titleVO = dto.toTitleVO();
		EmployeeVO employeeVO = dto.toEmployeeVO();
		employeeVO.setEmp_no(dto.getEmp_no());

		log.info(employeeVO);
		log.info("체크!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");

		if (departmentMapper.eqCurrentDept(deptEmpVO) == 0) {
			// deptEmpVO.setFrom_date(null);
			// 기존 부서 수정하기...
			departmentMapper.updateDeptEmployee(deptEmpVO);
			// 새로 부서 추가인서트 하기...
			departmentMapper.insertChangeDeptEmployee(deptEmpVO);
			// 기존 직책 수정하기...
			titleMapper.update(titleVO);
			// 직책 추가 하기...
			titleMapper.insertChange(titleVO);
		} else {
			// 기존 직책 수정하기...
			titleMapper.update(titleVO);
			// 직책 추가 하기...
			titleMapper.insertChange(titleVO);
		}

//		1. title 변경 시에
//		 title, from_date가 같으면 오류...(다시 같은 직책과 날짜인지 내역 조회해서 insert 제외하고 update만 시행)
//
//		 2.dept_emp 변경 시에
//		  dept_emp가 같으면 오류...(다시 같은 부서로 돌아오면, 부서 내역 조회해서, insert제외하고 update만 시행 해야함)

		return employeeMapper.update(employeeVO);
	}

	@Transactional
	@Override
	public int remove(EmployeeDTO dto) {
		DeptEmpVO deptEmpVO = dto.toDeptEmpVO();
		TitleVO titleVO = dto.toTitleVO();

		titleMapper.update(titleVO);
		return departmentMapper.updateDeptEmployee(deptEmpVO);
	}

	@Override
	public int changePwd(EmployeeDTO dto) {
		// TODO Auto-generated method stub
		log.info("서비스");

		dto.setEmp_pw(pwencoder.encode(dto.getEmp_pw()));
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmp_no(dto.getEmp_no());
		employeeVO.setEmp_pw(dto.getEmp_pw());
		return employeeMapper.changePwd(employeeVO);
	}

}
