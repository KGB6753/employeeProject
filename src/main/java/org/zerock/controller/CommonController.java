package org.zerock.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, HttpServletRequest request, Model model) {
		// HttpServletRequest request
		log.info("error : " + error);
		log.info("logout : " + logout);
		if (error != null) {
			model.addAttribute("error", "Login error check Your Account!");
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout!!!");
		}
		String referer = request.getHeader("Referer");

		if (referer != null && !referer.contains("/customLogin")) {
			request.getSession().setAttribute("prevPage", referer);
		}

	}

	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}

	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}

}
