package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.PostDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.PostService;
import com.hs.service.PostServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	private PostService postService = new PostServiceImpl();

	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("home/main");
		
		// 1. 기존 파라미터 받기 (sort, view 등)
	    String sort = req.getParameter("sort");
	    if (sort == null || sort.isEmpty()) sort = "latest";
	    
	    String view = req.getParameter("view");
	    if (view == null || view.isEmpty()) view = "card";
		
		String keyword = req.getParameter("keyword");
	    if (keyword == null) keyword = ""; 

		// PostController와 동일하게 카드형은 10개, 축약형은 15개로 설정
		int size = "compact".equals(view) ? 15 : 10;
		int offset = 0; // 첫 페이지이므로 0부터 시작
		
		// 2. 서비스에 전달할 맵 생성
		Map<String, Object> map = new HashMap<>();
		map.put("sort", sort);
		map.put("offset", offset);
		map.put("size", size);   
		map.put("keyword", keyword);
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info != null) {
			map.put("userNum", info.getMemberIdx());
		} else {
			map.put("userNum", 0); 
		}
		
		// 3. 게시글 리스트 가져오기
		List<PostDTO> list = postService.listPostMain(map);
		
		// 4. JSP로 데이터 전달
		mav.addObject("list", list);         
		mav.addObject("sort", sort);         
		mav.addObject("viewMode", view);     
		mav.addObject("keyword", keyword);
		
		return mav;
	}
}