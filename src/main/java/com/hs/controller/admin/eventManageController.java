package com.hs.controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.SessionInfo;
import com.hs.model.admin.EventDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
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
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			

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
			listUrl = cp + "/admin/events/list?" + query;
			
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
	
	@PostMapping("write")
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
			if(req.getParameter("showEvent") != null) {
				dto.setShowEvent(Integer.parseInt(req.getParameter("showEvent")));
			}

			dto.setEvent_title(req.getParameter("event_title"));
			dto.setEvent_content(req.getParameter("event_content"));
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			
			
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
			String active_status = req.getParameter("active_status");
			if(schType == null) {
				schType = "all";
				kwd = "";
			} else if (active_status == null) {
				active_status = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			if(active_status != null) {
				query += "&active_status=" + util.encodeUrl(active_status);
			}
			
			// 조회수
			service.updateHitCount(event_num);
			
			// 게시물 가져오기
			EventDTO dto = service.findById(event_num);
			if(dto == null) {
				return new ModelAndView("redirect:/admin/events/list?" + query);
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("active_status", "active_status");
			map.put("update_date", dto.getUpdate_date());
				
			// 이전, 다음 
			EventDTO prevDto = service.findByPrev(map);
			EventDTO nextDto = service.findByNext(map);
			
			
			// 파일
			List<EventDTO> filelist = service.listEventFile(event_num);
			
			ModelAndView mav = new ModelAndView("admin/events/article");
					
			mav.addObject("dto", dto);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			mav.addObject("filelist", filelist);
			mav.addObject("query", query);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/events/list?" + query);
	}
	
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정폼
		// 넘어온 파라미터 : 글번호, 페이지번호, size
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		try {
			long event_num = Long.parseLong(req.getParameter("event_num"));
			
			EventDTO dto = service.findById(event_num);
			if(dto == null) {
				return new ModelAndView("redirect:/admin/events/list?page=" + page + "&size=" + size);
			}
			
			// 파일
			List<EventDTO> filelist = service.listEventFile(event_num);
			
			ModelAndView mav = new ModelAndView("admin/events/write");
			
			mav.addObject("dto", dto);
			mav.addObject("filelist", filelist);
			mav.addObject("page", page);
			mav.addObject("size", size);
			
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/admin/events/list?page=" + page + "&size=" + size);
	}
	
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정완료
		// 폼데이터 : 글번호, 제목, 내용, 공지여부, 표시여부, [새로운파일, ] 페이지번호, size
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info.getUserLevel() < 51) { // 레벨 설정에 따라 변경
			return new ModelAndView("redirect:/");
		}
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "events";
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		try {
			EventDTO dto = new EventDTO();
			
			dto.setEvent_num(Long.parseLong(req.getParameter("event_num")));
			if(req.getParameter("events") != null) {
				dto.setEvents(Integer.parseInt(req.getParameter("events")));
			}
			if(req.getParameter("showEvent") != null) {
				dto.setShowEvent(Integer.parseInt(req.getParameter("showEvent")));
			}
			dto.setEvent_title(req.getParameter("event_title"));
			dto.setEvent_content(req.getParameter("event_content"));
			
			List<MyMultipartFile> filelist = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(filelist);
			
			service.updateEvent(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/events/list?page=" + page + "&size=" + size);
	}
	
	@GetMapping("download")
	public void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파일 다운로드
		// 넘어온 파라미터 : 파일번호
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "events";
		
		boolean b = false;

		try {
			long fileNum = Long.parseLong(req.getParameter("fileNum"));

			EventDTO dto = service.findByFileId(fileNum);
			if (dto != null) {
				b = fileManager.doFiledownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if ( ! b ) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일다운로드가 실패 했습니다.');history.back();</script>");
		}
	}
	
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		// 넘어온 파라미터 : 글번호, 페이지번호, size [, 검색컬럼, 검색값]
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "events";

		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;

		try {
			long event_num = Long.parseLong(req.getParameter("event_num"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			EventDTO dto = service.findById(event_num);
			if (dto == null) {
				return new ModelAndView("redirect:/admin/events/list?" + query);
			}

			// 실제 파일 삭제
			List<EventDTO> listFile = service.listEventFile(event_num);
			for (EventDTO vo : listFile) {
				fileManager.doFiledelete(pathname, vo.getSaveFilename());
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "event_num");
			map.put("event_num", event_num);
			
			// 파일이름 등의 정보 삭제
			service.deleteEventFile(map);			

			// 게시글 삭제
			service.deleteEvent(event_num);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/events/list?" + query);
	}
	
	@PostMapping("deleteList")
	public ModelAndView deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글다중삭제
		// 넘어온 파라미터 : 글번호들, 페이지번호, size [, 검색컬럼, 검색값]
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "events";

		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "size=" + size + "&page=" + page;

		try {
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			String[] nn = req.getParameterValues("event_nums");
			List<Long> event_nums = new ArrayList<Long>();
			for (int i = 0; i < nn.length; i++) {
				event_nums.add(Long.parseLong(nn[i]));
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "event_nums");
			for (Long n : event_nums) {
				List<EventDTO> listFile = service.listEventFile(n);
				
				// 실제 파일 삭제
				for (EventDTO vo : listFile) {
					fileManager.doFiledelete(pathname, vo.getSaveFilename());
				}
				
				map.put("event_nums", n);
				
				// 파일이름 등의 정보 삭제
				service.deleteEventFile(map);
			}

			// 게시글 다중 삭제
			service.deleteListEvent(event_nums);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/events/list?" + query);
	}
}