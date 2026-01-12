package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.hs.model.MemberDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.RequestMapping;
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
    	Map<String, Object> model = new HashMap<>();
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
}
