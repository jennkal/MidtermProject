package com.skilldistillery.jpaspace.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.jpaspace.data.CategoryDAO;
import com.skilldistillery.jpaspace.data.CelestialBodyDAO;
import com.skilldistillery.jpaspace.data.EncounterImageDAO;
import com.skilldistillery.jpaspace.entities.Category;
import com.skilldistillery.jpaspace.entities.CelestialBody;
import com.skilldistillery.jpaspace.entities.CelestialBodyComment;
import com.skilldistillery.jpaspace.entities.User;

@Controller
public class CelestialBodyController {

	@Autowired
	private CelestialBodyDAO cbDAO;
	
	@Autowired
	
	private EncounterImageDAO imageDAO;

	@Autowired
	private CategoryDAO cateDAO;

	@PostMapping(path="viewbody.do", params="userId")
	public String postCelestialBody(CelestialBody body, Model model, RedirectAttributes redir, int categoryId, int userId) {

		CelestialBody newBody = cbDAO.postCelestialBody(body, categoryId);

		if (newBody != null) {
			List<CelestialBody> posts = new ArrayList<>();
			posts.add(newBody);
			model.addAttribute("bodies", posts);
			return "viewbody";
		} else {
			boolean bodyexist = true;
			model.addAttribute("notnew", bodyexist);
			redir.addFlashAttribute("notnew", bodyexist);
			return "redirect:userprofile.do?userId=" + userId;
		}

	}

	@GetMapping(path = "addbody.do")
	public String addbodyForm(int classificationId, Model model) {
		List<Category> list = cateDAO.findByClassificationId(classificationId);
		model.addAttribute("categories", list);
		return "addbody";
	}

	@GetMapping(path = "bodylist.do")
	public String getList(Model model) {
		List<CelestialBody> list = cbDAO.findall();
		model.addAttribute("bodies", list);
		return "bodylist";
	}
	
	
	@GetMapping(path="viewbody.do", params="name")
	public String searchByKeyword(@RequestParam("name") String keyword, Model model) {
		List<CelestialBody> list = cbDAO.searchByKeyword(keyword);
		model.addAttribute("bodies",list);
		return "bodylist";
	}
	
	@GetMapping(path="singleview.do", params="id")
	public String singleBody(@RequestParam("id") int id, Model model, HttpSession session) {
		CelestialBody body = cbDAO.findCelestialBodyById(id);
		model.addAttribute("body",body);
		List<String> list = imageDAO.findAllImagesByBodyId(id);
		model.addAttribute("images", list);
		User user = (User) session.getAttribute("loggedInUser");
		model.addAttribute("loggedInUser",user);
		return "viewbody";
	}
	
	
	@GetMapping(path="sampleview.do", params="id")
	public String nonUserSingleBody(@RequestParam("id") int id, Model model) {
		CelestialBody body = cbDAO.findCelestialBodyById(id);
		model.addAttribute("body",body);
		List<String> list = imageDAO.findAllImagesByBodyId(id);
		model.addAttribute("images", list);
		return "sample";
	}
	
	
	
	@GetMapping(path = "deleteBody.do", params={"categoryId", "bodyId"})
	public String removeCelestialBody (CelestialBody body, Model model, RedirectAttributes redir, int categoryId, int bodyId) {
		
		boolean removed = cbDAO.removeCelestialBodyId(categoryId);
		model.addAttribute("removed", removed);
		redir.addFlashAttribute("removed", removed);
		return "redirect:bodylist.do?id=" + bodyId;
	}
	
	
}
