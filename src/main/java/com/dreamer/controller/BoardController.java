package com.dreamer.controller;

import static org.springframework.http.HttpStatus.CREATED;
import static org.springframework.http.HttpStatus.OK;
import static org.springframework.http.HttpStatus.UNAUTHORIZED;
import static org.springframework.http.HttpStatus.UNPROCESSABLE_ENTITY;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CrossOrigin;
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
import org.springframework.web.multipart.MultipartFile;

import com.dreamer.domain.AuthCheck;
import com.dreamer.domain.BoardVO;
import com.dreamer.domain.Criteria;
import com.dreamer.domain.PageDTO;
import com.dreamer.domain.ReplyVO;
import com.dreamer.service.BoardService;
import com.dreamer.service.ReplyService;
import com.dreamer.util.EncodingPassword;
import com.dreamer.util.FileUtil;
import com.dreamer.util.ResponseMsg;
import com.dreamer.util.StatusEnum;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/*")
@RequiredArgsConstructor
@Log4j
@CrossOrigin(origins = "*")
public class BoardController {

	private final BoardService boardService;
	private final ReplyService replyService;

	// 게시글 리스트 불러오기
	@GetMapping(value = "/list")
	public ResponseEntity<PageDTO<BoardVO>> getAllList(@ModelAttribute Criteria pageInfoObj) {
		Criteria pageCri = new Criteria(pageInfoObj.getPageRequest(), pageInfoObj.getAmount(), pageInfoObj.getSearchOption(), pageInfoObj.getKeyword(), pageInfoObj.getSort());
		int total = boardService.countAllBoards(pageCri);
		List<BoardVO> boardList = boardService.getBoardList(pageCri);
		PageDTO<BoardVO> page = new PageDTO<>(pageCri, total, boardList);
		return new ResponseEntity<>(page, OK);
	}
	 

	// 게시글 등록
	// Validation 검사
	@PostMapping(value = "/board")
	public ResponseEntity<ResponseMsg> registerBoard(@RequestBody @Valid BoardVO board, BindingResult validationInfo) {
		log.info(board);
		ResponseEntity<ResponseMsg> response;
		if (validationInfo.hasErrors()) {
			response = validationCheck(validationInfo);
		} else {
			board.setPassword(EncodingPassword.encrypt(board.getPassword()));
			boardService.write(board);
			response = new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), CREATED);
		}
		return response;
	}

	// 게시글 읽기
	@GetMapping(value = "/board/{bno}")
	public ResponseEntity<BoardVO> getOneBoard(@PathVariable Integer bno) {
		return new ResponseEntity<>(boardService.read(bno), OK);
	}

	// 게시글 수정
	@PutMapping(value = "/board")
	public ResponseEntity<ResponseMsg> updateBoard(@RequestBody @Valid BoardVO board, BindingResult validationInfo) {
		ResponseEntity<ResponseMsg> response;
		if (validationInfo.hasErrors()) {
			response = validationCheck(validationInfo);
		} else {
			boardService.update(board);
			response = new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), CREATED);
		}
		return response;
	}

	// 게시글 삭제
	@DeleteMapping(value = "board/{bno}")
	public ResponseEntity<ResponseMsg> deleteBoard(@PathVariable Integer bno) {
		boardService.delete(bno);
		return new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), OK);
	}
	
	// 전,후 게시글 번호 
	@GetMapping(value = "board/moveto")
	public ResponseEntity<Integer> getPrevBno(
			   @RequestParam(value = "bno") Integer bno, @RequestParam(value = "direction")String direction) {
		Map<String,Object> moving = new HashMap<>();
		moving.put("bno", bno);
		moving.put("direction", direction);
		Integer result = boardService.moveTo(moving);
		if(result==null) result = 0;
		return new ResponseEntity<>(result, OK);
	} 
	

	// 댓글 리스트 가져오기
	@GetMapping(value = "/reply/{bno}")
	public ResponseEntity<List<ReplyVO>> getReplies(@PathVariable Integer bno) {
		return new ResponseEntity<>(replyService.getReplyList(bno), OK);
	}

	// 댓글 등록
	@PostMapping(value = "/reply")
	public ResponseEntity<ResponseMsg> registerReply(@RequestBody @Valid ReplyVO reply, BindingResult validationInfo) {
		ResponseEntity<ResponseMsg> response;
		if (validationInfo.hasErrors()) {
			response = validationCheck(validationInfo);
		} else {
			reply.setPassword(EncodingPassword.encrypt(reply.getPassword()));
			replyService.write(reply);
			response = new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), CREATED);
		}
		return response;
	}

	// 댓글 수정
	@PutMapping(value = "/reply")
	public ResponseEntity<ResponseMsg> updateReply(@RequestBody @Valid ReplyVO reply, BindingResult validationInfo) {
		ResponseEntity<ResponseMsg> response;
		if (validationInfo.hasErrors()) {
			response = validationCheck(validationInfo);
		} else {
			replyService.update(reply);
			response = new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), CREATED);
		}
		return response;
	}

	// 댓글 수정을 위한 댓글 가져오기
	// 댓글 가져오기
	@GetMapping(value = "/reply/forUpdate/{rno}")
	public ResponseEntity<ReplyVO> getOneReply(@PathVariable Integer rno) {
		return new ResponseEntity<>(replyService.read(rno), OK);
	}

	// 댓글 삭제
	@DeleteMapping(value = "/reply/{rno}")
	public ResponseEntity<ResponseMsg> deleteReply(@PathVariable Integer rno) {
		replyService.delete(rno);
		return new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), OK);
	}

	// 수정/삭제시 비밀번호 체크
	@PostMapping(value = "/authcheck")
	public ResponseEntity<ResponseMsg> checkPassword(@RequestBody AuthCheck enteredInfo) {
		boolean check;
		ResponseEntity<ResponseMsg> response;
		String hashed;
		String entered = enteredInfo.getPassword();
		if (enteredInfo.getType().equals("board")) {
			hashed = boardService.authCheck(enteredInfo);
			check = EncodingPassword.isMatch(entered, hashed);
		} else {
			hashed = replyService.authCheck(enteredInfo);
			check = EncodingPassword.isMatch(entered, hashed);
		}

		response = check ? new ResponseEntity<>(new ResponseMsg(StatusEnum.SUCCESS, "성공"), OK)
				: new ResponseEntity<>(new ResponseMsg(StatusEnum.FAIL, "비밀번호가 틀립니다. 다시 입력해주세요"), UNAUTHORIZED);
		return response;
	}

	// 파일 업로드
	@PostMapping(value = "/saveFile")
	public ResponseEntity<List<Map<String, String>>> uploadFile(MultipartFile[] uploadFile) {
		return new ResponseEntity<>(FileUtil.saveFile(uploadFile), OK);
	}

	// 파일 display(이미지 파일 경로를 받고 해당 이미지를 return)
	@GetMapping(value = "/display")
	public ResponseEntity<byte[]> displayImage(@RequestParam String fileName) {
		log.info("DISPLAY");
		log.info(fileName);
		File file = new File("C:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> download(@RequestParam String wholeFileName) {
		String fileNameFixed = wholeFileName.substring(wholeFileName.lastIndexOf("/") + 1, wholeFileName.length());
		Resource resource = new FileSystemResource("c:\\upload\\" + wholeFileName);
		String resourceName = boardService.getOriginalFileName(fileNameFixed);
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition",
					"attachment; filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<>(resource, headers, OK);
	}

	// 유효성 검사(게시글 등록, 수정시 사용)
	public ResponseEntity<ResponseMsg> validationCheck(BindingResult validationInfo) {
		String eachError = "";
		String errorMessage = "";
		List<ObjectError> errorList = validationInfo.getAllErrors();
		for (ObjectError each : errorList) {			
			eachError = each.toString();
			errorMessage += (eachError.substring(eachError.lastIndexOf("message") + 9, eachError.length()).replace("]", "").trim())+"\n";
		}
		log.info(errorMessage);
		return new ResponseEntity<>(new ResponseMsg(StatusEnum.FAIL, errorMessage), UNPROCESSABLE_ENTITY);
	}
}
