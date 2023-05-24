package com.skilldistillery.jpaspace.controllers;

import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.jpaspace.data.CelestialBodyCommentDAO;
import com.skilldistillery.jpaspace.entities.CelestialBodyComment;
import com.skilldistillery.jpaspace.entities.User;

@Controller
public class CBCommentsController {

	@Autowired
	private CelestialBodyCommentDAO cbcDAO;
	
	@GetMapping(path="commentsform.do")
	public String addCommentForCelestialBody(int bodyId, Model model) {
		
		model.addAttribute("bodyId", bodyId);
		return "addcomment";
	}
	
	@PostMapping(path="addcomment.do")
	public String addCommentToDB(HttpSession session, CelestialBodyComment comment, Model model, RedirectAttributes redir, int userId, int bodyId) {
		
		CelestialBodyComment commentToAdd = cbcDAO.postComment(comment, userId, bodyId);
		//commentToAdd.setBody(bodyText);
		//commentToAdd.setEnabled(true);
		
		//LocalDateTime rightNow = LocalDateTime.now();
		//commentToAdd.setCreatedAt(rightNow);
		
		//User user = new User();
		//user.setId(userId);
		//commentToAdd.setUser(user);
		
		
		model.addAttribute("bodyId", bodyId);
		redir.addFlashAttribute("bodyId", bodyId);
		return "redirect:singleview.do?id=" + bodyId;
	}
}
