package com.dreamer.service;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.domain.PageDTO;
import com.dreamer.loading.LoadingTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class BoardServiceTests extends LoadingTests{
	
	@Setter(onMethod_ = {@Autowired})
	BoardService bService;
	
	@Test
	public void boardServiceWithPagingTest() {

		int currentPage = 1;
		Criteria pageCri = new Criteria(currentPage, 10);
		int total = bService.countAllBoards();
		List<BoardVO> boardList = bService.getBoardList(pageCri);
		
		PageDTO<BoardVO> page = new PageDTO<>(pageCri, total, boardList);
		
	}
	

}
