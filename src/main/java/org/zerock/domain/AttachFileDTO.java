package org.zerock.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	private String file_Name;
	private String upload_Path;
	private String uuid;
	private boolean image;
}
