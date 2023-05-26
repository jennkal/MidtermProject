package com.skilldistillery.jpaspace.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.jpaspace.data.CelestialBodyDAO;
import com.skilldistillery.jpaspace.data.EncounterDAO;
import com.skilldistillery.jpaspace.data.EncounterImageDAO;
import com.skilldistillery.jpaspace.data.RatingDAO;
import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.Encounter;
import com.skilldistillery.jpaspace.entities.Rating;
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
	
	@Autowired
	private CelestialBodyDAO bodyDAO;
	
	@Autowired
	private RatingDAO ratingDAO;

//	@PostMapping("viewimage.do")
//	public String getList(Model model, int bodyid) {
//		List<String> list = imageDAO.findAllImagesByBodyId(bodyid);
//		model.addAttribute("images", list);
//		return "viewbody";
//	}
//	

	@GetMapping(path="encounterlist.do", params="bodyId")
	public String viewEncountersByBody(HttpSession session, Model model, int bodyId) {
	 List<Encounter> encounters = encounterDAO.findEncountersByBodyId(bodyId); 
	 CelestialBody body = bodyDAO.findCelestialBodyById(bodyId);
	 model.addAttribute("encounters", encounters);
	 model.addAttribute("body", body);
	 User user = (User) session.getAttribute("loggedInUser");
	 return "encounterlist";
	}
	
	@GetMapping(path="viewencounter.do", params={"encounterId", "userId"})
	public String viewSingleEncounter(HttpSession session, Model model, int encounterId, int userId) {
	 Encounter encounter = encounterDAO.findEncounterById(encounterId);
	 CelestialBody body = encounter.getCelestialBody();
	 double averageRating = ratingDAO.averageRatingByEncounterId(encounterId);
	 Rating loggedInUserRating = ratingDAO.ratingByEncounterIdAndUserId(encounterId, userId);
	 model.addAttribute("encounter", encounter);
	 model.addAttribute("body", body);
	 model.addAttribute("averageRating" , averageRating);
	 model.addAttribute("loggedInUserRating" , loggedInUserRating);
	 User user = (User) session.getAttribute("loggedInUser");
	 return "viewencounter";
	}

	@GetMapping(path = "encounterform.do", params="bodyId")
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
			return "redirect:encounterlist.do?bodyId=" + bodyId;
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
	public String editEncounterForm(int encounterId, int bodyId, Model model, HttpSession session) {
		Encounter existingEncounter = encounterDAO.findEncounterById(encounterId);
		model.addAttribute("existingEncounter", existingEncounter);
		model.addAttribute("bodyId", bodyId);
		 User user = (User) session.getAttribute("loggedInUser");
		return "editencounter";
	}

	@PostMapping("editencounter.do")
	public String updateEncounter(Encounter encounter, Model model, RedirectAttributes redir, int encounterId,
			int bodyId, HttpSession session) {

		Encounter updatedEncounter = encounterDAO.updateEncounter(encounter, encounterId);
		 User user = (User) session.getAttribute("loggedInUser");

		if (updatedEncounter != null) {

			model.addAttribute("id", bodyId);
			redir.addFlashAttribute("name", bodyId);
			return "redirect:encounterlist.do?bodyId=" + bodyId;
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

	@GetMapping(path = "deleteencounter.do", params = { "encounterId", "bodyId" })
	public String removeEncounter(Model model, RedirectAttributes redir, int encounterId, int bodyId, HttpSession session) {

		boolean removedEncounter = encounterDAO.removeEncounter(encounterId);
		model.addAttribute("removedEncounter", removedEncounter);
		redir.addFlashAttribute("removedEncounter", removedEncounter);
		 User user = (User) session.getAttribute("loggedInUser");
		return "redirect:encounterlist.do?bodyId=" + bodyId;

	}

}
