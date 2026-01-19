package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.mail.Mail;
import com.hs.mail.MailSender;
import com.hs.model.FollowDTO;
import com.hs.model.MemberDTO;
import com.hs.model.PostDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.FollowService;
import com.hs.service.FollowServiceImpl;
import com.hs.service.PostService;
import com.hs.service.PostServiceImpl;
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/follow/*")
public class FollowController {
	private FollowService service = new FollowServiceImpl();
	
	@ResponseBody
	@PostMapping("followApply")
	public Map<String, Object> followApply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> result = new HashMap<>();
		
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    
	    long addId = Long.parseLong(req.getParameter("addUserNum"));
	    Integer count = 0;

		try {
			Map<String, Object> map = new HashMap<>();
			
			map.put("reqId", info.getMemberIdx());
			map.put("addId", addId);
			
			count = service.followCount(map);
			
			if(count == null || count == 0) {
	            // 팔로우 기록이 없을 경우 팔로우 신청
	            service.followApply(map);
	            result.put("state", "true");
	            result.put("message", "팔로우 요청이 완료되었습니다.");
	        } else {
	            // 팔로우 기록이 있을 경우 팔로우 취소
	            service.followDelApply(map);
	            result.put("state", "true");
	            result.put("message", "팔로우가 취소되었습니다.");
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("state", "false");
	        result.put("message", "팔로우 요청 중 오류가 발생했습니다.");
		}
	    
	    return result;
	}
}
