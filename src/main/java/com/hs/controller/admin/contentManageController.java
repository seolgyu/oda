package com.hs.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.ContentDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.admin.ContentService;
import com.hs.service.admin.ContentServiceImpl;
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/content/*")
public class contentManageController {
	private MyUtil util = new MyUtil();
	private ContentService service = new ContentServiceImpl();
	
	@GetMapping("list")
	public ModelAndView contentList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/content/list");
		
		try {
			String page = req.getParameter("page");
			
			int current_page = 1;
			
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			//전체 게시물 수 
			int postAllCount = service.postAllCount();
			//정살 게시물 수
			int postNormalCount = service.postNormalCount();
			//신고 게시물 수
			int postDeclaCount = service.postDeclaCount();
			//신고 처리 게시물 수
			int postProCount = service.postProCount();
			
			//검색 1번 쨰 검색 kwd와 schType, 2번 째 검색 user_status
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String state = req.getParameter("state"); 
		
			//검색 키워드 null 처리
			if(schType == null) {
			    schType = "all";
			}
			if(kwd == null) {
			    kwd = "";
			} 
			if(state == null) { 
				state =""; 
			}
			
			//검색 키워드 인코딩
			kwd = util.decodeUrl(kwd);
			state = util.decodeUrl(state);
			
			//페이징을 위한 파라메터
			String pageSize = req.getParameter("size");
			int size = pageSize == null ? 10 : Integer.parseInt(pageSize);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);	
			map.put("state", state);
			
			int countDto = service.userCount(map);
			int total_page = util.pageCount(countDto, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			String cp = req.getContextPath();
			String query = "size=" + size;
			String listUrl;
			
			List<ContentDTO> memberList = service.memberList(map);
			
			if (! kwd.isBlank()) {  // if(kwd.length() != 0) { // 검색 상태인 경우
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			listUrl = cp + "/admin/content/list?" + query;

			String paging = util.paging(current_page, total_page, listUrl);
			
			
			//게시물 count
			mav.addObject("postAllCount", postAllCount);
			mav.addObject("postNormalCount", postNormalCount);
			mav.addObject("postDeclaCount", postDeclaCount);
			mav.addObject("postProCount", postProCount);
			
			//검색, 페이징 수
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			mav.addObject("state", state);
			
			//게시물목록
			mav.addObject("memberList", memberList);
			mav.addObject("countDto", countDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@ResponseBody
	@PostMapping("updateStatus")
	public Map<String, Object> updateStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> result = new HashMap<>();
		
		try {
			String memberIds = req.getParameter("memberIds");
			String status = req.getParameter("status");
			
			if (memberIds == null || memberIds.isBlank()) {
				result.put("success", false);
				result.put("message", "게시물 ID가 없습니다.");
				return result;
			}
			
			// 쉼표로 구분된 ID 문자열을 배열로 변환
			String[] idArray = memberIds.split(",");
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberIds", idArray);
			map.put("status", status);
			
			// 일괄 상태 업데이트
			int updateCount = service.updateMemberStatus(map);
			
			if (updateCount > 0) {
				result.put("success", true);
				result.put("message", updateCount + "명의 게시물 상태를 변경했습니다.");
			} else {
				result.put("success", false);
				result.put("message", "게시물 상태 변경에 실패했습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("message", "서버 오류가 발생했습니다.");
		}
		
		return result;
	}
}
