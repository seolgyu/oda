package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.service.NotificationService;
import com.hs.service.NotificationServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notification/*")
public class NotificationController {
	private NotificationService notiService = NotificationServiceImpl.getInstance();
	
	@PostMapping("toggleSaved")
    @ResponseBody
    public Map<String, Object> toggleSaved(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long userNum = (Long)info.getMemberIdx();
	        Long postId = Long.parseLong(req.getParameter("postId"));
	        
			
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
	

}
