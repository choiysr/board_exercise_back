package com.dreamer.service;

import java.util.List;

import com.dreamer.domain.ReplyVO;

public interface ReplyService {
	
	public void write(ReplyVO reply);	
	public List<ReplyVO> getReplyList(Integer bno); 
	public void delete(Integer rno);

}
