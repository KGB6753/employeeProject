package org.zerock.domain.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DeptEmpVO {
	private Long emp_no;
	private String dept_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date from_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date to_date;
	private String dept_name;
}
