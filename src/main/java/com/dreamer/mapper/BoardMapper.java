package com.dreamer.mapper;

import java.util.List;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;

public interface BoardMapper {
	
	// to read  
	public BoardVO selectOneByBno(Integer bno);
	
	// 조회수 +1 
	public void increaseViews(Integer bno);
		
	// to create
	public void insertBoard(BoardVO board);
	
	// to get list 
	public List<BoardVO> selectAllBoard(Criteria pageInfo);
	
	// to count number of boards 
	public Integer countAllBoards();
	
	// 수정/삭제시 비밀번호 확인
	public Integer authCheck(AuthCheck enteredInfo);
	
	// 게시글 수정
	public void updateBoard(BoardVO board);
	
	// 게시글 삭제
	public void deleteBoard(Integer bno);
	
	// SEARCH TEST
	public  List<BoardVO> searchTest(Criteria pageInfo);
	
	// SEARCH TEST
	public  List<BoardVO> searchTest2(Criteria pageInfo);
	


}
