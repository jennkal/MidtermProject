package com.skilldistillery.jpaspace.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.skilldistillery.jpaspace.data.EncounterCommentDAO;
import com.skilldistillery.jpaspace.data.EncounterDAO;
import com.skilldistillery.jpaspace.data.EncounterImageDAO;
import com.skilldistillery.jpaspace.entities.EncounterImage;

@Controller
public class EncounterController {
	
	@Autowired
	private EncounterDAO encounterDAO;
	
	@Autowired
	private EncounterCommentDAO commentDAO;
	
	
	@Autowired
	private EncounterImageDAO imageDAO;
	
	@GetMapping(path = "viewimage.do")
	public String getList(Model model) {
		List<EncounterImage> list = imageDAO.findall();
		model.addAttribute("images", list);
		return "viewbody";
	}
	

}
