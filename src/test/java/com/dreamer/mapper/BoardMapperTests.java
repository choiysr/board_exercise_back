package com.dreamer.mapper;

import java.util.stream.IntStream;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.loading.LoadingTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class BoardMapperTests extends LoadingTests {

	@Setter(onMethod_ = { @Autowired })
	BoardMapper bmapper;
	

	@Test
	public void selectBoardByBnoTest() {
		log.info("===MapperTest : findBoardByBno===");
		log.info(bmapper.selectOneByBno(1));
	}

	@Test
	public void insertBoardTest() {
		log.info("===MapperTest : insertBoard===");
		BoardVO board = BoardVO.builder().writer("writer_test").content("content_test").password("password").title("한글제목").build();
		bmapper.insertBoard(board);
	}
	
	@Test
	public void insertDummies() {
		log.info("=====insert dummy datas=====");
		IntStream.range(104, 120).forEach(i->{
			bmapper.insertBoard(BoardVO.builder().writer("writer"+i).content("content"+i).password("pw").title("타이틀"+i).build());
		});
	}

	@Test
	public void selectAllBoardWithPagingTest() {
		log.info("===================MapperTest : selectAllBoardTest===");
		log.info(bmapper.selectAllBoard(new Criteria(100, 10)));
	}
	
	@Test
	public void countAllBoardTest() {
		log.info("===================MapperTest : countAllBoardTest===");
		log.info(bmapper.countAllBoards());
	}
	
	@Test
	public void validationTest() {
		// 안됨. 다시해볼것
		log.info("VALIDATION TEST ===============");
		try {
			bmapper.insertBoard(BoardVO.builder().writer("1111").title("TITLE").password("1").content("hi").build());
		}catch(Exception e) {
			log.info("ERROR!!!!!!!!!!!!!!!!!!!!!!");
			e.printStackTrace();
		}
	}
	
	@Test
	public void authCheckTest() {
		log.info(bmapper.authCheck(AuthCheck.builder().bno(215).password("125454534").build()));
		
	}

}
