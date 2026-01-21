package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.FollowDTO;
import com.hs.model.MemberDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.service.FollowService;
import com.hs.service.FollowServiceImpl;
import com.hs.service.NotificationService;
import com.hs.service.NotificationServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/follow/*")
public class FollowController {
	private FollowService service = new FollowServiceImpl();
	private com.hs.service.MemberServiceImpl memberService = new com.hs.service.MemberServiceImpl();
	private NotificationService notiService = NotificationServiceImpl.getInstance();
	private FollowService followService = new FollowServiceImpl();
	
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
	    
	    if (reqUserNum == addUserNum) {
	        result.put("status", "self_follow");
	        return result;
	    }
	    
	    Integer count = 0;

		try {
			Map<String, Object> map = new HashMap<>();
			
			map.put("reqId", reqUserNum);
			map.put("addId", addUserNum);
			
			count = service.followCount(map);
			
			MemberDTO reqDto = memberService.findByIdx(reqUserNum);
			MemberDTO addDto = memberService.findByIdx(addUserNum);
			
			if(count == null || count == 0) {
	            service.followApply(map);
	            
	            Map<String, Object> noti = new HashMap<String, Object>();
				noti.put("fromUserNum", reqUserNum);
				noti.put("toUserNum", addUserNum);
				noti.put("type", "FOLLOW");
				noti.put("target", reqDto.getUserId());
				
				notiService.insertNotification(noti);
	            
	            result.put("status", "success");
	            result.put("addUserId", addDto.getUserId());
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
	
	@PostMapping("getFollowCount")
    @ResponseBody
    public Map<String, Object> getFollowCount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	Map<String, Object> model = new HashMap<String, Object>();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	if (info == null) {
	    		model.put("status", "error");
	    		return model;
	    	}
	    	String userId = req.getParameter("userId");
	    	MemberDTO dto = memberService.findById(userId);
	    	Long userNum = dto.getUserIdx();
	    	
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        
	        model.put("followerCount", followService.followerCount(userNum));
	        model.put("followingCount", followService.followingCount(userNum));
	        model.put("status", "success");
    	} catch(Exception e) {
    		e.printStackTrace();
    		model.put("status", "error");
    	}
    	
        return model;
    }
	
	@PostMapping("getFollowList")
    @ResponseBody
    public Map<String, Object> getFollowList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	Map<String, Object> model = new HashMap<String, Object>();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	if (info == null) {
	    		model.put("status", "error");
	    		return model;
	    	}
	    	String userId = req.getParameter("userId");
	    	String type = req.getParameter("type");
	    	MemberDTO dto = memberService.findById(userId);
	    	Long userNum = dto.getUserIdx();
	    	
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("mode", "modal");
	        map.put("type", type);
	        
	        List<FollowDTO> list = followService.getUserFollowList(map);
	        
	        model.put("list", list);
	        model.put("status", "success");
    	} catch(Exception e) {
    		e.printStackTrace();
    		model.put("status", "error");
    	}
    	
        return model;
    }
}
