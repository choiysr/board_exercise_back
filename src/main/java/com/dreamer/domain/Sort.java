package com.dreamer.domain;

import lombok.Data;

@Data
public class Sort {
	
	private String sortBy, order;
	
	
	public Sort() {
		this("bno",false);
	}
	
	public Sort(String sortBy, boolean order) {
		this.sortBy = sortBy;
		this.order = order ? "ASC" : "DESC";
	}

}
