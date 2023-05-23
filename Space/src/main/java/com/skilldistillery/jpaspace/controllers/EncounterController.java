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
	public String postEncounter(Encounter encounter, Model model, RedirectAttributes redir, int userId, int bodyId,
			String imageUrl1, String imageUrl2, String imageUrl3, String imageUrl4, String imageUrl5) {

		Encounter newEncounter = encounterDAO.postEncounter(encounter, userId, bodyId, imageUrl1, imageUrl2, imageUrl3,
				imageUrl4, imageUrl5);

		if (newEncounter != null) {

			model.addAttribute("id", bodyId);
			redir.addFlashAttribute("name", bodyId);
			return "redirect:singleview.do?id=" + bodyId;
		} else {
			boolean creationError = true;
			model.addAttribute("creationError", creationError);
			redir.addFlashAttribute("creationError", creationError);
			model.addAttribute("bodyId", bodyId);
			redir.addFlashAttribute("bodyId", bodyId);
			return "redirect:encounterform.do";
		}

	}
	
	@GetMapping(path = "editencounterform.do")
	public String editEncounterForm(int encounterId, int bodyId, Model model) {
		Encounter existingEncounter = encounterDAO.findEncounterById(encounterId); 
		model.addAttribute("existingEncounter", existingEncounter);
		model.addAttribute("bodyId", bodyId);
		return "editencounter";
	}
	
	@PostMapping("editencounter.do")
	public String updateEncounter(Encounter encounter, Model model, RedirectAttributes redir, int encounterId, int bodyId) {

		Encounter updatedEncounter = encounterDAO.updateEncounter(encounter, encounterId);

		if (updatedEncounter != null) {

			model.addAttribute("id", bodyId);
			redir.addFlashAttribute("name", bodyId);
			return "redirect:singleview.do?id=" + bodyId;
		} else {
			boolean editError = true;
			model.addAttribute("editError", editError);
			redir.addFlashAttribute("editError", editError);
			model.addAttribute("bodyId", bodyId);
			redir.addFlashAttribute("bodyId", bodyId);
			model.addAttribute("encounterId", encounterId);
			redir.addFlashAttribute("encounterId", encounterId);
			return "redirect:editencounterform.do";
		}

	}

	@GetMapping(path="deleteencounter.do", params={"encounterId", "bodyId"})
	public String removeEncounter(Model model, RedirectAttributes redir, int encounterId, int bodyId) {

		boolean removedEncounter = encounterDAO.removeEncounter(encounterId);
		model.addAttribute("removedEncounter", removedEncounter);
		redir.addFlashAttribute("removedEncounter", removedEncounter);
		return "redirect:singleview.do?id=" + bodyId;

	}

}
