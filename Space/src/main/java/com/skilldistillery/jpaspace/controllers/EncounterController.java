package com.skilldistillery.jpaspace.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.jpaspace.data.EncounterDAO;
import com.skilldistillery.jpaspace.data.EncounterImageDAO;
import com.skilldistillery.jpaspace.data.UserDAO;
import com.skilldistillery.jpaspace.entities.Encounter;
import com.skilldistillery.jpaspace.entities.EncounterImage;
import com.skilldistillery.jpaspace.entities.User;

@Controller
public class EncounterController {
	
//	@Autowired
//	private EncounterDAO encounterDAO;
//	
//	@Autowired
//	private EncounterCommentDAO commentDAO;
	
	
	@Autowired
	private EncounterImageDAO imageDAO;
	
	@Autowired
	private EncounterDAO encounterDAO;

	
	@GetMapping(path = "viewimage.do")
	public String getList(Model model) {
		List<EncounterImage> list = imageDAO.findall();
		model.addAttribute("images", list);
		return "viewbody";
	}
	
	@GetMapping(path = "encounterform.do")
	public String addEncounterForm(int bodyId, Model model) {
		model.addAttribute("bodyId", bodyId);
		return "addencounter";
	}
	
	@PostMapping("addencounter.do")
	public String postEncounter(HttpSession session, Encounter encounter, Model model, RedirectAttributes redir, int userId, int bodyId,
			String imageUrl1, String imageUrl2, String imageUrl3, String imageUrl4, String imageUrl5) {

		Encounter newEncounter = encounterDAO.postEncounter(encounter, userId, bodyId,
				imageUrl1, imageUrl2, imageUrl3, imageUrl4, imageUrl5);

		if (newEncounter != null) {
			
			String bodyName = newEncounter.getCelestialBody().getName();
			
			model.addAttribute("name", bodyName);
			redir.addFlashAttribute("name", bodyName);
			return "redirect:viewbody.do?name=" + bodyName;
		} else {
			boolean creationError = true;
			model.addAttribute("creationError", creationError);
			redir.addFlashAttribute("creationError", creationError);
			model.addAttribute("bodyId", bodyId);
			redir.addFlashAttribute("bodyId", bodyId);
			return "redirect:encounterform.do";
		}

	}
	


}
