package com.dreamer.domain;

import java.time.LocalDateTime;

import javax.validation.constraints.NotNull;
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
	@NotNull(message = "입력하지 않은 항목이 있습니다.")
	private String title;
	private String writer;
	private String content;
	@Size(min=100, max=200,message="비밀번호는 4자 이상 12자 미만으로 설정하세요.")
	private String password;

	private LocalDateTime regdate, updateddatd;

}
