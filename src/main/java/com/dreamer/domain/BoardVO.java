package com.dreamer.domain;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString
public class BoardVO implements Pageable {
	
	private Integer bno, views;
	@NotBlank(message = "제목을 입력하세요.")
	private String title;
	@NotBlank(message = "작성자를 입력하세요.")
	private String writer;
	@NotBlank(message = "내용을 입력하세요.")
	private String content;
	@Size(min=4, max=12,message="비밀번호는 4자 이상 12자 미만으로 설정하세요.")
	private String password;

	private LocalDateTime regdate, updateddate;

}
