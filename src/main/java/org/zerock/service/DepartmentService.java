package org.zerock.service;

import java.util.List;

import org.zerock.domain.vo.DepartmentVO;
import org.zerock.domain.vo.DeptEmpVO;
import org.zerock.domain.vo.DeptTitleVO;
import org.zerock.domain.vo.TitleVO;

public interface DepartmentService {

	public List<DepartmentVO> getDepartments();

	public List<DeptTitleVO> getDeptTitles(String dept_no);

	public List<DeptEmpVO> getDeptEmployee(Long emp_no);

	public List<TitleVO> getTitle(Long emp_no);
}
