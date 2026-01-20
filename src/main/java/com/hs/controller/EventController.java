package com.hs.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/events/*")
public class EventController {
	private EventService service = new EventServiceImpl();
	private MyUtil util = new MyUtil();
	private FileManager fileManager = new FileManager();
	
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이벤트 리스트
		// 넘어오는 파라미터 : [글번호, 페이지번호[검색컬럼, 검색값]]
		ModelAndView mav = new ModelAndView("events/list");
		
		try {
			
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String status = req.getParameter("status");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			if(status == null) {
				status = "";
			}
			
			kwd = util.decodeUrl(kwd);
			status = util.decodeUrl(status);
			
			// 한페이지 표시
			String pageSize = req.getParameter("size");
			int size = pageSize == null ? 10 : Integer.parseInt(pageSize);
					
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("status", status);
			
			int dataCount = service.dataCount(map);
			int total_page = util.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<EventDTO> list = service.listEvent(map);
			
			// top
			List<EventDTO> listTop = null;
			if(status.isBlank() && current_page == 1) {
				listTop = service.listEventTop();
			}
			
			String cp = req.getContextPath();
			String query = "size=" + size;
			String listUrl;
			String articleUrl;
			
			if (! kwd.isBlank()) {  // if(kwd.length() != 0) { // 검색 상태인 경우
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			if(! status.isBlank()) {
				query += "&status=" + util.encodeUrl(status);
			}
			
			listUrl = cp + "/events/list?" + query;
			articleUrl = cp + "/events/article?page=" + current_page + "&" + query;

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
			mav.addObject("status", status);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
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
				return new ModelAndView("redirect:/events/list?" + query);
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("update_date", dto.getUpdate_date());
			map.put("event_num", dto.getEvent_num());
				
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
			
			ModelAndView mav = new ModelAndView("events/article");
					
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
		
		return new ModelAndView("redirect:/events/list?" + query);
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

			dto.setEvent_num(Long.parseLong(req.getParameter("event_num")));
			dto.setContent(req.getParameter("content"));
			dto.setParent_comment_id(Long.parseLong(req.getParameter("parent_comment_id")));
			
			dto.setUser_num(info.getMemberIdx());
			dto.setUser_id(info.getUserId());
	        
			service.insertReply(dto);
			
			state = "true";		
			
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
		// 넘어오는 파라미터 : 글번호, 페이지
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			Map<String, Object> mav = new HashMap<String, Object>();
			
			long event_num = Long.parseLong(req.getParameter("event_num"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if(pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}
			
			int size = 10;
			int total_page = 0;
			int replyCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("event_num", event_num);
			map.put("user_num", info.getMemberIdx());
			map.put("user_id", info.getUserId());
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
			sessionMember.put("user_id", info.getUserId());
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
			long event_num = Long.parseLong(req.getParameter("event_num"));
			String mode = req.getParameter("mode");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("event_num", event_num);
			map.put("user_id", info.getUserId());
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
	
	// 댓글의 답글 리스트 : AJAX - JSON
	@ResponseBody
	@GetMapping("listReplyAnswer")
	public Map<String, Object> listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> mav = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			long parent_comment_id = Long.parseLong(req.getParameter("parent_comment_id"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("parent_comment_id", parent_comment_id);
			map.put("user_id", info.getUserId());
			map.put("userLevel", info.getUserLevel());
			
			// 답글 개수
			int count = service.replyAnswerCount(map);
			// 답글
			List<EventReplyDTO> listReplyAnswer = service.listReplyAnswer(map);
			
			for(EventReplyDTO dto : listReplyAnswer) {
				dto.setContent(util.htmlSymbols(dto.getContent()));
			}
			
			Map<String, Object> sessionMember = new HashMap<String, Object>();
			sessionMember.put("user_Id", info.getUserId());
			sessionMember.put("userLevel", info.getUserLevel());
			
			mav.put("sessionMember", sessionMember);
			mav.put("count", count);
			mav.put("listReplyAnswer", listReplyAnswer);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			resp.sendError(406);
			throw e;
		}
		
		return mav;
	}
	
	// 댓글 숨김 / 표시 : AJAX - JSON
	@ResponseBody
	@PostMapping("replyShowHide")
	public Map<String, Object> replyShowHide(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String state = "ture";
		
		try {
			long event_num = Long.parseLong(req.getParameter("event_num"));
			int showReply = Integer.parseInt(req.getParameter("showReply"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("event_num", event_num);
			map.put("showReply", showReply);
			map.put("user_id", info.getUserId());
			
			service.updateReplyShowHide(map);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			state = "false";
		}
		
		model.put("state", state);
		
		return model;
	}
}