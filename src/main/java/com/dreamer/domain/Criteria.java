package com.dreamer.domain;

import lombok.Data;

@Data
public class Criteria {

	private Integer pageRequest;
	private Integer amount;
	private String searchOption;
	private String keyword;
	private Sort sort;

	public Criteria() {
		this(1, 10, "", "", new Sort("bno","DESC"));
	}

	
	public Criteria(Integer currentPage, Integer amount, String searchOption, String keyword, Sort sort) {
		this.pageRequest = (currentPage-1)*amount;
		this.amount = amount;
		this.searchOption = searchOption;
		this.keyword = keyword;
		this.sort = sort;
	}
	
	public String[] getCategory() {
		return this.searchOption.trim().split("");
	}
	

}
