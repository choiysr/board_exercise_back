package com.dreamer.domain;

import java.time.LocalDateTime;

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
public class ReplyVO implements Pageable {
	
	private Integer rno;
	private Integer boardno;
	@Size(min=1, max=10,message="작성자명은 1자 이상 10자 이하로 설정하세요.")
	private String writer;
	@Size(min=1, max=500,message="내용은 1자 이상 500자 이하로 입력하세요.")
	private String content;
	@Size(min=4, max=12,message="비밀번호는 4자 이상 12자 미만으로 설정하세요.")
	private String password;

	private LocalDateTime regdate, updateddate;

}
