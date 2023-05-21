package com.skilldistillery.jpaspace.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.jpaspace.data.UserDAO;
import com.skilldistillery.jpaspace.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDAO;

	@RequestMapping(path = { "/", "home.do" })
	private String home(Model model) {
		User test = userDAO.findByUsernameAndPassword("admin", "1234");
		model.addAttribute("test", test);

		return "home";
	}

//	@GetMapping("login.do")
//	public String loginForm(HttpSession session) {
//		if (session.getAttribute("loggedInUser") != null) {
//			return "home";
//		}
//		return "login"; // Change this to registration form
//
//	}

	@PostMapping("login.do")
	public String login(Model model, User user, HttpSession session, RedirectAttributes redirect) {
		if (session.getAttribute("loggedInUser") != null) {
			return "home";
		}

		User authenticatedUser = userDAO.findByUsernameAndPassword(user.getUsername(), user.getPassword());
		if (authenticatedUser != null) {
			session.setAttribute("loggedInUser", authenticatedUser);
			return "userprofile";
		} else {
			boolean loggedOut = true;
			model.addAttribute("loggedOut", loggedOut);
			redirect.addFlashAttribute("loggedOut", loggedOut);

		}
		return "redirect:home.do";
	}

	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("loggedInUser");

		return "home";
	}

	@GetMapping("register.do")
	public String goToRegistrationForm() {
		return "register";
	}

	@PostMapping("newuser.do")
	public String addNewUser(Model model, User user, RedirectAttributes redirect) {

		user.setEnabled(true);
		User newUser = userDAO.addUser(user);

		boolean created = true;

		if (newUser == null) {
			created = false;
		}

		model.addAttribute("created", created);
		redirect.addFlashAttribute("created", created);

		return "redirect:home.do";
	}


	@GetMapping("sample.do")
	public String viewSamplePage() {
		return "sample";
	}

}
