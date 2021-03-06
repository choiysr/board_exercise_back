package com.dreamer.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.domain.ReplyVO;
import com.dreamer.domain.Sort;
import com.dreamer.loading.LoadingTests;
import com.dreamer.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class BoardMapperTests extends LoadingTests {

	@Setter(onMethod_ = { @Autowired })
	BoardMapper bmapper;
	
	@Setter(onMethod_ = { @Autowired })
	ReplyMapper rmapper;
	
	@Setter(onMethod_ = {@Autowired})
	AttachmentMapper amapper;


	@Test
	public void selectBoardByBnoTest() {
		log.info("===MapperTest : findBoardByBno===");
		log.info(bmapper.selectOneByBno(1));
	}

	@Test
	public void insertBoardTest() {
		log.info("===MapperTest : insertBoard===");
		BoardVO board = BoardVO.builder().writer("writer_test").content("content_test").password("password")
				.title("한글제목").build();
		bmapper.insertBoard(board);
	}

	@Test
	public void insertDummies() {
		log.info("=====insert dummy datas=====");
		IntStream.range(0, 100).forEach(i -> {
			bmapper.insertBoard(BoardVO.builder().writer("작성자" + i +"zz").content("content" + i + "zdsfjaheur").password("1234")
					.title("HI THERE! " + i).build());
		});
	}

	@Test
	public void selectAllBoardWithPagingTest() {
		log.info("===================MapperTest : selectAllBoardTest===");
//		log.info(bmapper.selectAllBoard(new Criteria(100, 10)));
	}

	@Test
	public void selectAllWithSort() {
		log.info("===================MapperTest : countAllBoardTest===");
//		Criteria cri3 = new Criteria(1, 10, "", "", new Sort("views",false));
//		log.info(bmapper.selectAllBoard(cri3));
	}

	@Test
	public void validationTest() {
		// 안됨. 다시해볼것
		log.info("VALIDATION TEST ===============");
		try {
			bmapper.insertBoard(BoardVO.builder().writer("1111").title("TITLE").password("1").content("hi").build());
		} catch (Exception e) {
			log.info("ERROR!!!!!!!!!!!!!!!!!!!!!!");
			e.printStackTrace();
		}
	}

	@Test
	public void authCheckTest() {
//		log.info(bmapper.authCheck(AuthCheck.builder().bno(215).password("125454534").build()));

	}

	@Test
	public void updateBoardTest() {
//		Integer test = bmapper.updateBoard(BoardVO.builder().bno(null).title("변경1111111").content("변경").build());
		// log.info(test);
	}
	
	@Test
	public void deleteBoardTest() {
		bmapper.deleteBoard(220);
	}
	
	@Test
	public void searchTest() {
//		Criteria cri = new Criteria(1, 5, "W", "z");
//		List<BoardVO> list = bmapper.searchTest(cri);
//		list.forEach(board -> {
//			log.info(board);
//		});
//		
//		log.info("=============");
//		
//		Criteria cri2 = new Criteria(1, 5, "TC", "하");
//		List<BoardVO> list2 = bmapper.searchTest(cri2);
//		list2.forEach(board -> {
//			log.info(board);
//		});
//		
//		
		

//
	}
	
	
	@Test
	public void replyCountTest() {
		//Criteria cri3 = new Criteria(1, 10, "", "");
		//List<BoardVO> list3 = bmapper.allTest(cri3);
//		list3.forEach(board -> {
//			log.info(board);
//		});
	}
	
	@Test
	public void replyInsertTest() {
		rmapper.insertReply(ReplyVO.builder().boardno(352).content("zzzzz").writer("wrrrrrr").password("1234").build());
		
	}
	
	@Test
	public void readBoardwithoutReply() {
		log.info(bmapper.selectOneByBno(350));
	}
	
	@Test
	public void getAttachmentListTest() {
		BoardVO board = bmapper.selectOneByBno(357);
		board.setAttachedList(amapper.selectAttachmentsByBno(357));
		log.info(board);
	}
	
	@Test
	public void getOriginalFileNameTest() {
		String result = amapper.getOriginalFileName("8336a6f9-c6ca-4029-a4fc-7b36a6bd28d3222.pdf");
		log.info(result);
	}
	
	@Test
	public void moveToOtherBoardNo() {
		Map<String,Object> moving = new HashMap<> ();
		moving.put("bno", 515);
		moving.put("direction", "prev");
		log.info(bmapper.moveTo(moving));
	}
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService bs;
	
	@Test
	public void selectOneBoardTesetWithAnotherQuery() {
		Criteria pageCri = new Criteria(1, 10,"","",new Sort("bno","desc"));
		List<BoardVO> boardList = bmapper.selectAllBoard(pageCri);
		boardList.forEach(item -> {
			log.info(item);
		});
		
		log.info("----");
		
		List<BoardVO> boardList2 = bs.getBoardList(pageCri);
		boardList2.forEach(item -> {
			log.info(item);
		});
		
	}
	
	

}
