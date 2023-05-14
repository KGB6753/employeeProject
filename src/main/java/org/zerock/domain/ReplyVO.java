package org.zerock.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReplyVO {
	private Long r_no; // PK
	private Long b_no; // FK
	private String reply;
	private Long emp_no;// replyer
	private Date update_date;// updatedate
	private Date reply_date;// replydate
}
