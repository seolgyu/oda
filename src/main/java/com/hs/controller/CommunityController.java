package com.hs.controller;

import java.io.IOException;

import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/community/*")
public class CommunityController {
	
	@GetMapping("create")
	public ModelAndView createForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		return new ModelAndView("community/create");
	}
	
	@GetMapping("main")
	public ModelAndView mainPage(HttpServletRequest req, HttpServletResponse resp) {
		return new ModelAndView("community/main");
	}
	
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("community/update");
	}
	
	
}
