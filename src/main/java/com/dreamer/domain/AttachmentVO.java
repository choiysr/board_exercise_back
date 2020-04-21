package com.dreamer.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class AttachmentVO {
	
	private Integer ano;
	private String path;
	private String uuid;
	private String name;
	private Integer boardno;
	private Integer image;

}
