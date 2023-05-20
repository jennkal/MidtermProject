package com.skilldistillery.jpaspace.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@GetMapping("login.do")
	public String loginForm(HttpSession session) {
		if (session.getAttribute("loggedInUser") != null) {
			return "index";
		}
		return "login"; // Change this to registration form

	}

	@PostMapping("login.do")
	public String login(Model model, User user, HttpSession session) {
		if (session.getAttribute("loggedInUser") != null) {
			return "index";
		}
		String viewName = "";
		User authenticatedUser = userDAO.findByUsernameAndPassword(user.getUsername(), user.getPassword());
		if (authenticatedUser != null) {
			session.setAttribute("loggedInUser", authenticatedUser);
			viewName = "userprofile";
		} else {
			viewName = "login";
		}
		return viewName;
	}

	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("loggedInUser");
		// alternate:
		// session.invalidate();
		return "index";
	}

}
