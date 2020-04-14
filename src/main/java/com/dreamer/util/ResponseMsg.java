package com.dreamer.util;

import lombok.Getter;

@Getter
public class ResponseMsg {
	
	private StatusEnum status;
	private String message;

	public ResponseMsg(StatusEnum status, String message) {
		this.status = status;
		this.message = message;
	}
	
}
