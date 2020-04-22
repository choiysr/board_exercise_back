package com.dreamer.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class AuthCheck {
	
	private Integer bno;
	private String password;
	private String type;
	
	public Integer getRno() {
		return this.bno;
	}
	

}
