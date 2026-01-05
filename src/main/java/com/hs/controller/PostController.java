package com.hs.controller;

import java.io.IOException;
import java.util.List;

import com.hs.model.PostDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.PostService;
import com.hs.service.PostServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/post/*")
public class PostController {
	
	// Spring이 아니므로 직접 객체 생성
	private PostService service = new PostServiceImpl();

	// 1. 글쓰기 폼 (GET)
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 체크
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		ModelAndView mav = new ModelAndView("post/write");
		mav.addObject("mode", "write");
		return mav;
	}

	// 2. 글 등록 처리 (POST)
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			// [1] 요청 파라미터 받기
			PostDTO dto = new PostDTO();
			
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			// [수정] 공지사항 체크박스 처리
			// 체크되어 있으면 "NOTICE", 아니면 "COMMUNITY"로 postType 설정
			String isNotice = req.getParameter("isNotice");
			if(isNotice != null) {
				dto.setPostType("NOTICE");
			} else {
				dto.setPostType("COMMUNITY");
			}
			
			// [수정] 작성자 PK 설정 (authorId -> userNum)
			dto.setUserNum(info.getMemberIdx()); 
			
			// [수정] 게시글 상태 설정 (DB 기본값이 있지만 명시적으로 세팅)
			dto.setState("정상");

			// [2] 서비스 호출
			service.insertPost(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/post/list");
	}

	// 3. 수정 폼 (GET)
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			long postId = Long.parseLong(req.getParameter("postId"));
			
			// 게시글 가져오기
			PostDTO dto = service.findById(postId);
			
			// [수정] 작성자 확인 (authorId -> userNum)
			if(dto == null || dto.getUserNum() != info.getMemberIdx()) {
				return new ModelAndView("redirect:/post/list");
			}
			
			ModelAndView mav = new ModelAndView("post/write");
			mav.addObject("dto", dto);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/post/list");
	}

	// 4. 수정 처리 (POST)
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			PostDTO dto = new PostDTO();
			
			// 파라미터 수동 매핑
			dto.setPostId(Long.parseLong(req.getParameter("postId")));
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			// [수정] 공지사항 여부에 따라 타입 변경
			String isNotice = req.getParameter("isNotice");
			if(isNotice != null) {
				dto.setPostType("NOTICE");
			} else {
				dto.setPostType("COMMUNITY");
			}
			
			// [수정] 상태 유지
			dto.setState("정상");
			
			// [수정] 본인 확인용 (authorId -> userNum)
			dto.setUserNum(info.getMemberIdx());
			
			service.updatePost(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/post/list");
	}
	
	// 5. 게시글 리스트
		@GetMapping("list")
		public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			ModelAndView mav = new ModelAndView("post/list");
			
			// DB에서 목록 가져오기
			List<PostDTO> list = service.listPost();
			
			// JSP로 데이터 전달
			mav.addObject("list", list);
			
			return mav;
		}
}