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
		
		// 1. 요청 파라미터 받기 (정렬 기준, 보기 모드)
		// 값이 없으면 기본값(latest, card)을 사용합니다.
		String sort = req.getParameter("sort");
		if (sort == null || sort.isEmpty()) {
			sort = "latest"; // 최신순
		}
		
		String view = req.getParameter("view");
		if (view == null || view.isEmpty()) {
			view = "card"; // 카드형
		}
		
		// 2. 서비스에 전달할 맵 생성
		Map<String, Object> map = new HashMap<>();
		map.put("sort", sort);
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info != null) {
			map.put("userNum", info.getMemberIdx());
		} else {
			map.put("userNum", 0); // 비로그인 시 0
		}
		
		// 3. 게시글 리스트 가져오기 (Step 1에서 만든 메서드 호출)
		// listPostMain 메서드가 PostService에 정의되어 있어야 합니다.
		List<PostDTO> list = postService.listPostMain(map);
		
		// 4. JSP로 데이터 전달
		mav.addObject("list", list);         // 게시글 리스트
		mav.addObject("sort", sort);         // 현재 정렬 상태 (버튼 활성화용)
		mav.addObject("viewMode", view);     // 현재 보기 모드 (UI 전환용)
		
		return mav;
	}
}