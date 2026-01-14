package com.hs.controller.admin;

import java.io.IOException;

import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/member/*")
public class memberManageController {
	@GetMapping("list")
	public ModelAndView memberList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/member/list");
		return mav;
	}
	
	@GetMapping("detailmember")
	public ModelAndView detailmember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/member/detailmember");
		return mav;
	}
}
