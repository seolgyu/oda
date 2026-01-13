package com.hs.controller.admin;

import java.io.IOException;
import java.util.List;

import com.hs.model.admin.MainDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.admin.MainService;
import com.hs.service.admin.MainServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeManageController {
	private MainService service = new MainServiceImpl();
	@GetMapping("/admin")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/home/main");
		
		try {
			List<MainDTO> list = service.mainList();
			mav.addObject("list", list);
		} catch (Exception e) {
			
		}
		return mav;
	}
}