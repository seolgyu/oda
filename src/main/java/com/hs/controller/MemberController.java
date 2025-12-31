package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.hs.model.MemberDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.MemberService;
import com.hs.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	private MemberService service = new MemberServiceImpl();
	
	// @RequestMapping(value = "login", method = RequestMethod.GET)
	@GetMapping("login")
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 폼
		return new ModelAndView("member/login");
	}

	// @RequestMapping(value = "login", method = RequestMethod.POST)
	@PostMapping("login")
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 처리
		// 세션객체. 세션 정보는 서버에 저장(로그인 정보, 권한등을 저장)
		HttpSession session = req.getSession();
		
		try {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");

			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("userPwd", userPwd);
			
			MemberDTO dto = service.loginMember(map);
			
			if(dto == null) {
				// 로그인 실패인 경우
				ModelAndView mav = new ModelAndView("member/login");
				
				String msg = "아이디 또는 패스워드가 일치하지 않습니다.";
				mav.addObject("message", msg);

				return mav;
			}
			
			// 로그인 성공 : 로그인정보를 서버에 저장
			// 세션의 유지시간을 20분설정(기본 30분)
			session.setMaxInactiveInterval(20 * 60);

			// 세션에 저장할 내용
			SessionInfo info = new SessionInfo();
			info.setMemberIdx(dto.getMemberIdx());
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			info.setAvatar(dto.getProfile_photo());
			info.setUserLevel(dto.getUserLevel());

			// 세션에 member이라는 이름으로 저장
			session.setAttribute("member", info);

			String preLoginURI = (String)session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");
			if(preLoginURI != null) {
				// 로그인 전페이지로 리다이렉트
				return new ModelAndView(preLoginURI);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 메인 화면으로 리다이렉트
		return new ModelAndView("redirect:/");
	}
	
	@GetMapping("logout")
	public ModelAndView logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그아웃
		HttpSession session = req.getSession();

		// 세션에 저장된 정보를 지운다.
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보를 지우고 세션을 초기화 한다.
		session.invalidate();
		
		return new ModelAndView("redirect:/");
	}
	
	@GetMapping("noAuthorized")
	public ModelAndView noAuthorized(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 권한이 없는 경우
		return new ModelAndView("member/noAuthorized");
	}
	
}
