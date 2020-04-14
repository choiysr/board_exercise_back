package com.dreamer.domain;

import lombok.Getter;

@Getter
public class Criteria {

	private int pageRequest;
	private int amount;
	private String searchCri;
	private String keyword;

	public Criteria() {
		this(1, 10);
	}

	public Criteria(int currentPage, int amount) {
		this.pageRequest = (currentPage-1)*10;
		this.amount = amount;
		this.searchCri = "";
		this.keyword = "";
	}
	
	public Criteria(int currentPage, int amount, String searchCri, String keyword) {
		this.pageRequest = (currentPage-1)*10;
		this.amount = amount;
		this.searchCri = searchCri;
		this.keyword = keyword;
	}

}
