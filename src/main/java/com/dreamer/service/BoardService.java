package com.dreamer.service;

import java.util.List;
import java.util.Map;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;


public interface BoardService {
	
	public BoardVO read(Integer bno);
	public void write(BoardVO board);
	public List<BoardVO> getBoardList(Criteria pageInfo);
	public Integer countAllBoards(Criteria pageInfo);
	public String authCheck(AuthCheck enteredInfo);
	public void update(BoardVO board);
	public void delete(Integer bno);
	public String getOriginalFileName(String wholeFileName);
	public Integer moveTo(Map<String,Object> moving);


}
