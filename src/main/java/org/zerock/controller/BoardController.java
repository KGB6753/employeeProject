package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	private final BoardService boardService;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
//		int total = boardService.getTotal(cri);
		log.info("list  " + cri);
//		model.addAttribute("list", boardService.getList(cri));
//		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, boardService.getTotal(cri)));
	}

	@GetMapping({ "/get", "/modify" }) /* 이거 안쓰면 jsp에서 criteria로 풀네임 써야함 */
	public void get(@RequestParam("b_no") Long b_no, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info(b_no);
		model.addAttribute("board", boardService.get(b_no));
	}

	@PostMapping("/modify") // 리다이렉트시에 임시적으로 보내는 데이터 rtts에
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rtts) {
		log.info(board);
		log.info("modify.......................");
		if (boardService.modify(board)) {
			rtts.addFlashAttribute("result", "success");
		} else {
			rtts.addFlashAttribute("result", "fail");
		}

		rtts.addAttribute("pageNum", cri.getPageNum());
		rtts.addAttribute("amount", cri.getAmount());

		return "redirect:/board/list";
	}

	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public void register() {

	}

	@GetMapping("/test")
	public void test() {

	}

	@GetMapping("/test2")
	public void test2() {

	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rtts) {
		log.info("register : " + board);

		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}

		boardService.register(board);
		rtts.addFlashAttribute("result", board.getB_no());

		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("b_no") Long b_no, @ModelAttribute("cri") Criteria cri, RedirectAttributes rtts) {
		log.info("remove.......................");
		List<BoardAttachVO> attachList = boardService.getAttachList(b_no);
		if (boardService.remove(b_no)) {
			deleteFiles(attachList);
			rtts.addFlashAttribute("result", "success");
		} else {
			rtts.addFlashAttribute("result", "fail");
		}

		rtts.addAttribute("pageNum", cri.getPageNum());
		rtts.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list";
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long b_no) {
		log.info("getAttachList b_no : " + b_no);

		return new ResponseEntity<>(boardService.getAttachList(b_no), HttpStatus.OK);
	}

	public void deleteFiles(List<BoardAttachVO> attachList) {
		if (attachList == null || attachList.size() == 0) {
			return;
		}

		log.info("delete attach files...................");

		attachList.forEach(attach -> {
			try {
				String path = "C:\\upload\\" + attach.getUpload_Path() + "\\" + attach.getUuid() + "_" + attach.getFile_Name();
				Path file = Paths.get(path);
				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {
					String thumbNailPath = "C:\\upload\\" + attach.getUpload_Path() + "\\s_" + attach.getUuid() + "_" + attach.getFile_Name();
					Path thumbNail = Paths.get(thumbNailPath);
					Files.deleteIfExists(thumbNail);
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
		});
	}
}
