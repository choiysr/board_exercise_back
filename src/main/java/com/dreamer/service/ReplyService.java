package com.dreamer.service;

import java.util.List;

import com.dreamer.domain.AuthCheck;

import com.dreamer.domain.BoardVO;
import com.dreamer.domain.ReplyVO;

public interface ReplyService {
	
	public void write(ReplyVO reply);	
	public List<ReplyVO> getReplyList(Integer bno); 
	public void update(ReplyVO reply);
	public void delete(Integer rno);
	public ReplyVO read(Integer rno);
	public Integer authCheck(AuthCheck enteredInfo);

}