package com.dreamer.domain;

import lombok.Getter;

@Getter
public class Criteria {

	private int pageRequest;
	private int amount;

	public Criteria() {
		this(1, 10);
	}

	public Criteria(int currentPage, int amount) {
		this.pageRequest = (currentPage-1)*10;
		this.amount = amount;
	}

}
