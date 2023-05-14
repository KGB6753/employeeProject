package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;

	private String type;
	private String keyword;

	public Criteria() {
		this(1, 15);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public int getPageStart() {
		if (pageNum < 1) {
			pageNum = 1;
		}
		return (pageNum - 1) * amount;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
		// type.split("") 그냥 한 문자씩 자름
	}

	public String getListLink() {
		UriComponentsBuilder builder;
		builder = UriComponentsBuilder.fromPath("").queryParam("pageNum", pageNum).queryParam("amount", amount).queryParam("type", type).queryParam("keyword", keyword);
		return builder.toUriString();
	}

}