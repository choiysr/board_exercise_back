package com.dreamer.controller;

import static org.springframework.http.HttpStatus.CREATED;
import static org.springframework.http.HttpStatus.OK;
import static org.springframework.http.HttpStatus.UNAUTHORIZED;
import static org.springframework.http.HttpStatus.UNPROCESSABLE_ENTITY;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.domain.PageDTO;
import com.dreamer.service.BoardService;
import com.dreamer.util.ResponseMsg;
import com.dreamer.util.StatusEnum;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/*")
@RequiredArgsConstructor
@Log4j
public class BoardController {

	private final BoardService boardService;

	// 게시글 리스트 불러오기 
	// @modelattribute로 테스트해보기. 
	@GetMapping(value = "/list")
	public ResponseEntity<PageDTO<BoardVO>> getAllList(
			@RequestParam("pageRequest") Integer pageRequest,
			@RequestParam("amount") Integer amount,
			@RequestParam(value = "searchOption", defaultValue = "") String searchOption,
			@RequestParam(value = "keyword", defaultValue = "") String keyword) {
		log.info(searchOption);
		log.info(keyword);
		Criteria pageCri = new Criteria(pageRequest, amount, searchOption, keyword);
		int total = boardService.countAllBoards();
		List<BoardVO> boardList = boardService.getBoardList(pageCri);
		PageDTO<BoardVO> page = new PageDTO<>(pageCri, total, boardList);
		return new ResponseEntity<>(page, OK);
	}

	// 게시글 등록
	// Validation 검사 
	@PostMapping(value = "/board")
	public ResponseEntity<ResponseMsg> registerBoard(@RequestBody @Valid BoardVO board, BindingResult validationInfo) {
		return validationCheck(board, validationInfo);
	}

	// 게시글 읽기 
	@GetMapping(value = "/board/{bno}")
	public ResponseEntity<BoardVO> getOneBoard(@PathVariable Integer bno) {
		return new ResponseEntity<>(boardService.read(bno), OK);
	}

	// 수정/삭제시 비밀번호 체크 
	@PostMapping(value = "/authcheck")
	public ResponseEntity<ResponseMsg> checkPassword(@RequestBody AuthCheck enteredInfo) {
		ResponseEntity<ResponseMsg> response = boardService.authCheck(enteredInfo).equals(enteredInfo.getBno())
				? new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), OK)
				: new ResponseEntity<>(new ResponseMsg(StatusEnum.FAIL, "비밀번호가 틀립니다. 다시 입력해주세요"), UNAUTHORIZED);
		return response;
	}
	
	// 게시글 수정 
	@PutMapping(value ="/board")
	public ResponseEntity<ResponseMsg> updateBoard(@RequestBody @Valid BoardVO board, BindingResult validationInfo) {
		return validationCheck(board, validationInfo);
	}
	
	// 게시글 삭제 
	@DeleteMapping(value = "board/{bno}")
	public  ResponseEntity<ResponseMsg> deleteBoard(@PathVariable Integer bno) {
		boardService.delete(bno);
		return new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), OK);		
	}	
		
	// 유효성 검사(게시글 등록, 수정시 사용)
	public ResponseEntity<ResponseMsg> validationCheck(BoardVO board, BindingResult validationInfo) {
		ResponseEntity<ResponseMsg> response; 
		if (validationInfo.hasErrors()) {
			String errorMessage = validationInfo.getAllErrors().get(0).toString();
			errorMessage = errorMessage
					.substring(errorMessage.lastIndexOf("message") + 9, errorMessage.length())
					.replace("]", "").trim();
			log.info(errorMessage);
			response = new ResponseEntity<>(new ResponseMsg(StatusEnum.FAIL, errorMessage), UNPROCESSABLE_ENTITY);
		} else {
			boardService.update(board);
			response = new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), CREATED);
		}		
		return response;		
	}
	


}
