package org.zerock.mapper;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.Criteria;
import org.zerock.domain.EmployeeDTO;
import org.zerock.domain.vo.EmployeeVO;

public interface EmployeeMapper {

	public List<EmployeeVO> getListWithPaging(Criteria cri);

	public int getTotalCount(Criteria cri);

	public int insertSelectKey(EmployeeVO emp);

	public int insertAuth(EmployeeVO emp);

	public EmployeeVO read(Long emp_no);

	public List<String> getDeptNames(Long emp_no);

	public List<String> getTitles(Long emp_no);

	public int update(EmployeeVO emp);

	public EmployeeDTO logRead(Long emp_no);

	public int changePwd(EmployeeVO emp);

}
