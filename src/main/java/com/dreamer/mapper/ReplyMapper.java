package com.dreamer.mapper;

import java.util.List;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 리스트 가져오기
	public List<ReplyVO> selectAllReply(Integer bno);
	
	// 댓글 등록
	public void insertReply(ReplyVO reply);
	
	// 댓글 삭제
	public void deleteReply(Integer rno);
	
	// 댓글 수정
	public void updateReply(ReplyVO reply);
	
	// 댓글 1개 가져오기
	public ReplyVO selectOneByRno(Integer rno);
	
	// 비밀번호 체크
	public Integer authCheck(AuthCheck enteredInfo);


}