package com.hs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.NotificationDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
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
	
	@GetMapping("")
	public ModelAndView notiMain(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	ModelAndView mav = new ModelAndView("/notification/notiMain");

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			Map<String, Object> model = new HashMap<String, Object>();
			
			if (info == null) {
				mav.addObject("status", "error");
				return mav;
	        }
			
			Long userNum = (Long)info.getMemberIdx();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userNum", userNum);
			map.put("offset", 0);
	        map.put("size", 10);
			
			List<NotificationDTO> list = notiService.listAllNotification(map);
			
			mav.addObject("list", list);
	        mav.addObject("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("status", "error");
		}
		
		return mav;
	}
	
	@PostMapping("loadNotiCount")
    @ResponseBody
    public Map<String, Object> loadNotiCount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long userNum = (Long)info.getMemberIdx();
	        int count = notiService.getUncheckedCount(userNum);
			
	        model.put("count", count);
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
	
	@PostMapping("loadNotiList")
    @ResponseBody
    public Map<String, Object> loadNotiList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long userNum = (Long)info.getMemberIdx();
			
			List<NotificationDTO> list = notiService.listNotification(userNum);
			
	        model.put("list", list);
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
	
	@PostMapping("loadAllNotiList")
    @ResponseBody
    public Map<String, Object> loadAllNotiList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

    	try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
				return model;
	        }
			
			Long userNum = (Long)info.getMemberIdx();
			int pageNo = Integer.parseInt(req.getParameter("page"));	
	    	
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("offset", (pageNo - 1) * 10);
	        map.put("size", 10);
			
			List<NotificationDTO> list = notiService.listAllNotification(map);
			
			model.put("list", list);
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
	
	@PostMapping("readNoti")
    @ResponseBody
    public Map<String, Object> readNoti(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();

		try {
			Long notiId = Long.parseLong(req.getParameter("notiId"));
			
			notiService.updateChecked(notiId);
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
	
	@PostMapping("readNotiAll")
    @ResponseBody
    public Map<String, Object> readNotiAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long userNum = (Long)info.getMemberIdx();
			
			notiService.updateCheckedAll(userNum);
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
	
	@PostMapping("deleteNoti")
    @ResponseBody
    public Map<String, Object> deleteNoti(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long notiId = Long.parseLong(req.getParameter("notiId"));
			notiService.deleteNotification(notiId);
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
	
	

}
