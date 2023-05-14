package org.zerock.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO {
	private Long b_no;
	private Long emp_no;
	private String title;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date reg_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date update_date;

	private int replycnt;

	private List<BoardAttachVO> attachList;
}
