package com.hs.controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.SessionInfo;
import com.hs.model.admin.EventDTO;
import com.hs.model.admin.EventReplyDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
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
import oracle.jdbc.proxy.annotation.Post;

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
			String state = req.getParameter("state");
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
			map.put("state", state);
			
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
			
			
			List<MyMultipartFile> filelist = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(filelist);
			
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
		
		if (page == null || page.equals("")) page = "1";
	    if (size == null || size.equals("")) size = "10";
		
		String query = "page=" + page + "&size=" + size;
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
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
				return new ModelAndView("redirect:/admin/events/list?" + query);
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
			
			// 유저의 게시글 좋아요 유무
			map.put("user_num", info.getMemberIdx());
			map.put("event_num", event_num);
						
			boolean isUserLiked = service.isUserBoardLiked(map);
			int boardLikeCount = service.boardLikeCount(event_num);
			
			ModelAndView mav = new ModelAndView("admin/events/article");
					
			mav.addObject("dto", dto);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			mav.addObject("filelist", filelist);
			mav.addObject("query", query);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			
			mav.addObject("isUserLiked", isUserLiked);
			mav.addObject("boardLikeCount", boardLikeCount);
			
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
		if(page == null || page.isEmpty()) page = "1"; 
		
		String size = req.getParameter("size");
		if(size == null || size.isEmpty()) size = "10";
		
		
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
			
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			
			
			if(req.getParameter("is_active") != null) {
			    dto.setIs_active(Integer.parseInt(req.getParameter("is_active")));
			}
			
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
				b = fileManager.doFiledownload(dto.getFile_path(), dto.getFile_name(), pathname, resp);
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
	
	
	@ResponseBody
	@PostMapping("deleteFile")
	public Map<String, Object> deleteFile(HttpServletRequest req) throws ServletException, IOException {
		// 수정에서 파일만 삭제
		// 넘어온 파라미터 : 글번호, 파일번호, 페이지번호, size
		
		Map<String, Object> mav = new HashMap<>();
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "events";

		try {
			// long event_num = Long.parseLong(req.getParameter("event_num"));
			long file_at_id = Long.parseLong(req.getParameter("file_at_id"));
			EventDTO dto = service.findByFileId(file_at_id);
			if (dto != null) {
				// 파일삭제
				fileManager.doFiledelete(pathname, dto.getFile_path());
				
				service.deleteEventFile(file_at_id);
				
				// 테이블 파일 정보 삭제
				// mav.put("event_num", event_num);
				mav.put("status", "success");
				
			}

		} catch (Exception e) {
			e.printStackTrace();
			mav.put("status", "error");
		}

		return mav;
	}

	
	@PostMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		// 넘어온 파라미터 : 글번호, 페이지번호, size [, 검색컬럼, 검색값]
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "events";

		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		if (page == null || page.equals("")) page = "1";
	    if (size == null || size.equals("")) size = "10";
		
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
			List<EventDTO> filelist = service.listEventFile(event_num);
			for (EventDTO vo : filelist) {
				fileManager.doFiledelete(pathname, vo.getFile_path());
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", event_num);
			map.put("event_num", event_num);
			
			// 파일이름 등의 정보 삭제
			service.deleteEventFile(event_num);		

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
		
		if (page == null || page.equals("")) page = "1";
	    if (size == null || size.equals("")) size = "10";
		
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
			map.put("field", event_nums);
			for (Long n : event_nums) {
				
				List<EventDTO> filelist = service.listEventFile(n);
				
				// 실제 파일 삭제
				for (EventDTO vo : filelist) {
					fileManager.doFiledelete(pathname, vo.getFile_path());
				}
				
				map.put("event_nums", n);
				
				// 파일이름 등의 정보 삭제
				// service.deleteEventFile(event_nums);
			}

			// 게시글 다중 삭제
			service.deleteListEvent(event_nums);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/events/list?" + query);
	}
	
	
	
	// 좋아요
	@ResponseBody
	@PostMapping("insertBoardLike")
	public Map<String, Object> insertBoardLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> mav = new HashMap<String, Object>();
		
		// 넘어오는 파리미터 : 글번호, 좋아요/취소 여부
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session .getAttribute("member");
		
		String state = "false";
		int boardLikeCount = 0;
		
		try {
			long event_num = Long.parseLong(req.getParameter("event_num"));
			String userLiked = req.getParameter("userLiked");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("event_num", event_num);
			map.put("user_num", info.getMemberIdx());
			
			if(userLiked.equals("true")){
				//좋아요 취소
				service.deleteBoardLike(map);
			} else {
				//좋아요
				service.insertBoardLike(map);
			}
			
			boardLikeCount = service.boardLikeCount(event_num);
			
			state = "true";
			
		} catch(SQLException e) {
			state = "liked";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.put("state", state);
		mav.put("boardLikeCount", boardLikeCount);
		
		return mav;
		
		}
		
	
	@ResponseBody
	@PostMapping("insertReply")
	public Map<String, Object> insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 댓글 등록
		Map<String, Object> mav = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "false";
		
		try {
			EventReplyDTO dto = new EventReplyDTO();
			
			dto.setgetComment_id(Long.parseLong(req.getParameter("comment_id")));
			dto.setContent(req.getParameter("content"));
			dto.setgetComment_id(Long.parseLong(req.getParameter("getParent_comment_id")));
			
			dto.setUser_Id(info.getUserId());
			
			service.insertReply(dto);
			
			state = "ture";		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.put("state", state);
		
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping("listReply")
	public Map<String, Object> listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 댓글 리스트
		// 넘어오는 파라미터 : 댓글 번호, 페이지
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			Map<String, Object> mav = new HashMap<String, Object>();
			
			long comment_id = Long.parseLong(req.getParameter("comment_id"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if(pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}
			
			int size = 10;
			int total_page = 0;
			int replyCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("comment_id", comment_id);
			map.put("userId", info.getUserId());
			map.put("userLevel", info.getUserLevel());
			
			replyCount = service.replyCount(map);
			total_page = util.pageCount(replyCount, size);
			current_page = Math.min(current_page, total_page);
			
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<EventReplyDTO> listReply = service.listReply(map);
			
			for(EventReplyDTO dto : listReply) {
				dto.setContent(util.htmlSymbols(dto.getContent()));
				
				
				// 유저의 좋아요 유무
				map.put("comment_id", dto.getComment_id());
				dto.setUserLikedReply(service.hasUserReplyLiked(map));
			}
			
			Map<String, Object> sessionMember = new HashMap<String, Object>();
			sessionMember.put("userId", info.getUserId());
			sessionMember.put("userLevel", info.getUserLevel());
			
			String paging = util.pagingMethod(current_page, total_page, "loadContent");
			
			mav.put("sessionMember", sessionMember);
			mav.put("listReply", listReply);
			mav.put("pageNo", current_page);
			mav.put("replyCount", replyCount);
			mav.put("total_page", total_page);
			mav.put("paging", paging);
			
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(406);
			
			throw e;
		}
		
	}
	
	
	@ResponseBody
	@PostMapping("deleteReply")
	public Map<String, Object> deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 댓글 삭제
		Map<String, Object> mav = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "false";
		
		try {
			long comment_id = Long.parseLong(req.getParameter("comment_id"));
			String mode = req.getParameter("mode");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("comment_id", comment_id);
			map.put("userId", info.getUserId());
			map.put("userLevel",info.getUserLevel());
			map.put("mode",mode);
			
			service.deleteReply(map);
			
			state = "true";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.put("steate", state);
		
		return mav;
	}
	
	/*
	@ResponseBody
	@GetMapping("listReplyAnswer")
	public Map<String, Object> listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 댓글의 답글 리스트
		Map<String, Object> model = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	*/
}