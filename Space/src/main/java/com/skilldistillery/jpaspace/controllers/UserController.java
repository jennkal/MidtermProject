package com.skilldistillery.jpaspace.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.jpaspace.data.UserDAO;
import com.skilldistillery.jpaspace.entities.User;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDAO;
	
	@RequestMapping(path = {"/", "home.do"})
	private String home(Model model) {
		User test= userDAO.findByUsernameAndPassword("admin", "1234");
		model.addAttribute("test", test);
		
		return "home";
	}

}
