package com.dreamer.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.mapper.AttachmentMapper;
import com.dreamer.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;



@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper boardMapper;
	private final AttachmentMapper attachmentMapper;

	@Override
	@Transactional
	public BoardVO read(Integer bno) {
		boardMapper.increaseViews(bno);
		BoardVO board = boardMapper.selectOneByBno(bno);
		board.setAttachedList(attachmentMapper.selectAttachmentsByBno(bno));
//		BoardVO board = boardMapper.selectTest(bno);
		return board;
	}

	@Override
	@Transactional
	public void write(BoardVO board) {
		boardMapper.insertBoard(board);
		Integer bno = attachmentMapper.getCurrentBno();
		board.getAttachedList().forEach(attachment -> {
			attachment.setBoardno(bno);
		});
		board.getAttachedList().forEach(attachmentMapper::insertAttachments);
	}

	@Override
	public List<BoardVO> getBoardList(Criteria pageInfo) {
		return boardMapper.selectAllBoard(pageInfo);
	}

	@Override
	public Integer countAllBoards(Criteria pageInfo) {
		return boardMapper.countAllBoards(pageInfo);
	}

	@Override
	public String authCheck(AuthCheck enteredInfo) {
		return boardMapper.authCheck(enteredInfo);
	}

	@Override
	@Transactional
	public void update(BoardVO board) {
		attachmentMapper.deleteAttachments(board.getBno());
		board.getAttachedList().forEach(attachment -> {
			attachment.setBoardno(board.getBno());
		});
		board.getAttachedList().forEach(attachmentMapper::insertAttachments);
		boardMapper.updateBoard(board);
	}

	@Override
	public void delete(Integer bno) {
		boardMapper.deleteBoard(bno);
	}

	@Override
	public String getOriginalFileName(String wholeFileName) {
		return attachmentMapper.getOriginalFileName(wholeFileName);
	}

	@Override
	public Integer moveTo(Map<String, Object> moving) {
		return boardMapper.moveTo(moving);
	}
	
	

}
