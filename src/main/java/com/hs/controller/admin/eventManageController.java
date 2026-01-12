package com.hs.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.SessionInfo;
import com.hs.model.admin.EventDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;

import com.hs.mvc.annotation.RequestMapping;

import com.hs.mvc.view.ModelAndView;


import com.hs.service.admin.EventService;
import com.hs.service.admin.EventServiceImpl;
import com.hs.util.FileManager;
import com.hs.util.MyMultipartFile;
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
			
			articleUrl = cp + "/admin/events/article?page=" + current_page + "&" + query;

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
		
		String size = req.getParameter("size");
		
		mav.addObject("mode", "write");
		mav.addObject("size", size);
		
		return mav;
	}
	
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글저장
		// 파리미터 : 제목, 내용, 파일
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "events";
		
		String size = req.getParameter("size");
		
		try {
			EventDTO dto = new EventDTO();
			
			dto.setUser_num(info.getMemberIdx());
			if(req.getParameter("events") != null) {
				dto.setEvents(Integer.parseInt(req.getParameter("events")));
			}
			if(req.getParameter("showEvents") != null) {
				dto.setShowEvent(Integer.parseInt(req.getParameter("showEvents")));
			}
			dto.setEvent_title(req.getParameter("event_title"));
			dto.setEvent_content(req.getParameter("event_content"));
			
			List<MyMultipartFile> listFile = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(listFile);
			
			service.insertEvent(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/admin/events/list?size=" + size);
	}
	
	@GetMapping("article")
	public ModelAndView eventarticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글보기
		// 넘어오는 파라미터 : 글번호, 페이지번호, size[검색컬럼, 검색값]
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;
		
		try {
			long event_num = Long.parseLong(req.getParameter("event_num"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			// 조회수
			service.updateHitCount(event_num);
			
			// 게시물 가져오기
			EventDTO dto = service.findById(event_num);
			if(dto == null) {
				return new ModelAndView("redirect:/admin/events/article?" + query);
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("update_date", dto.getUpdate_date());
			
			// 이전, 다음 
			EventDTO prevDto = service.findByPrev(map);
			EventDTO nextDto = service.findByNext(map);
			
			// 파일
			List<EventDTO> filelist = service.listEventFile(event_num);
			
			ModelAndView mav1 = new ModelAndView("admin/events/article");
					
			mav1.addObject("dto", dto);
			mav1.addObject("prevDto", prevDto);
			mav1.addObject("nextDto", nextDto);
			mav1.addObject("filelist", filelist);
			mav1.addObject("query", query);
			mav1.addObject("schType", schType);
			mav1.addObject("kwd", kwd);
			
			return mav1;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/admin/events/list?" + query);
	}
}