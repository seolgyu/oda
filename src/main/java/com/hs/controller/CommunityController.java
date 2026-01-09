package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.CommunityService;
import com.hs.service.CommunityServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/community/*")
public class CommunityController {
	private CommunityService cservice = new CommunityServiceImpl();
	
	@GetMapping("create")
	public ModelAndView createForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		ModelAndView mav = new ModelAndView("community/create");

		List<CommunityDTO> categoryList = cservice.getCategoryList();
		
		mav.addObject("categories", categoryList);
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping("create")
	public ModelAndView createSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String com_name = req.getParameter("com_name");
		String com_description = req.getParameter("com_description");
		String is_private = req.getParameter("is_private");
		String category_id = req.getParameter("category_id");
		
		CommunityDTO dto = new CommunityDTO();
		dto.setCom_name(com_name);
		dto.setCom_description(com_description);
		dto.setIs_private("private".equals(is_private) ? "1" : "0");
		dto.setCategory_id(category_id);
		dto.setUser_num(info.getMemberIdx());
		
		
		try {
			cservice.insertCommunity(dto);
			dto = cservice.isCommunityName(com_name);
			
			ModelAndView mav = new ModelAndView("community/main");
			mav.addObject("dto", dto);
			mav.addObject("is_private", dto.getIs_private().equals("0") ? "전체공개" : "비공개");
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			
			ModelAndView mav = new ModelAndView("community/create");
			
			List<CommunityDTO> categoryList = cservice.getCategoryList();
			mav.addObject("categories", categoryList);
			
			mav.addObject("dto", dto);
			mav.addObject("mode", "error");
			
			return mav;
		}
		
	}
	
	@GetMapping("main")
	public ModelAndView mainPage(HttpServletRequest req, HttpServletResponse resp) {
		String com_id = req.getParameter("community_id");
		
		ModelAndView mav = new ModelAndView("community/main");
		
		try {
			if(com_id != null) {
				Long community_id = Long.parseLong(com_id);
				CommunityDTO dto = cservice.findById(community_id);
	            mav.addObject("dto", dto);
	            mav.addObject("is_private_text", dto.getIs_private().equals("0") ? "전체공개" : "비공개");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("community/update");
	}
	
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		return new ModelAndView("community/create");
	}
	
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("redirect:/community/management");
	}
	
	@GetMapping("management")
	public ModelAndView managementList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		ModelAndView mav = new ModelAndView("community/management");
		
		try {
			Map<String, Object> allmap = new HashMap<String, Object>();
			allmap.put("user_num", info.getMemberIdx());
			allmap.put("mode", "allList");
			
			List<CommunityDTO> allList = cservice.searchCommunity(allmap);
			System.out.println("디버깅 - allList 개수: " + (allList != null ? allList.size() : "null"));
			mav.addObject("allList", allList);
			
			Map<String, Object> favmap = new HashMap<String, Object>();
			favmap.put("user_num", info.getMemberIdx());
			favmap.put("mode", "favOnly");
			
			List<CommunityDTO> favList = cservice.searchCommunity(favmap);
			mav.addObject("favList", favList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@GetMapping("list")
	public ModelAndView communityList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("community/list");
	}
	
}
