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
		
		mav.addObject("categoryList", categoryList);
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping("create")
	public Map<String, Object> createSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		Map<String, Object> map = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		CommunityDTO dto = new CommunityDTO();
		dto.setCom_name(req.getParameter("com_name"));
	    dto.setCom_description(req.getParameter("com_description"));
	    dto.setIs_private("private".equals(req.getParameter("is_private")) ? "1" : "0");
	    dto.setCategory_id(Long.parseLong(req.getParameter("category_id")));
	    dto.setUser_num(info.getMemberIdx());
		
		try {
			cservice.insertCommunity(dto);
			
			CommunityDTO saveDto = cservice.isCommunityName(dto.getCom_name());
			
			map.put("status", "success");
			map.put("community_id", saveDto.getCommunity_id());

		} catch (Exception e) {
			List<CommunityDTO> categoryList = cservice.getCategoryList();
			map.put("categoryList", categoryList);
			map.put("status", "error");
			map.put("dto", dto);
			e.printStackTrace();
		}
		return map;
	}
	
	@GetMapping("main")
	public ModelAndView mainPage(HttpServletRequest req, HttpServletResponse resp) {
		String com_id = req.getParameter("community_id");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(com_id == null || com_id.isEmpty()) {
			return new ModelAndView("redirect:/community/list");
		}
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_id", Long.parseLong(com_id));
			map.put("user_num", info.getMemberIdx());
			CommunityDTO dto = cservice.findById(map);
				
			if(dto != null) {
				ModelAndView mav = new ModelAndView("community/main");
				mav.addObject("dto", dto);
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/community/list");
	}
	
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String com_id = req.getParameter("community_id");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView("community/update");
		
		try {
			if(com_id != null) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("community_id", Long.parseLong(com_id));
				map.put("user_num", info.getMemberIdx());
				CommunityDTO dto = cservice.findById(map);
	            mav.addObject("dto", dto);
	            
	            List<CommunityDTO> categoryList = cservice.getCategoryList();
	    		mav.addObject("categories", categoryList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@ResponseBody
	@GetMapping("checkName")
	public Map<String, Object> checkName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> map = new HashMap<>();
		Boolean isDuplicate;
		String com_name = req.getParameter("com_name");
		
		try {
			CommunityDTO dto = cservice.isCommunityName(com_name);

			if( dto != null) {
				isDuplicate = true;
			} else {
				isDuplicate = false;
			}
			map.put("isDuplicate", isDuplicate);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	    return map;
	}
	
	@ResponseBody
	@PostMapping("update")
	public Map<String, Object> updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			String com_id = req.getParameter("community_id");
	        String com_name = req.getParameter("com_name");
	        String description = req.getParameter("com_description");
	        String is_private = req.getParameter("is_private");
	        String topic_id = req.getParameter("category_id");
	        String icon = req.getParameter("icon_image");
	        String banner = req.getParameter("banner_image");
	        
	        if(com_name == null || com_name.trim().isEmpty() || description == null || description.trim().isEmpty()) {
	            map.put("status", "fail");
	            map.put("message", "모든 필드를 입력해주세요.");
	            return map;
	        }

	        CommunityDTO dto = new CommunityDTO();
	        dto.setCommunity_id(Long.parseLong(com_id));
	        dto.setCom_name(com_name);
	        dto.setCom_description(description);
	        dto.setIs_private("private".equals(is_private) ? "1" : "0");
	        dto.setCategory_id(Long.parseLong(topic_id));
	        dto.setIcon_image(icon); 
	        dto.setBanner_image(banner);
	        
	        cservice.updateCommunity(dto);

	        map.put("status", "success");
	        map.put("community_id", com_id);
	        map.put("message", "커뮤니티 설정이 변경되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "error");
	        map.put("message", e.getMessage());
		}
		
		return map;
	}
	
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String community_id = req.getParameter("community_id");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_id", Long.parseLong(community_id));
	        map.put("user_num", info.getMemberIdx());
	        
			cservice.deleteCommunity(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
			
			List<CommunityDTO> allList = cservice.managementList(allmap);
			System.out.println("디버깅 - allList 개수: " + (allList != null ? allList.size() : "null"));
			mav.addObject("allList", allList);
			
			Map<String, Object> favmap = new HashMap<String, Object>();
			favmap.put("user_num", info.getMemberIdx());
			favmap.put("mode", "favOnly");
			
			List<CommunityDTO> favList = cservice.managementList(favmap);
			mav.addObject("favList", favList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@GetMapping("management_fav")
	public ModelAndView favoritesList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ModelAndView mav = new ModelAndView("community/management_fav");
	    
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
	    try {
	        Map<String, Object> favmap = new HashMap<String, Object>();
	        favmap.put("user_num", info.getMemberIdx());
	        favmap.put("mode", "favOnly");
	        
	        List<CommunityDTO> favList = cservice.managementList(favmap);
	        mav.addObject("favList", favList);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return mav;
	}
	
	@GetMapping("list")
	public ModelAndView communityList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("community/list");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			List<CommunityDTO> popularTopics = cservice.getPopularCategoryList();
			mav.addObject("categoryList", popularTopics);
			
			List<CommunityDTO> list = cservice.communityList(null, null, info.getMemberIdx());
			mav.addObject("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
	    
	    return mav;
	}
	
	@GetMapping("list_search")
	public ModelAndView communityListAjax(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("community/list_search");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
		try {
			String keyword = req.getParameter("keyword");
			String category_id = req.getParameter("category_id");
			
			List<CommunityDTO> list = cservice.communityList(keyword, category_id, info.getMemberIdx());
			
			mav.addObject("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	    
	    return mav;
	}
	
	@ResponseBody
	@PostMapping("checkFavorite")
	public Map<String, Object> checkFavorite(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			String community_id = req.getParameter("community_id");
			map.put("community_id", community_id);
			map.put("user_num", info.getMemberIdx());
			
			String result = cservice.checkFavorite(map);
			map.put("status", result);
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "error");
		}
		
		return map;
	}
	
	@GetMapping("join")
	public ModelAndView joinCommunity(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("redirect:/community/main");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
		String community_id = req.getParameter("community_id");
	    Long user_num = info.getMemberIdx();
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_id", community_id);
			map.put("user_num", user_num);
			cservice.joinCommunity(map);
			
			mav.addObject("community_id", community_id);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			return new ModelAndView("redirect:/list");
		}	    
		return mav;
	}
	
	@GetMapping("leave")
	public ModelAndView leaveCommunity(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("redirect:/community/management");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
		String community_id = req.getParameter("community_id");
	    Long user_num = info.getMemberIdx();
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_id", community_id);
			map.put("user_num", user_num);
			
			cservice.removeFavorite(map);
			cservice.leaveCommunity(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	    
		return mav;
	}
	
}
