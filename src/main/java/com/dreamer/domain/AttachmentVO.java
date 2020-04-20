package com.dreamer.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@ToString
public class AttachmentVO {
	
	private Integer ano;
	private String path;
	private String name;
	private Integer boardno;

}
