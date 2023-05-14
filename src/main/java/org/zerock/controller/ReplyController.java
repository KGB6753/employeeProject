package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies/*")
@RequiredArgsConstructor
@Log4j
public class ReplyController {
	public final ReplyService replyService;

	// 패치와 풋 두가지 방식으로 받겠다.
	@RequestMapping(value = "/{r_no}", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE }, method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modify(@PathVariable("r_no") Long r_no, @RequestBody ReplyVO reply) {
		reply.setR_no(r_no);
		return (replyService.modify(reply) == 1) ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping(value = "/{r_no}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("r_no") Long r_no) {
		int insertCount = replyService.remove(r_no);

		return (insertCount == 1) ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "/{r_no}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("r_no") Long r_no) {

		return new ResponseEntity<>(replyService.get(r_no), HttpStatus.OK);
	}

	@GetMapping(value = "/pages/{b_no}/{page}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReplyPageDTO> getListPage(@PathVariable("page") int page, @PathVariable("b_no") Long b_no) {
		log.info("....................." + page);
		Criteria cri = new Criteria(page, 10);
		return new ResponseEntity<>(replyService.getListPage(cri, b_no), HttpStatus.OK);
	}

	// 받는거 json 응답 text
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ReplyVO reply) {
		log.info(reply);

		// 로우 .. 반환, 실행된 행의 숫자
		int insertCount = replyService.register(reply);

		return (insertCount == 1) ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
