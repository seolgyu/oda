package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.hs.mail.Mail;
import com.hs.mail.MailSender;
import com.hs.model.MemberDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.MemberService;
import com.hs.service.MemberServiceImpl;
import com.hs.util.MyUtil;

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
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		if (session.getAttribute("member") != null) {
			session.setAttribute("toastMsg", "이미 로그인된 상태입니다.");
	        session.setAttribute("toastType", "info");
	        return new ModelAndView("redirect:/");
	    }
		// 로그인 폼
		return new ModelAndView("member/login");
	}

	// @RequestMapping(value = "login", method = RequestMethod.POST)
	@PostMapping("login")
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
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

			if (dto == null) {
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
			info.setMemberIdx(dto.getUserIdx());
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			info.setUserNickname(dto.getUserNickname());
			info.setUserLevel(dto.getUserLevel());
			info.setAvatar(dto.getProfile_photo());

			// 세션에 member이라는 이름으로 저장
			session.setAttribute("member", info);

			// 로그인 성공 여부
			session.setAttribute("toastMsg", dto.getUserName() + "님, 환영합니다!");
		    session.setAttribute("toastType", "success");

			String preLoginURI = (String) session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");
			if (preLoginURI != null) {
				// 로그인 전페이지로 리다이렉트
				return new ModelAndView(preLoginURI);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		// 메인 화면으로 리다이렉트
		return new ModelAndView("redirect:/");
	}
	
	@PostMapping("login_json")
	@ResponseBody
	public Map<String, Object> loginAjax(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		Map<String, Object> model = new HashMap<>();

		try {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");

			Map<String, Object> map = new HashMap<>();
			
			map.put("userId", userId);
			map.put("userPwd", userPwd);

			MemberDTO dto = service.loginMember(map);

			if (dto == null) {
				model.put("status", "fail");
		        model.put("message", "아이디 또는 비밀번호가 틀렸습니다.");

				return model;
			}

			HttpSession session = req.getSession();
			session.setMaxInactiveInterval(20 * 60);

			SessionInfo info = new SessionInfo();
			info.setMemberIdx(dto.getUserIdx());
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			info.setUserNickname(dto.getUserNickname());
			info.setUserLevel(dto.getUserLevel());
			info.setAvatar(dto.getProfile_photo());

			session.setAttribute("member", info);

			session.setAttribute("toastMsg", dto.getUserName() + "님, 환영합니다!");
		    session.setAttribute("toastType", "success");
		    
		    model.put("status", "success");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
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
	public ModelAndView noAuthorized(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		return new ModelAndView("member/noAuthorized");
	}

	@GetMapping("signup")
	public ModelAndView signupForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		 
		session.removeAttribute("isVerified");
	    session.removeAttribute("targetEmail");
	    session.removeAttribute("authCode");
	    session.removeAttribute("authCodeTime");
	    
		return new ModelAndView("member/signup");
	}

	@PostMapping("signup")
	public ModelAndView signupSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// 한글 깨짐 방지 (필터 설정이 안 되어 있을 경우 대비)
		req.setCharacterEncoding("UTF-8");

		try {
			// [1] 사용자 입력값 모두 받기 (signup.jsp의 input name과 일치해야 함)
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			String userName = req.getParameter("userName");
			String userNickname = req.getParameter("userNickname");
			String birth = req.getParameter("birth");
			String email = req.getParameter("email");
			String addr1 = req.getParameter("addr1");
			String addr2 = req.getParameter("addr2");
			String tel = req.getParameter("tel");
			String zip = req.getParameter("zip");

			// [2] DTO에 모든 데이터 담기
			MemberDTO dto = new MemberDTO();
			dto.setUserId(userId);
			dto.setUserPwd(userPwd);
			dto.setUserName(userName);
			dto.setUserNickname(userNickname);
			dto.setBirth(birth);
			dto.setEmail(email);
			dto.setAddr1(addr1);
			dto.setAddr2(addr2);
			dto.setTel(tel);
			dto.setZip(zip);

			// [3] 서비스 호출 (이미 존재하는 insertMember 활용)
			// 서비스 내부에서 member1(기본)과 member2(상세) 테이블에 각각 저장될 것입니다.
			service.insertMember(dto);

			// [4] 성공 시 로그인 페이지로 이동하며 메시지 전달
			ModelAndView mav = new ModelAndView("member/login");
			mav.addObject("message", "회원가입이 완료되었습니다. 로그인 해주세요.");

			return mav;

		} catch (Exception e) {
			e.printStackTrace();

			// [5] 실패 시 다시 가입 폼으로 돌아감
			ModelAndView mav = new ModelAndView("member/signup");
			mav.addObject("message", "회원가입 실패. 입력한 정보를 다시 확인해주세요.");
			return mav;
		}
	}
	
	@PostMapping("signupAjax")
	@ResponseBody
	public Map<String, Object> signupSubmitAjax(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		Map<String, Object> map = new HashMap<>();

		req.setCharacterEncoding("UTF-8");

		try {
			Boolean isVerified = (Boolean) session.getAttribute("isVerified");
	        String verifiedEmail = (String) session.getAttribute("verifiedEmail");

	        if (isVerified == null || !isVerified || verifiedEmail == null) {
	            map.put("status", "emailFail");
	            map.put("message", "이메일 인증이 되지 않았거나, 인증이 만료되었습니다.");
	            return map;
	        }
	        
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			String userName = req.getParameter("userName");
			String userNickname = req.getParameter("userNickname");
			String birth = req.getParameter("birth");
			String addr1 = req.getParameter("addr1");
			String addr2 = req.getParameter("addr2");
			String tel = req.getParameter("tel");
			String zip = req.getParameter("zip");

			MemberDTO dto = new MemberDTO();
			dto.setUserId(userId);
			dto.setUserPwd(userPwd);
			dto.setUserName(userName);
			dto.setUserNickname(userNickname);
			dto.setBirth(birth);
			dto.setEmail(verifiedEmail);
			dto.setAddr1(addr1);
			dto.setAddr2(addr2);
			dto.setTel(tel);
			dto.setZip(zip);

			service.insertMember(dto);
			
			session.removeAttribute("isVerified");
			session.removeAttribute("verifiedEmail");
			session.removeAttribute("targetEmail");
			
			map.put("status", "success");
	        map.put("message", "회원가입이 완료되었습니다.");

		} catch (Exception e) {
	        e.printStackTrace();
	        map.put("status", "fail");
	        map.put("message", "가입 도중 오류가 발생했습니다: " + e.getMessage());
	    }
		
		return map;
	}
	
	@PostMapping("checkDuplicate")
	@ResponseBody
	public Map<String, Object> checkDuplicate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> map = new HashMap<>();
	    
	    req.setCharacterEncoding("UTF-8");

		try {
			String userId = req.getParameter("userId");
	        String userNickname = req.getParameter("userNickname");
	        			
			if (userId != null && !userId.trim().isEmpty()) {
				if (service.checkId(userId.trim()) > 0) {
					map.put("status", "failId");
					map.put("message", "이미 등록된 아이디입니다.");
					return map;
				}
			}
		    
		    if (userNickname != null && !userNickname.trim().isEmpty()) {
	            if (service.checkNickname(userNickname.trim()) > 0) {
	                map.put("status", "failNickname");
	                map.put("message", "이미 사용 중인 닉네임입니다.");
	                return map;
	            }
	        }
		    
		    map.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "error");
			map.put("message", "서버 내부 오류가 발생했습니다.");
		}
	    
	    return map;
	}
	
	@PostMapping("sendAuthEmail")
	@ResponseBody
	public Map<String, Object> sendAuthEmail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    req.setCharacterEncoding("UTF-8");

		try {
	        String email = req.getParameter("email");
	        System.out.println(">>> 수신 이메일: " + email);

	        String subject = "[ODA Community] 회원가입 본인확인 인증번호입니다.";
	        String authCode = MyUtil.generateAuthCode();
	        String content = "<div style='font-family: \"Apple SD Gothic Neo\", \"Malgun Gothic\", sans-serif; max-width: 500px; margin: 20px auto; padding: 40px; border: 1px solid #ebebeb; border-radius: 20px; text-align: center; color: #333;'>"
	                + "  <h2 style='font-size: 24px; margin-bottom: 20px; color: #000;'>본인 확인 인증번호</h2>"
	                + "  <p style='font-size: 15px; line-height: 1.6; color: #666; margin-bottom: 30px;'>"
	                + "    안녕하세요.<br>요청하신 본인 확인을 위한 인증번호를 보내드립니다.<br>"
	                + "    아래의 6자리 번호를 인증창에 입력해 주세요."
	                + "  </p>"
	                + "  <div style='background-color: #f8f9fa; border-radius: 12px; padding: 25px; margin-bottom: 30px; border: 1px solid #e9ecef;'>"
	                + "    <span style='font-size: 32px; font-weight: bold; color: #007bff; letter-spacing: 8px;'>" + authCode + "</span>"
	                + "  </div>"
	                + "  <p style='font-size: 13px; color: #999;'>"
	                + "    ※ 인증번호의 유효 시간은 <b>3분</b>입니다.<br>"
	                + "    시간이 만료되었다면 다시 요청해 주세요."
	                + "  </p>"
	                + "  <hr style='border: 0; border-top: 1px solid #eee; margin: 30px 0;'>"
	                + "  <p style='font-size: 12px; color: #bbb;'>본 메일은 발신 전용입니다. 문의 사항은 고객센터를 이용해 주세요.</p>"
	                + "</div>";
	        
	        
	        Mail dto = new Mail();
			
			dto.setSenderName("ODA");
			dto.setSenderEmail("kimchowon417@gmail.com");
			dto.setReceiverEmail(email);
			dto.setSubject(subject);
			dto.setContent(content);
					
			MailSender sender = new MailSender();
			boolean b = sender.mailSend(dto);
			System.out.println(">>> 메일 발송 결과: " + b);
			
			
			if(! b) {
				model.put("status", "emailSendError");
				return model;
			}
			
			session.setAttribute("isVerified", false);
			session.setAttribute("targetEmail", email);
			session.setAttribute("authCode", authCode);
			session.setAttribute("authCodeTime", System.currentTimeMillis());
	        
		    model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
	    
	    return model;
	}
	
	@PostMapping("chkAuthEmail")
	@ResponseBody
	public Map<String, Object> chkAuthEmail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    req.setCharacterEncoding("UTF-8");

		try {
			String userCode = req.getParameter("userCode");
			String currentEmail = req.getParameter("email");
			
	        String authCode = (String)session.getAttribute("authCode");
	        Long authCodeTime = (Long) session.getAttribute("authCodeTime");
	        String targetEmail = (String)session.getAttribute("targetEmail");
	        
	        if (authCode == null || authCodeTime == null || targetEmail == null) {
	            model.put("status", "expired");
	            return model;
	        }
	        
	        if(!targetEmail.equals(currentEmail)) {
	        	model.put("status", "invalidEmail");
	        	return model;
	        }
	        
	        long currentTime = System.currentTimeMillis();
	        if (currentTime - authCodeTime > 3 * 60 * 1000) { // 3분
	            session.removeAttribute("authCode");
	            session.removeAttribute("authCodeTime");
	            session.removeAttribute("targetEmail");
	            model.put("status", "timeout");
	            return model;
	        }

	        if (!authCode.equals(userCode)) {
	            model.put("status", "fail");
	            return model;
	        }
	        
	        session.setAttribute("isVerified", true);
	        session.setAttribute("verifiedEmail", targetEmail);
	        
	        session.removeAttribute("authCode");
	        session.removeAttribute("authCodeTime");
	        
		    model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
	    
	    return model;
	}

	@GetMapping("page")
	public ModelAndView page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    String userId = req.getParameter("id");
	    
	    if (userId == null || userId.trim().isEmpty()) {
	        return new ModelAndView("redirect:/");
	    }

	    try {
	        MemberDTO dto = service.findById(userId);

	        if (dto == null) {
	            return new ModelAndView("redirect:/");
	            // return new ModelAndView("redirect:/member/noAuthorized");
	        }

	        ModelAndView mav = new ModelAndView("member/page"); // userPage.jsp로 이동
	        mav.addObject("user", dto);
	        return mav;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ModelAndView("redirect:/");
	    }
	}
	
	@GetMapping("findId")
	public ModelAndView findIdForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		return new ModelAndView("member/findId");
	}
	
	@PostMapping("findIdAjax")
	@ResponseBody
	public Map<String, Object> findIdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> model = new HashMap<>();
	    
	    req.setCharacterEncoding("UTF-8");

		try {
			Map<String, Object> map = new HashMap<>();
			
			String userName = req.getParameter("userName");
	        String email = req.getParameter("email");
	        
	        map.put("userName", userName);
	        map.put("email", email);
	        
	        String userId = service.findId(map);
	        
	        if(userId == null) {
	        	model.put("status", "fail");
				return model;
	        }
		    
		    model.put("status", "success");
		    model.put("userId", userId);
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
	    
	    return model;
	}
	
	@GetMapping("findPwd")
	public ModelAndView findPwdForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		 
		session.removeAttribute("isVerified");
	    session.removeAttribute("resetUserNum");
	    session.removeAttribute("targetEmail");
	    session.removeAttribute("authCode");
	    session.removeAttribute("authCodeTime");
	    
		return new ModelAndView("member/findPwd");
	}
	
	@PostMapping("findPwdAjax")
	@ResponseBody
	public Map<String, Object> findPwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    req.setCharacterEncoding("UTF-8");

		try {
			Map<String, Object> map = new HashMap<>();
			
			String userId = req.getParameter("userId");
			String userName = req.getParameter("userName");
	        String email = req.getParameter("email");
	        
	        map.put("userId", userId);
	        map.put("userName", userName);
	        map.put("email", email);
	        
	        Long resetUserNum = service.findUserNum(map);
	        	        
	        if(resetUserNum == null) {
	        	model.put("status", "fail");
				return model;
	        }
		    
	        // 메일 전송 로직
	        String subject = "[ODA Community] 비밀번호 찾기 인증번호 안내";
	        String authCode = MyUtil.generateAuthCode();
	        String content = "<div style='font-family: \"Apple SD Gothic Neo\", \"Malgun Gothic\", sans-serif; max-width: 500px; margin: 20px auto; padding: 40px; border: 1px solid #ebebeb; border-radius: 20px; text-align: center; color: #333;'>"
	                + "  <h2 style='font-size: 24px; margin-bottom: 20px; color: #000;'>본인 확인 인증번호</h2>"
	                + "  <p style='font-size: 15px; line-height: 1.6; color: #666; margin-bottom: 30px;'>"
	                + "    안녕하세요.<br>요청하신 본인 확인을 위한 인증번호를 보내드립니다.<br>"
	                + "    아래의 6자리 번호를 인증창에 입력해 주세요."
	                + "  </p>"
	                + "  <div style='background-color: #f8f9fa; border-radius: 12px; padding: 25px; margin-bottom: 30px; border: 1px solid #e9ecef;'>"
	                + "    <span style='font-size: 32px; font-weight: bold; color: #007bff; letter-spacing: 8px;'>" + authCode + "</span>"
	                + "  </div>"
	                + "  <p style='font-size: 13px; color: #999;'>"
	                + "    ※ 인증번호의 유효 시간은 <b>3분</b>입니다.<br>"
	                + "    시간이 만료되었다면 다시 요청해 주세요."
	                + "  </p>"
	                + "  <hr style='border: 0; border-top: 1px solid #eee; margin: 30px 0;'>"
	                + "  <p style='font-size: 12px; color: #bbb;'>본 메일은 발신 전용입니다. 문의 사항은 고객센터를 이용해 주세요.</p>"
	                + "</div>";
	        
	        
	        Mail dto = new Mail();
			
			dto.setSenderName("ODA");
			dto.setSenderEmail("kimchowon417@gmail.com");
			dto.setReceiverEmail(email);
			dto.setSubject(subject);
			dto.setContent(content);
					
			MailSender sender = new MailSender();
			boolean b = sender.mailSend(dto);
			
			
			if(! b) {
				model.put("status", "emailSendError");
				return model;
			}
			
			session.setAttribute("isVerified", false);
			session.setAttribute("resetUserNum", resetUserNum);
			session.setAttribute("targetEmail", email);
			session.setAttribute("authCode", authCode);
			session.setAttribute("authCodeTime", System.currentTimeMillis());
	        
		    model.put("status", "exist");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
	    
	    return model;
	}
	
	@PostMapping("chkAuthCode")
	@ResponseBody
	public Map<String, Object> chkAuthCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    req.setCharacterEncoding("UTF-8");

		try {
			String userCode = req.getParameter("userCode");
	        String authCode = (String)session.getAttribute("authCode");
	        Long authCodeTime = (Long) session.getAttribute("authCodeTime");
	        
	        if (authCode == null || authCodeTime == null || session.getAttribute("resetUserNum") == null) {
	            model.put("status", "expired");
	            return model;
	        }
	        
	        long currentTime = System.currentTimeMillis();
	        if (currentTime - authCodeTime > 3 * 60 * 1000) { // 3분
	            session.removeAttribute("authCode");
	            session.removeAttribute("authCodeTime");
	            model.put("status", "timeout");
	            return model;
	        }

	        if (!userCode.equals(authCode)) {
	            model.put("status", "fail");
	            return model;
	        }
	        
	        session.setAttribute("isVerified", true);
	        
	        session.removeAttribute("authCode");
	        session.removeAttribute("authCodeTime");
	        
		    model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
	    
	    return model;
	}
	
	@GetMapping("changePwd")
	public ModelAndView changePwdForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		Boolean isVerified = (Boolean) session.getAttribute("isVerified");
		Long resetUserNum = (Long) session.getAttribute("resetUserNum");

	    if (isVerified == null || !isVerified || resetUserNum == null) {
	        return new ModelAndView("redirect:/member/login");
	    }
		return new ModelAndView("member/changePwd");
	}
	
	@PostMapping("changePwdSubmit")
	@ResponseBody
	public Map<String, Object> changePwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    req.setCharacterEncoding("UTF-8");

		try {
			Boolean isVerified = (Boolean) session.getAttribute("isVerified");
			Long resetUserNum = (Long) session.getAttribute("resetUserNum");
			String userPwd = req.getParameter("userPwd");
	        
	        if (resetUserNum == null || isVerified == null || !isVerified) {
	            model.put("status", "expired");
	            return model;
	        }
	        
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("userNum", resetUserNum);
	        map.put("userPwd", userPwd);
	        
	        service.updatePwd(map);
	        
	        session.removeAttribute("resetUserNum");
	        session.removeAttribute("isVerified");
	        session.removeAttribute("targetEmail");

		    model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
	    
	    return model;
	}
	
	@GetMapping("settings")
	public ModelAndView settings(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		return new ModelAndView("member/settings");
	}

}
