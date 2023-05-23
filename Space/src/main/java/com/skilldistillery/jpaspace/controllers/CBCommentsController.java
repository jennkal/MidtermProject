package com.skilldistillery.jpaspace.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.skilldistillery.jpaspace.data.CelestialBodyCommentDAO;

@Controller
public class CBCommentsController {

	@Autowired
	private CelestialBodyCommentDAO cbcDAO;
	
	@GetMapping(path="commentsform.do")
	public String addCommentForCelestialBody(int bodyId, Model model) {
		
		model.addAttribute("bodyId", bodyId);
		return "addcomment";
	}
}
