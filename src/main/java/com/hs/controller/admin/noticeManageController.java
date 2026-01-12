package com.hs.controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.NoticeReplyDTO;
import com.hs.model.SessionInfo;
import com.hs.model.admin.NoticeDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.admin.NoticeService;
import com.hs.service.admin.NoticeServiceImpl;
import com.hs.util.FileManager;
import com.hs.util.MyMultipartFile;
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/notice/*")
public class noticeManageController {
	private NoticeService service = new NoticeServiceImpl();
	private MyUtil util = new MyUtil();
	private FileManager fileManager = new FileManager();
	
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/notice/write");
		
		String size = req.getParameter("size");
		
		mav.addObject("mode", "write");
		mav.addObject("size", size);
		
		return mav;
	}
	
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		String size = req.getParameter("size");
		
		try {
			NoticeDTO dto = new NoticeDTO();
			
			dto.setUser_num(info.getMemberIdx());
			dto.setIs_notice(req.getParameter("is_Notice"));
			dto.setState(req.getParameter("state"));
			dto.setNoti_title(req.getParameter("title"));
			dto.setNoti_content(req.getParameter("content"));

			List<MyMultipartFile> listFile = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(listFile);

			service.noticeInsert(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/notice/list?size=" + size);
	}
	
	@GetMapping("list")
	public ModelAndView notice(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/notice/list");
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String state = req.getParameter("state");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);

			// 한페이지 표시할 데이터 개수
			String pageSize = req.getParameter("size");
			int size = pageSize == null ? 10 : Integer.parseInt(pageSize);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("is_Notice", 1);
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
			
			List<NoticeDTO> list = service.noticeList(map);

			// 공지글
			List<NoticeDTO> noticeList = null;
			if(current_page == 1) {
				noticeList = service.noticeListTop();
			}

			String cp = req.getContextPath();
			String query = "size=" + size;
			String listUrl;
			String articleUrl;
			
			if (! kwd.isBlank()) {  // if(kwd.length() != 0) { // 검색 상태인 경우
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			listUrl = cp + "/admin/notice/list?" + query;
			articleUrl = cp + "/admin/notice/article?page=" + current_page + "&" + query;

			String paging = util.paging(current_page, total_page, listUrl);

			// 포워딩 jsp에 전달할 데이터
			mav.addObject("list", list);
			mav.addObject("noticeList", noticeList);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			mav.addObject("state", state);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		// 파일 저장 경로 - 임시 주석
		
		  String root = session.getServletContext().getRealPath("/"); String pathname =
		  root + "uploads" + File.separator + "notice";
		  
		  String page = req.getParameter("page"); String size =
		  req.getParameter("size"); String query = "page=" + page + "&size=" + size;
		 
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String state = req.getParameter("state");
			
			if (schType == null) {
				schType = "all";
				kwd = "";
			} else if (state == null) {
				state = "";
			}
			kwd = util.decodeUrl(kwd);

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			if (state != null) {
	            query += "&state=" + util.encodeUrl(state);
	        }

			NoticeDTO dto = service.findById(num);
			if (dto == null) {
				return new ModelAndView("redirect:/admin/notice/list?" + query);
			}

			// 실제 파일 삭제
			
			List<NoticeDTO> listFile = service.listNoticeFile(num); for (NoticeDTO vo :
			listFile) { fileManager.doFiledelete(pathname, vo.getSaveFilename()); }
			 
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			
			//파일이름 등의 정보 삭제
			service.deleteNoticeFile(map);			

			// 게시글 삭제
			service.noticeDelete(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/admin/notice/list?" + query);
	}
	
	@PostMapping("deleteList")
	public ModelAndView deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글다중삭제
		// 넘어온 파라미터 : 글번호들, 페이지번호, size [, 검색컬럼, 검색값]
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String state = req.getParameter("state");
		
		String query = "size=" + size + "&page=" + page;
		if (state != null) {
	        query += "&state=" + util.encodeUrl(state);
	    }
		try {
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			} else if (kwd == null) {
				kwd = "";
			} else if (state == null) {
				state = "";
			}
			kwd = util.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			if (state != null) {
	            query += "&state=" + util.encodeUrl(state);
	        }

			String[] nn = req.getParameterValues("nums");
			List<Long> nums = new ArrayList<Long>();
			for (int i = 0; i < nn.length; i++) {
				nums.add(Long.parseLong(nn[i]));
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "num");
			for (Long n : nums) {
				List<NoticeDTO> listFile = service.listNoticeFile(n);
				
				// 실제 파일 삭제
				
				  for (NoticeDTO vo : listFile) { fileManager.doFiledelete(pathname,
				  vo.getSaveFilename()); }
				 
				
				map.put("num", n);
				
				// 파일이름 등의 정보 삭제
				service.deleteNoticeFile(map);
			}

			// 게시글 다중 삭제
			service.noticeDeleteList(nums);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list?" + query);
	}
	
	@GetMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글보기
		// 넘어온 파라미터 : 글번호, 페이지번호, size [, 검색컬럼, 검색값]
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));

			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String state = req.getParameter("state");
			if (schType == null) {
				schType = "all";
				kwd = "";
			} else if (state == null) {
				state = "";
			}
			kwd = util.decodeUrl(kwd);

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			if (state != null) {
		        query += "&state=" + util.encodeUrl(state);
		    }

			// 조회수
			service.updateHitCount(num);

			// 게시물 가져오기
			NoticeDTO dto = service.findById(num);
			if (dto == null) {
				return new ModelAndView("redirect:/admin/notice/list?" + query);
			}

			// 스마트 에디터를 사용하므로 주석 처리
			// dto.setContent(util.htmlSymbols(dto.getContent()));

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("state", state);
			// map.put("num", num);
			map.put("update_date", dto.getUpdate_date());
			
			// 이전글/다음글
			NoticeDTO prevDto = service.findByPrev(map);
			NoticeDTO nextDto = service.findByNext(map);

			// 파일
			List<NoticeDTO> listFile = service.listNoticeFile(num);

			ModelAndView mav = new ModelAndView("admin/notice/article");
			
			mav.addObject("dto", dto);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			mav.addObject("listFile", listFile);
			mav.addObject("query", query);
			mav.addObject("page", page);
			mav.addObject("size", size);

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list?" + query);
	}
	
	@GetMapping("download")
	public void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파일 다운로드
		// 넘어온 파라미터 : 파일번호
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		boolean b = false;

		try {
			long fileNum = Long.parseLong(req.getParameter("fileNum"));

			NoticeDTO dto = service.findByFileId(fileNum);
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
	
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 폼
		// 넘어온 파라미터 : 글번호, 페이지번호, size
		String page = req.getParameter("page");
		String size = req.getParameter("size");

		try {
			long num = Long.parseLong(req.getParameter("num"));

			NoticeDTO dto = service.findById(num);
			if (dto == null) {
				return new ModelAndView("redirect:/admin/notice/list?page=" + page + "&size=" + size);
			}

			// 파일
			List<NoticeDTO> listFile = service.listNoticeFile(num);

			ModelAndView mav = new ModelAndView("admin/notice/write");
			
			mav.addObject("dto", dto);
			mav.addObject("listFile", listFile);
			mav.addObject("page", page);
			mav.addObject("size", size);

			mav.addObject("mode", "update");

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list?page=" + page + "&size=" + size);
	}
	
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 완료
		// 폼 데이터 : 글번호, 제목, 내용, 공지여부, 표시여부, [새로운파일, ] 페이지번호, size
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info.getUserLevel() < 51) {
			return new ModelAndView("redirect:/");
		}
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");

		try {
			NoticeDTO dto = new NoticeDTO();
			
			dto.setNotice_num(Long.parseLong(req.getParameter("num")));
			dto.setIs_notice(req.getParameter("is_Notice"));
			dto.setState(req.getParameter("state"));			
			dto.setNoti_title(req.getParameter("title"));
			dto.setNoti_content(req.getParameter("content"));

			List<MyMultipartFile> listFile = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(listFile);

			service.updateNotice(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list?page=" + page + "&size=" + size);
	}
	
	@GetMapping("deleteFile")
	public ModelAndView deleteFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정에서 파일만 삭제
		// 넘어온 파라미터 : 글번호, 파일번호, 페이지번호, size
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		String page = req.getParameter("page");
		String size = req.getParameter("size");

		try {
			long num = Long.parseLong(req.getParameter("num"));
			long fileNum = Long.parseLong(req.getParameter("fileNum"));
			NoticeDTO dto = service.findByFileId(fileNum);
			if (dto != null) {
				// 파일삭제
				fileManager.doFiledelete(pathname, dto.getSaveFilename());
				
				// 테이블 파일 정보 삭제
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("field", "fileNum");
				map.put("num", fileNum);
				
				service.deleteNoticeFile(map);
			}

			// 다시 수정 화면으로
			return new ModelAndView("redirect:/admin/notice/update?num=" + num + "&page=" + page + "&size=" + size);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list?page=" + page + "&size=" + size);
	}
	
	@ResponseBody
	@PostMapping("insertReply")
	public Map<String, Object> insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "false";
		try {
			NoticeReplyDTO dto = new NoticeReplyDTO();
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setContent(req.getParameter("content"));
			dto.setParentNum(Long.parseLong(req.getParameter("parentNum")));
			
			dto.setUserId(info.getUserId());
			
			service.insertReply(dto);
			
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@ResponseBody
	@GetMapping("listReply")
	public Map<String, Object> listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			
			// 넘어온파라미터 : num, pageNo
			long num = Long.parseLong(req.getParameter("num"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if(pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}
			
			int size = 10;
			int total_page = 0;
			int replyCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("num", num);
			map.put("userId", info.getUserId());
			map.put("userLevel", info.getUserLevel());
			
			replyCount = service.replyCount(map);
			total_page = util.pageCount(replyCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<NoticeReplyDTO> listReply = service.listReply(map);
			
			for(NoticeReplyDTO dto : listReply) {
				dto.setContent(util.htmlSymbols(dto.getContent()));
				
				// 유저의 좋아요/싫어요 유무
				  map.put("replyNum", dto.getReplyNum());
				  dto.setUserLikedReply(service.hasUserReplyLiked(map));
			}
			Map<String, Object> sessionMember = new HashMap<String, Object>();
			sessionMember.put("userId", info.getUserId());
			sessionMember.put("userLevel", info.getUserLevel());
			// 페이징 : AJAX - loadContent(page) 메소드 호출
						String paging = util.pagingMethod(current_page, total_page, "loadContent");
						
			// JSON 으로 클라이언트에게 전송
			model.put("sessionMember", sessionMember);
			model.put("listReply", listReply);
			model.put("pageNo", current_page);
			model.put("replyCount", replyCount);
			model.put("total_page", total_page);
			model.put("paging", paging);
			
			return model;
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(406);
			
			throw e;
		}
		
	}
}