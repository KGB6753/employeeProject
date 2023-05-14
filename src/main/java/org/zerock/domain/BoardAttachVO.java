package org.zerock.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	private String uuid;
	private String upload_Path;
	private String file_Name;
	private boolean file_Type;
	private Long b_no;
}
