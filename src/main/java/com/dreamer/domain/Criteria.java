package com.dreamer.domain;

import lombok.Data;

@Data
public class Criteria {

	private Integer pageRequest;
	private Integer amount;
	private String searchOption;
	private String keyword;

	public Criteria() {
		this(1, 10, "", "");
	}

	
	public Criteria(Integer currentPage, Integer amount, String searchOption, String keyword) {
		this.pageRequest = (currentPage-1)*10;
		this.amount = amount;
		this.searchOption = searchOption;
		this.keyword = keyword;
	}
	
	public String[] getCategory() {
		return this.searchOption.trim().split("");
	}
	

}
