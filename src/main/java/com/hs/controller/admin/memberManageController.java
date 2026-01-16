package com.hs.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.MainDTO;
import com.hs.model.admin.MemberDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.admin.MainService;
import com.hs.service.admin.MainServiceImpl;
import com.hs.service.admin.MemberService;
import com.hs.service.admin.MemberServiceImpl;
import com.hs.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/member/*")
public class memberManageController {
	//전체, 활성, 휴면 회원 수 재활용
	private MainService service = new MainServiceImpl();
	private MemberService mbService = new MemberServiceImpl();
	private MyUtil util = new MyUtil();
	
	@GetMapping("list")
	public ModelAndView memberList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/member/list");
		
		//가져와야 하는 값 page, schType, kwd, status, size
		try {
		String page = req.getParameter("page");
			int current_page = 1;
		if (page != null) {
			current_page = Integer.parseInt(page);
		}
			
		//전체 회원 수 
		List<MainDTO> mblist = service.memberCountList();
		//활성 회원 수
		MainDTO inDto = service.memberInCount();
		//정지 회원 수
		MainDTO stopDto = service.stopMemberCount();
		//휴면 회원 수
		MainDTO dorDto = service.memberDorCount();
		
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
	
		//관리자를 제외한 회원 목록 count, 페이징 재사용
		int countDto = mbService.userCount(map);
		int total_page = util.pageCount(countDto, size);
		
		current_page = Math.min(current_page, total_page);
		
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		
		String cp = req.getContextPath();
		String query = "size=" + size;
		String listUrl;
		String articleUrl;
		
		//관리자를 제외한 회원 목록
		List<MemberDTO> memberList = mbService.memberList(map);
		
		if (! kwd.isBlank()) {  // if(kwd.length() != 0) { // 검색 상태인 경우
			query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
		}
		listUrl = cp + "/admin/member/list?" + query;
		articleUrl = cp + "/admin/member/article?page=" + current_page + "&" + query; //사용자 상세 페이지

		String paging = util.paging(current_page, total_page, listUrl);
		
		//통계 수
		mav.addObject("mblist", mblist);
		mav.addObject("inDto", inDto);
		mav.addObject("stopDto", stopDto);
		mav.addObject("dorDto", dorDto);
		
		//회원 목록
		mav.addObject("memberList", memberList);
		mav.addObject("countDto", countDto);
		
		//검색, 페이징 수
		mav.addObject("articleUrl", articleUrl);
		mav.addObject("size", size);
		mav.addObject("page", current_page);
		mav.addObject("total_page", total_page);
		mav.addObject("paging", paging);
		mav.addObject("schType", schType);
		mav.addObject("kwd", kwd);
		mav.addObject("state", state);
		}catch (Exception e){
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
			int status = Integer.parseInt(req.getParameter("status"));
			
			if (memberIds == null || memberIds.isBlank()) {
				result.put("success", false);
				result.put("message", "회원 ID가 없습니다.");
				return result;
			}
			
			// 쉼표로 구분된 ID 문자열을 배열로 변환
			String[] idArray = memberIds.split(",");
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberIds", idArray);
			map.put("status", status);
			
			// 일괄 상태 업데이트
			int updateCount = mbService.updateMemberStatus(map);
			
			if (updateCount > 0) {
				result.put("success", true);
				result.put("message", updateCount + "명의 회원 상태를 변경했습니다.");
			} else {
				result.put("success", false);
				result.put("message", "회원 상태 변경에 실패했습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("message", "서버 오류가 발생했습니다.");
		}
		
		return result;
	}
	
	@GetMapping("detailmember")
	public ModelAndView detailmember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/member/detailmember");

	    try {
	        String user_id = req.getParameter("user_id");
	        
	        // 목록 페이지로 돌아갈 때 필요한 파라미터들
	        String page = req.getParameter("page");
	        String size = req.getParameter("size");
	        String schType = req.getParameter("schType");
	        String kwd = req.getParameter("kwd");
	        String state = req.getParameter("state");

	        if (user_id == null || user_id.isBlank()) {
	            // user_id가 없으면 목록으로 리다이렉트
	            mav = new ModelAndView("redirect:/admin/member/list");
	            return mav;
	        }

	        Map<String, Object> map = new HashMap<>();
	        map.put("user_id", user_id);

	        MemberDTO memberDto = mbService.memberInfo(map);
	        
	        if (memberDto == null) {
	            // 회원 정보가 없으면 목록으로 리다이렉트
	        	mav = new ModelAndView("redirect:/admin/member/list");
	            return mav;
	        }
	        
	        //사용자 별 게시물 및 댓글 활동 내역 차트
			List<MemberDTO> weeklyActivity = mbService.selectWeeklyUser(map);

	        // 회원 정보
	        mav.addObject("memberDto", memberDto);
	        
	        
	        // 목록으로 돌아가기 위한 파라미터들
	        mav.addObject("page", page != null ? page : "1");
	        mav.addObject("size", size != null ? size : "10");
	        mav.addObject("schType", schType != null ? schType : "");
	        mav.addObject("kwd", kwd != null ? kwd : "");
	        mav.addObject("state", state != null ? state : "");
	        
	        mav.addObject("weeklyActivity", weeklyActivity);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        mav = new ModelAndView("redirect:/admin/member/list");
	    }
	    
	    return mav;
	}
	
	@ResponseBody
	@PostMapping("updateDetailStatus")
	public Map<String, Object> updateDetailStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> result = new HashMap<>();
		
		try {
			String user_id = req.getParameter("user_id");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
