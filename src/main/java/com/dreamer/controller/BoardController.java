package com.dreamer.controller;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.OK;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.domain.PageDTO;
import com.dreamer.service.BoardService;
import com.dreamer.util.ResponseMsg;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/*")
@RequiredArgsConstructor
@Log4j
public class BoardController {

	private final BoardService boardService;
	private final ResponseMsg message;

	/**
	 * 
	 * @param currentPageInfo 파라미터에 대한 설명
	 * @return
	 */
	@GetMapping(value = "/list/{currentPage}")
	public ResponseEntity<PageDTO<BoardVO>> getAllList(@PathVariable Integer currentPage) {
		Criteria pageCri = new Criteria(currentPage, 10);
		int total = boardService.countAllBoards();
		List<BoardVO> boardList = boardService.getBoardList(pageCri);
		PageDTO<BoardVO> page = new PageDTO<>(pageCri, total, boardList);
		return new ResponseEntity<>(page, OK);
	}

	@PostMapping(value = "/board")
	public ResponseEntity<ResponseMsg> registerBoard(@RequestBody @Valid BoardVO board, BindingResult result) {
		// Valid 수정. 아래 로직 동작 안함. 
		message.setMsgKey("result");
		String tmp = "";
		if(result.hasErrors()) {
			log.info("HAS ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			List<ObjectError> errorList = result.getAllErrors();
			for(ObjectError error : errorList) {
				tmp+=error;
			}
			message.setMsgValue(tmp);
			// 에러시 리턴 > 리턴을 뭘로할까? 
		}else {
			message.setMsgValue("success");
			boardService.write(board);
		}
		return new ResponseEntity<>(message,OK);
	}
	
	@GetMapping(value = "board/{bno}")	
	public ResponseEntity<BoardVO> getOneBoard(@PathVariable Integer bno) {
		return new ResponseEntity<>(boardService.read(bno),OK);
	}
	
	@PostMapping(value = "/authcheck")
	public ResponseEntity<ResponseMsg> checkPassword(@RequestBody AuthCheck enteredInfo) {
		message.setMsgKey("result");
		ResponseEntity<ResponseMsg> res;
		if(!boardService.authCheck(enteredInfo).equals(enteredInfo.getBno())) {
			message.setMsgValue("FAIL");
			res = new ResponseEntity<>(message,BAD_REQUEST);
		} else {
			message.setMsgValue("SUCCESS");
			res = new ResponseEntity<>(message,OK);
		}
		return res;
	}

}
