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

	@PostMapping("viewbody.do")
	public String postCelestialBody(CelestialBody body, Model model, RedirectAttributes redir, int categoryId) {

		CelestialBody newBody = cbDAO.postCelestialBody(body, categoryId);

		if (newBody != null) {
			List<CelestialBody> posts = new ArrayList<>();
			posts.add(newBody);
			model.addAttribute("bodies", posts);
			return "redirect:bodylist.do";
		} else {
			boolean bodyexist = true;
			model.addAttribute("notnew", bodyexist);
			redir.addFlashAttribute("notnew", bodyexist);
			return "redirect:userprofile.do";
		}

	}

	@GetMapping(path = "addbody.do")
	public String addbodyForm(int classificationId, Model model) {
		List<Category> list = cateDAO.findByClassificationId(classificationId);
		model.addAttribute("categories", list);
		return "addbody";
	}

	@GetMapping(path = "bodylist.do")
	public String getList(Model model, HttpSession session) {
		List<CelestialBody> list = cbDAO.findall();
		model.addAttribute("bodies", list);
		User user = (User) session.getAttribute("loggedInUser");
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
	
	
	
	@GetMapping(path = "updatecelestialbody.do", params="bodyId")
	public String toUpdateCelestialBody (Model model, int bodyId) {
		
		model.addAttribute("bodyId", bodyId);
		model.addAttribute("body", cbDAO.findCelestialBodyById(bodyId));
		
		return "editcelestialbody";
	}
	
	@PostMapping(path = "updatebody.do", params="bodyId")
	public String updateCelestialBody (CelestialBody body, Model model, RedirectAttributes redir, int bodyId) {
		
		CelestialBody cbbody = cbDAO.updateCelestialBodyById(body, bodyId);
		model.addAttribute("bodyId", bodyId);
		redir.addFlashAttribute("bodyId", bodyId);
		return "redirect:bodylist.do?id=" + bodyId;
	}
	
	
}
