package com.dreamer.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.domain.PageDTO;
import com.dreamer.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;



@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper boardMapper;

	@Override
	public BoardVO read(Integer bno) {
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
	public Integer countAllBoards() {
		return boardMapper.countAllBoards();
	}

	@Override
	public Integer authCheck(AuthCheck enteredInfo) {
		return boardMapper.authCheck(enteredInfo);
	}

}
