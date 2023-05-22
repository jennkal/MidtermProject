package com.skilldistillery.jpaspace.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.jpaspace.data.CategoryDAO;
import com.skilldistillery.jpaspace.data.CelestialBodyCommentDAO;
import com.skilldistillery.jpaspace.data.CelestialBodyDAO;
import com.skilldistillery.jpaspace.entities.Category;
import com.skilldistillery.jpaspace.entities.CelestialBody;

@Controller
public class CelestialBodyController {
	
	@Autowired
	private CelestialBodyDAO cbDAO;
	
//	@Autowired
//	private CelestialBodyCommentDAO commentDAO;
	
	@Autowired
	private CategoryDAO cateDAO;
	
	
	@PostMapping("galaxy.do")
	public String postCelestialBody(HttpSession session, CelestialBody body, Model model, RedirectAttributes redir) {
		if(body == null) {
			body.setEnabled(true);
			CelestialBody newBody = cbDAO.postCelestialBody(body);
			session.setAttribute("post", newBody);
			return "galaxy";
		}else {
			boolean bodyexist = true;
			model.addAttribute("notnew", bodyexist);
			redir.addFlashAttribute("notnew", bodyexist);	
		}
		return "redirect:addbody.do";	
	}
	
	@GetMapping(path="addbody.do",  params="classification")
	public String addbodyForm(@RequestParam("classification") int clasId, Model model) {
		List<Category> list = cateDAO.findClassId(clasId);
		model.addAttribute("categories",list);
		return "addbody";
	}
	
	@RequestMapping(path="bodylist", method=RequestMethod.GET)
	public String getList(Model model ) {
		List<CelestialBody> list = cbDAO.findall();
		model.addAttribute("list",list);
		return"galaxy";
	}
	
	
//	@PostMapping("galaxy.do")
//	public String postComment() {
//		
//		return "galaxy";
//		
	
	

}
