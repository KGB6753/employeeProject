package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.EmployeeDTO;
import org.zerock.domain.PageDTO;
import org.zerock.service.EmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/employees/*")
@RequiredArgsConstructor
@Log4j
public class EmployeeController {

	private final EmployeeService employeeService;

	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register(EmployeeDTO empDTO) {
		log.info(".........../register : " + empDTO);
		employeeService.register(empDTO);
		return "redirect:/employees/list";
	}

	// Get /register
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void register() {
		log.info(".........../register");
	}

	@GetMapping("/list")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", employeeService.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, employeeService.getTotal(cri)));
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("emp_no") Long emp_no, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info(emp_no);
		model.addAttribute("employee", employeeService.get(emp_no));
	}

//	@GetMapping("/modify")
//	public void modify(@RequestParam("emp_no") Long emp_no, @ModelAttribute("cri") Criteria cri, Model model) {
//		log.info(emp_no);
//		model.addAttribute("employee", employeeService.get(emp_no));
//	}

	// 부서 이동이 이루어지면... 부서이동에 대한 update, 이동 전의 to_date에 대한 수정이 필요하다
	// 직책 이동이 되면.... 기존 to_date 수정, 새로운 직책에 대한 update
	// 직원 정보에 대한 수정도 이루어지면 해줘야 한다...
	@PostMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(EmployeeDTO empDTO, @ModelAttribute("cri") Criteria cri, RedirectAttributes rtts) {
		log.info("modify.......................");
		log.info(empDTO);
		/*
		 * Long emp_no = empDTO.getEmp_no(); EmployeeVO eVO =
		 * employeeService.get(emp_no);
		 * 
		 * DeptEmpVO deVO = empDTO.toDeptEmpVO();
		 * 
		 * TitleVO tVO = empDTO.toTitleVO(); if
		 * (!eVO.getDept_no().equals(deVO.getDept_no())) { // 부서가 바뀌면 부서랑 직책 업데이트 후에
		 * 기본정보 업데이트 log.info("부서 바뀜"); // 부서 update // 부서 insert // 직책 update // 직책
		 * insert // 개인정보 update } else { if (!eVO.getTitle().equals(tVO.getTitle())) {
		 * // 직책 바뀌면 직책 업데이트 후에 기본정보 업데이트 log.info("직책 바뀜"); // 직책 update // 직책 insert
		 * // 개인정보 update } else { // 아무것도 안바뀌면 기본정보만 업데이트 log.info("그대로"); // 개인정보
		 * update } }
		 */

		// 컨트롤러단에서는 여러 서비스를 불러오기보다는 서비스에서 트랜잭션을 이용하자...
		employeeService.modify(empDTO);
		return "redirect:/employees/list";
		// + cri.getListLink();
	}

	@PostMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(EmployeeDTO empDTO, @ModelAttribute("cri") Criteria cri, RedirectAttributes rtts) {
		log.info("remove.......................");
		log.info(empDTO);

		employeeService.remove(empDTO);
		return "redirect:/employees/list";
		// + cri.getListLink();
	}

	@PostMapping("/changePwd")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public String changePwd(Long emp_no, String newpw, @ModelAttribute("cri") Criteria cri, RedirectAttributes rtts) {
		log.info("비밀번호 확인");
		log.info(emp_no);
		log.info(newpw);
		EmployeeDTO empDTO = new EmployeeDTO();
		empDTO.setEmp_no(emp_no);
		empDTO.setEmp_pw(newpw);
		log.info(empDTO);
		employeeService.changePwd(empDTO);
		return "redirect:/board/list";
	}

//	public boolean checkPwd(@AuthenticationPrincipal UserAdapter user, @RequestParam String checkPassword, Model model) {
//		log.info("checkPwd 진입");
//		Long member_id = user.getMemberDto().getId();
//		return memberService.checkPassword(member_id, checkPassword);
//	}

}