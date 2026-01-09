package com.hs.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.hs.model.admin.EventDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;

import com.hs.mvc.annotation.RequestMapping;

import com.hs.mvc.view.ModelAndView;


import com.hs.service.admin.EventService;
import com.hs.service.admin.EventServiceImpl;
import com.hs.util.FileManager;
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/events/*")
public class eventManageController {
	private EventService service = new EventServiceImpl();
	private MyUtil util = new MyUtil();
	private FileManager fileManager = new FileManager();
	
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이벤트 리스트
		// 넘어오는 파라미터 : [글번호, 페이지번호[검색컬럼, 검색값]]
		ModelAndView mav = new ModelAndView("admin/events/list");
		
		try {
			
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			// 한페이지 표시
			String pageSize = req.getParameter("size");
			int size = pageSize == null ? 10 : Integer.parseInt(pageSize);
					
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			int dataCount = service.dataCount(map);
			int total_page = util.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			
			map.put("offset", offset);
			map.put("size", size);
			
			// 공지글
			List<EventDTO> list = service.listEvent(map);
			
			// 공지글 top
			List<EventDTO> listTop = null;
			if(current_page == 1) {
				listTop = service.listEventTop();
			}
			
			String cp = req.getContextPath();
			String query = "size=" + size;
			String listUrl;
			String articleUrl;
			
			if (! kwd.isBlank()) {  // if(kwd.length() != 0) { // 검색 상태인 경우
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			listUrl = cp + "/admin/event/list?" + query;
			articleUrl = cp + "/admin/event/article?page=" + current_page + "&" + query;

			String paging = util.paging(current_page, total_page, listUrl);

			// 포워딩할 데이터
			mav.addObject("list", list);
			mav.addObject("listTop", listTop);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
						
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/events/write");
		return mav;
	}
	
	@GetMapping("article")
	public ModelAndView eventarticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/events/article");
		return mav;
	}
}