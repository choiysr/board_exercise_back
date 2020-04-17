package com.dreamer.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dreamer.domain.ReplyVO;
import com.dreamer.mapper.ReplyMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReplyServiceImpl implements ReplyService{
	
	private final ReplyMapper replyMapper;
	

	@Override
	public List<ReplyVO> getReplyList(Integer bno) {
		return replyMapper.selectAllReply(bno);
	}


	@Override
	public void write(ReplyVO reply) {
		replyMapper.insertReply(reply);		
	}


	@Override
	public void delete(Integer rno) {
		replyMapper.deleteReply(rno);
	}

}
