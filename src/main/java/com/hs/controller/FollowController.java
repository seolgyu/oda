package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.hs.model.MemberDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.service.FollowService;
import com.hs.service.FollowServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/follow/*")
public class FollowController {
	private FollowService service = new FollowServiceImpl();
	private com.hs.service.MemberServiceImpl memberService = new com.hs.service.MemberServiceImpl();
	
	@ResponseBody
	@PostMapping("followApply")
	public Map<String, Object> followApply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> result = new HashMap<>();
		
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    
	    if (info == null) {
	        result.put("status", "fail");
	        return result;
	    }
	    
	    long reqUserNum = info.getMemberIdx();
	    long addUserNum = Long.parseLong(req.getParameter("addUserNum"));
	    Integer count = 0;

		try {
			Map<String, Object> map = new HashMap<>();
			
			map.put("reqId", reqUserNum);
			map.put("addId", addUserNum);
			
			count = service.followCount(map);
			
			MemberDTO dto = memberService.findByIdx(addUserNum);
			
			if(count == null || count == 0) {
	            service.followApply(map);
	            result.put("status", "success");
	            result.put("addUserId", dto.getUserId());
	            result.put("isFollowing", true);
	        } else {
	            service.followDelApply(map);
	            result.put("status", "success");
	            result.put("isFollowing", false);
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "error");
	        result.put("message", "팔로우 요청 중 오류가 발생했습니다.");
		}
	    
	    return result;
	}
}
