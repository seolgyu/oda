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
import com.hs.mvc.view.ModelAndView;
import com.hs.service.MemberService;
import com.hs.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/settings")
public class SettingController {
	private MemberService service = new MemberServiceImpl();
	
	@RequestMapping("")
	public ModelAndView settings(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		
		
	    return new ModelAndView("member/settings");
	}

    @RequestMapping("profile")
    public String settingsProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_profile";
    }

    @RequestMapping("account")
    public String settingsAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
	            return "redirect:/member/login"; 
	        }
			
			Long userNum = info.getMemberIdx();

			MemberDTO dto = service.findByIdx(userNum);

			req.setAttribute("user", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "member/setting/settings_account";
    }
    
    @RequestMapping("like")
    public String settingsLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_like";
    }
    
    @RequestMapping("saved")
    public String settingsSaved(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_saved";
    }
    
    @RequestMapping("follow")
    public String settingsFollow(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_follow";
    }
    
    @RequestMapping("comments")
    public String settingsComments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_comments";
    }

    @RequestMapping("pwdChange")
    public String settingsPwdChange(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_pwdChange";
    }

    @RequestMapping("privacyScope")
    public String settingsPrivacyScope(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_privacyScope";
    }
    
    @PostMapping("updateAccount")
    @ResponseBody
    public Map<String, Object> updateAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
	        String userNickname = req.getParameter("userNickname");
	        String userName = req.getParameter("userName");
	        
	        if (userNickname != null && !userNickname.equals(info.getUserNickname())) {
	            if (service.checkNickname(userNickname.trim()) > 0) {
	                model.put("status", "duplicate");
	                return model;
	            }
	        }
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userNum", info.getMemberIdx());
			map.put("userName", userName);
			map.put("userNickname", userNickname);
			map.put("birth", req.getParameter("birth"));
			map.put("tel", req.getParameter("tel"));
			map.put("zip", req.getParameter("zip"));
			map.put("addr1", req.getParameter("addr1"));
			map.put("addr2", req.getParameter("addr2"));

			service.updateMember(map);
			
			info.setUserName(userName);
	        info.setUserNickname(userNickname);
	        session.setAttribute("member", info);
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
    
    @PostMapping("updatePwd")
    @ResponseBody
    public Map<String, Object> updatePwd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long userNum = info.getMemberIdx();
			MemberDTO dto = service.findByIdx(userNum);
			
			String currentPwd = req.getParameter("currentPwd");
			String newPwd = req.getParameter("newPwd");
	        
			if (currentPwd == null || newPwd == null || newPwd.trim().isEmpty()) {
	            model.put("status", "error");
	            return model;
	        }
			
			System.out.println("현재 비밀번호 : " + currentPwd);
			System.out.println("가져온 비밀번호 : " + dto.getUserPwd());
	        
	        if (!currentPwd.equals(dto.getUserPwd())) {
	        	model.put("status", "fail");
                return model;
	        }
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userNum", info.getMemberIdx());
			map.put("userPwd", newPwd);

			service.updatePwd(map);
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
}
