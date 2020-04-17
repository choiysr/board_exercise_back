package com.dreamer.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;



@RequiredArgsConstructor
@Service
@Log4j
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper boardMapper;

	@Override
	public BoardVO read(Integer bno) {
		boardMapper.increaseViews(bno);
		return boardMapper.selectOneByBno(bno);
	}

	@Override
	public void write(BoardVO board) {
		boardMapper.insertBoard(board);
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
	public Integer authCheck(AuthCheck enteredInfo) {
		return boardMapper.authCheck(enteredInfo);
	}

	@Override
	public void update(BoardVO board) {
		boardMapper.updateBoard(board);
	}

	@Override
	public void delete(Integer bno) {
		boardMapper.deleteBoard(bno);
	}

}
