package com.dreamer.mapper;

import java.util.List;

import com.dreamer.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 가져오기
	public List<ReplyVO> selectAllReply(Integer bno);
	
	// 댓글 등록
	public void insertReply(ReplyVO reply);
	
	// 댓글 삭제
	public void deleteReply(Integer rno);


}
