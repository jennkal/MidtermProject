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
	
	@GetMapping(path="commentsform.do", params="bodyId")
	public String addCommentForCelestialBody(int bodyId, Model model) {
		
		model.addAttribute("bodyId", bodyId);
		return "addcomment";
	}
	
	@PostMapping(path="addcomment.do")
	public String addCommentToDB(HttpSession session, CelestialBodyComment comment, Model model, RedirectAttributes redir, int userId, int bodyId) {
		
		CelestialBodyComment commentToAdd = cbcDAO.postComment(comment, userId, bodyId);

		model.addAttribute("bodyId", bodyId);
		redir.addFlashAttribute("bodyId", bodyId);
		return "redirect:singleview.do?id=" + bodyId;
	}
	@GetMapping(path="updateform.do", params="commentId")
	public String updateCommentForCelestialBody(int commentId, Model model) {
		
		model.addAttribute("commentId", commentId);
		model.addAttribute("comment", cbcDAO.findCommentById(commentId));
		return "updatecomment";
	}
	
	@PostMapping(path = "performUpdate.do", params={"commentId", "userId", "bodyId"})
	public String updateComment(HttpSession session, CelestialBodyComment comment, Model model, RedirectAttributes redir, int userId, int commentId, int bodyId) {

		CelestialBodyComment commentUpdated = cbcDAO.updateCommentById(comment, userId, commentId);
		
		model.addAttribute("bodyId", bodyId);
		redir.addFlashAttribute("bodyId", bodyId);
		return "redirect:singleview.do?id=" + bodyId;
	}
	
	
	@GetMapping(path = "deleteComment.do", params={"commentId", "bodyId"})
	public String deleteLog(CelestialBodyComment comment, Model model, RedirectAttributes redir, int commentId, int bodyId) {

		boolean removed = cbcDAO.removeCommentById(commentId);
		model.addAttribute("removed", removed);
		redir.addFlashAttribute("removed", removed);
		return "redirect:singleview.do?id=" + bodyId;
	}
	
}
