package com.hs.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.MainDTO;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.admin.MainService;
import com.hs.service.admin.MainServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeManageController {
	private MainService service = new MainServiceImpl();
	@GetMapping("/admin")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/home/main");
		
		try {
			//총 가입자 수
			List<MainDTO> list = service.memberCountList();
			
			//일일 가입자 수
			MainDTO dayDto = service.memberDayCountList();
			
			//이용 중인 사용자 수
			MainDTO inDto = service.memberInCount();
			
			//탈퇴 회원 수
			MainDTO drewDto = service.memberDrewCount();
			
			//휴먼 처리된 계정 수
			MainDTO dorDto = service.memberDorCount();
			
			//휴먼 예정 계정 수
			MainDTO dorexpDto = service.memberDorExpcount();
			
			//콘텐츠 업로드 수
			MainDTO postDto = service.postCount();
			
			//최근 콘텐츠 업로드 수
			MainDTO recentDto = service.recentpostcount();
			
			//커뮤니티 개설 수
			MainDTO comDto = service.comCount();
			
			//커뮤니티 일일 내 개설 수
			MainDTO comDayDto = service.comDayCount();
			
			//게시물 및 회원 방문자 수 차트 
			List<MainDTO> weeklyStatsList = service.selectWeeklyStats();
			
			//신고 처리된 콘텐츠 수
			MainDTO reportpostcount = service.reportpostcount();
			
			//신고 처리 예정 콘텐츠 수
			MainDTO reportcount = service.reportPosts();
			
			//비공개 커뮤니티 수
			MainDTO priDto = service.comPriCount();
			
			mav.addObject("list", list);
			mav.addObject("dayDto", dayDto);
			mav.addObject("inDto", inDto);
			mav.addObject("drewDto", drewDto);
			mav.addObject("dorDto", dorDto);
			mav.addObject("dorexpDto", dorexpDto);
			mav.addObject("postDto", postDto);
			mav.addObject("recentDto", recentDto);
			mav.addObject("comDto", comDto);
			mav.addObject("comDayDto", comDayDto);
			mav.addObject("weeklyStatsList", weeklyStatsList);
			mav.addObject("reportcount", reportcount);
			mav.addObject("reportpostcount", reportpostcount);
			mav.addObject("priDto", priDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
}