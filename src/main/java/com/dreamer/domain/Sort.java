package com.dreamer.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class Sort {
	
	private String sortBy;
	private String order;
	
	public Sort(String sortBy, String order) {
		this.sortBy = sortBy;
		this.order = order;
	}	


	public void setOrder(String order) {
		this.order = order.equals("true") ? "ASC" : "DESC";
	}
	
	public void setOrder(boolean order) {
		this.order = order ? "ASC" : "DESC";
	}
	



}
