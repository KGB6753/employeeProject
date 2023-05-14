package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.vo.DepartmentVO;
import org.zerock.domain.vo.DeptEmpVO;
import org.zerock.domain.vo.DeptTitleVO;
import org.zerock.domain.vo.TitleVO;
import org.zerock.mapper.DepartmentMapper;
import org.zerock.mapper.TitleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentServiceImpl implements DepartmentService {

	private final DepartmentMapper departmentMapper;
	private final TitleMapper titleMapper;

	@Override
	public List<DepartmentVO> getDepartments() {
		return departmentMapper.getDepartments();
	}

	@Override
	public List<DeptTitleVO> getDeptTitles(String dept_no) {
		return departmentMapper.getDeptTitles(dept_no);
	}

	@Override
	public List<DeptEmpVO> getDeptEmployee(Long emp_no) {
		// TODO Auto-generated method stub
		return departmentMapper.getDeptEmployee(emp_no);
	}

	@Override
	public List<TitleVO> getTitle(Long emp_no) {
		// TODO Auto-generated method stub
		return titleMapper.getTitles(emp_no);
	}
}
