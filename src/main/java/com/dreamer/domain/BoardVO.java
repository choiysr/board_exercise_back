package com.dreamer.domain;

import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BoardVO implements Pageable{
	
	private Integer bno, views, rcount;
	@NotBlank(message = "제목을 입력하세요.")
	@Size(min=1, max=30,message="제목은 1자 이상 30자 이하로 입력하세요.")
	private String title;
	@NotBlank(message = "작성자를 입력하세요.")
	@Size(min=1, max=10,message="작성자명은 1자 이상 10자 이하로 입력하세요.")
	private String writer;
	@NotBlank(message = "내용을 입력하세요.")
	@Size(min=1, max=2000,message="내용은 1자이상 2000자 이하로 입력하세요.")
	private String content;
	@Size(min=4, max=12,message="비밀번호는 4자 이상 12자 미만으로 설정하세요.")
	private String password;
	

	private List<AttachmentVO> attachedList;
	private LocalDateTime regdate, updateddate;

}
