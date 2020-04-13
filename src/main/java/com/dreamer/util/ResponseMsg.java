package com.dreamer.util;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Component
@AllArgsConstructor
@Setter
@Getter
public class ResponseMsg {
	
	private String msgKey, msgValue;
	
	public ResponseMsg() {
		this("status","success");
	}
	

}
