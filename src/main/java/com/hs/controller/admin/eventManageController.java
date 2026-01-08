package com.hs.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.hs.model.admin.EventDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;

import com.hs.mvc.annotation.RequestMapping;

import com.hs.mvc.view.ModelAndView;


import com.hs.service.admin.EventService;
import com.hs.service.admin.EventServiceImpl;
import com.hs.util.FileManager;
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@Controller
@RequestMapping("/admin/events/*")
public class eventManageController {
	private EventService service = new EventServiceImpl();
	private MyUtil util = new MyUtil();
	
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이벤트 리스트
		// 넘어오는 파라미터 : [글번호, 페이지번호[검색컬럼, 검색값]]
		ModelAndView mav = new ModelAndView("admin/events/list");
		
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<EventDTO> list = service.listEvent(map);
			
			
			// 포워딩할 데이터
			mav.addObject("list", list);
			/*
			mav.addObject("listEvent", listEvent);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			*/	
						
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/events/write");
		return mav;
	}
}