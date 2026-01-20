package com.hs.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;
import com.hs.model.MemberDTO;
import com.hs.model.PostDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.CommunityService;
import com.hs.service.CommunityServiceImpl;
import com.hs.service.PostService;
import com.hs.service.PostServiceImpl;
import com.hs.util.CloudinaryUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/community/*")
public class CommunityController {
	private CommunityService cservice = new CommunityServiceImpl();
	private PostService postService = new PostServiceImpl();
	@GetMapping("create")
	public ModelAndView createForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		ModelAndView mav = new ModelAndView("community/create");

		List<CommunityDTO> categoryList = cservice.getCategoryList();
		
		mav.addObject("categoryList", categoryList);
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping("create")
	public Map<String, Object> createSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		Map<String, Object> map = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		CommunityDTO dto = new CommunityDTO();
		dto.setCom_name(req.getParameter("com_name"));
	    dto.setCom_description(req.getParameter("com_description"));
	    dto.setIs_private("private".equals(req.getParameter("is_private")) ? "1" : "0");
	    dto.setCategory_id(Long.parseLong(req.getParameter("category_id")));
	    dto.setUser_num(info.getMemberIdx());
		
		try {
			cservice.insertCommunity(dto);
			
			CommunityDTO saveDto = cservice.isCommunityName(dto.getCom_name());
			
			map.put("status", "success");
			map.put("community_id", saveDto.getCommunity_id());

		} catch (Exception e) {
			List<CommunityDTO> categoryList = cservice.getCategoryList();
			map.put("categoryList", categoryList);
			map.put("status", "error");
			map.put("dto", dto);
			e.printStackTrace();
		}
		return map;
	}
	
	@GetMapping("main")
	public ModelAndView mainPage(HttpServletRequest req, HttpServletResponse resp) {
		String com_id = req.getParameter("community_id");
		
		String sort = req.getParameter("sort");
	    if(sort == null || sort.isEmpty()) sort = "latest";
	    
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Long user_num = info.getMemberIdx();
		
		if(com_id == null || com_id.isEmpty()) {
			return new ModelAndView("redirect:/community/list");
		}
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_id", Long.parseLong(com_id));
			map.put("user_num", user_num);
			
			CommunityDTO dto = cservice.findById(map);
			
			if(dto != null) {
				int is_follow = cservice.checkJoinCommunity(map);
				dto.setIs_follow(is_follow);
				
				Map<String, Object> postMap = new HashMap<>();
	            postMap.put("community_id", Long.parseLong(com_id));
	            postMap.put("user_num", user_num); // '나만보기' 필터링용
	            postMap.put("sort", sort);         // 정렬 기준
	            postMap.put("offset", 0);
	            postMap.put("size", 5);

	            List<PostDTO> list = postService.listCommunityPost(postMap);
				
				ModelAndView mav = new ModelAndView("community/main");
				mav.addObject("dto", dto);
				mav.addObject("post", list);    // JSP에서 <c:forEach>로 뿌릴 데이터
	            mav.addObject("currentSort", sort); // 현재 어떤 정렬인지 UI 표시용
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/community/list");
	}
	
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String com_id = req.getParameter("community_id");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView("community/update");
		
		try {
			if(com_id != null) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("community_id", Long.parseLong(com_id));
				map.put("user_num", info.getMemberIdx());
				CommunityDTO dto = cservice.findById(map);
	            mav.addObject("dto", dto);
	            
	            List<CommunityDTO> categoryList = cservice.getCategoryList();
	    		mav.addObject("categories", categoryList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@ResponseBody
	@GetMapping("checkName")
	public Map<String, Object> checkName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> map = new HashMap<>();
		Boolean isDuplicate;
		String com_name = req.getParameter("com_name");
		
		try {
			CommunityDTO dto = cservice.isCommunityName(com_name);

			if( dto != null) {
				isDuplicate = true;
			} else {
				isDuplicate = false;
			}
			map.put("isDuplicate", isDuplicate);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	    return map;
	}
	
	@ResponseBody
	@PostMapping("update")
	public Map<String, Object> updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		Map<String, Object> map = new HashMap<String, Object>();
		
		String root = req.getServletContext().getRealPath("/");
	    String tempPath = root + "temp" + File.separator + "community";
	    
	    File tempDir = new File(tempPath);
	    if (!tempDir.exists()) tempDir.mkdirs();
		
		try {
			String com_id = req.getParameter("community_id");
	        String com_name = req.getParameter("com_name");
	        String description = req.getParameter("com_description");
	        String is_private = req.getParameter("is_private");
	        String topic_id = req.getParameter("category_id");
	        
	        String isIconDeleted = req.getParameter("isIconDeleted");
	        String isBannerDeleted = req.getParameter("isBannerDeleted");
	        
	        String iconUrl = req.getParameter("icon_image");
	        String bannerUrl = req.getParameter("banner_image");
	        
	        Part iconPart = req.getPart("iconFile");
	        if ("true".equals(isIconDeleted)) {
	            iconUrl = null;
	        } else if (iconPart != null && iconPart.getSize() > 0) {
	            iconUrl = processCloudinaryUpload(iconPart, tempPath);
	        }

	        Part bannerPart = req.getPart("bannerFile");
	        if ("true".equals(isBannerDeleted)) {
	            bannerUrl = null;
	        } else if (bannerPart != null && bannerPart.getSize() > 0) {
	            bannerUrl = processCloudinaryUpload(bannerPart, tempPath);
	        }

	        CommunityDTO dto = new CommunityDTO();
	        dto.setCommunity_id(Long.parseLong(com_id));
	        dto.setCom_name(com_name);
	        dto.setCom_description(description);
	        dto.setIs_private("private".equals(is_private) ? "1" : "0");
	        dto.setCategory_id(Long.parseLong(topic_id));
	        dto.setIcon_image(iconUrl); 
	        dto.setBanner_image(bannerUrl);
	        
	        cservice.updateCommunity(dto);

	        map.put("status", "success");
	        map.put("community_id", com_id);
	        map.put("message", "커뮤니티 설정이 변경되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "error");
	        map.put("message", e.getMessage());
		}
		
		return map;
	}
	
    private String processCloudinaryUpload(Part part, String tempPath) throws IOException {
        String originalFileName = part.getSubmittedFileName();
        
        if (originalFileName == null || originalFileName.trim().isEmpty()) {
            return null;
        }

        File tempFile = new File(tempPath, originalFileName);
        part.write(tempFile.getAbsolutePath());

        String uploadedUrl = CloudinaryUtil.uploadFile(tempFile);

        if (tempFile.exists()) {
            tempFile.delete();
        }

        return uploadedUrl;
    }
	
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String community_id = req.getParameter("community_id");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_id", Long.parseLong(community_id));
	        map.put("user_num", info.getMemberIdx());
	        
			cservice.deleteCommunity(map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/community/management?delete=fail");
		}
		
		return new ModelAndView("redirect:/community/management?delete=success");
	}
	
	@GetMapping("management")
	public ModelAndView managementList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		ModelAndView mav = new ModelAndView("community/management");
		
		try {
			Map<String, Object> allmap = new HashMap<String, Object>();
			allmap.put("user_num", info.getMemberIdx());
			allmap.put("mode", "allList");
			
			List<CommunityDTO> allList = cservice.managementList(allmap);
			System.out.println("디버깅 - allList 개수: " + (allList != null ? allList.size() : "null"));
			mav.addObject("allList", allList);
			
			Map<String, Object> favmap = new HashMap<String, Object>();
			favmap.put("user_num", info.getMemberIdx());
			favmap.put("mode", "favOnly");
			
			List<CommunityDTO> favList = cservice.managementList(favmap);
			mav.addObject("favList", favList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@GetMapping("management_fav")
	public ModelAndView favoritesList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ModelAndView mav = new ModelAndView("community/management_fav");
	    
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
	    try {
	        Map<String, Object> favmap = new HashMap<String, Object>();
	        favmap.put("user_num", info.getMemberIdx());
	        favmap.put("mode", "favOnly");
	        
	        List<CommunityDTO> favList = cservice.managementList(favmap);
	        mav.addObject("favList", favList);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return mav;
	}
	
	@GetMapping("list")
	public ModelAndView communityList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("community/list");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			List<CommunityDTO> popularTopics = cservice.getPopularCategoryList();
			mav.addObject("categoryList", popularTopics);
			
			List<CommunityDTO> list = cservice.communityList(null, null, info.getMemberIdx());
			mav.addObject("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
	    
	    return mav;
	}
	
	@GetMapping("list_search")
	public ModelAndView communityListAjax(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("community/list_search");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
		try {
			String keyword = req.getParameter("keyword");
			String category_id = req.getParameter("category_id");
			
			List<CommunityDTO> list = cservice.communityList(keyword, category_id, info.getMemberIdx());
			
			mav.addObject("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	    
	    return mav;
	}
	
	@ResponseBody
	@PostMapping("checkFavorite")
	public Map<String, Object> checkFavorite(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			String community_id = req.getParameter("community_id");
			map.put("community_id", community_id);
			map.put("user_num", info.getMemberIdx());
			
			String result = cservice.checkFavorite(map);
			map.put("status", result);
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "error");
		}
		
		return map;
	}
	
	@ResponseBody
	@GetMapping("join")
	public Map<String, Object> joinCommunity(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo)session.getAttribute("member");
	    String community_id = req.getParameter("community_id");
	    
	    try {
	        Map<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("community_id", community_id);
	        paramMap.put("user_num", info.getMemberIdx());
	        
	        cservice.joinCommunity(paramMap);
	        
	        map.put("status", "success");
	        map.put("community_id", community_id); // JS에서 페이지 이동 시 사용
	    } catch (Exception e) {
	        e.printStackTrace();
	        map.put("status", "error");
	    }
	    return map;
	}

	@ResponseBody
	@GetMapping("leave")
	public Map<String, Object> leaveCommunity(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo)session.getAttribute("member");
	    String community_id = req.getParameter("community_id");
	    
	    try {
	        Map<String, Object> paramMap = new HashMap<String, Object>();
	        paramMap.put("community_id", community_id);
	        paramMap.put("user_num", info.getMemberIdx());
	        
	        cservice.removeFavorite(paramMap);
	        cservice.leaveCommunity(paramMap);
	        
	        map.put("status", "success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        map.put("status", "error");
	    }
	    return map;
	}
	
	// 무한 스크롤 시 데이터를 가져오는 '입' 역할 (기존 main 메서드 아래에 추가)
	@GetMapping("postList")
	@ResponseBody // 페이지 이동이 아니라 '데이터'만 보낸다는 뜻
	public Map<String, Object> postList(HttpServletRequest req, HttpServletResponse resp) {
	    Map<String, Object> model = new HashMap<>();
	    try {
	        // 자바스크립트가 보내주는 정보들 받기
	        long communityId = Long.parseLong(req.getParameter("community_id"));
	        String strOffset = req.getParameter("offset");
	        int offset = (strOffset != null) ? Integer.parseInt(strOffset) : 0;
	        String sort = req.getParameter("sort");
	        if(sort == null || sort.isEmpty()) sort = "latest";

	        HttpSession session = req.getSession();
	        SessionInfo info = (SessionInfo)session.getAttribute("member");
	        long userNum = (info != null) ? info.getMemberIdx() : 0L;

	        // DB 조회를 위한 데이터 세팅
	        Map<String, Object> map = new HashMap<>();
	        map.put("community_id", communityId);
	        map.put("user_num", userNum);
	        map.put("sort", sort);
	        map.put("offset", offset);
	        map.put("size", 5);

	        // 데이터 조회
	        List<PostDTO> list = postService.listCommunityPost(map);
	        
	        // 결과 담아서 보내기
	        model.put("list", list);
	        model.put("status", "success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.put("status", "error");
	    }
	    return model; // JSON 형태로 자바스크립트에게 전달됨
	}
	
	@PostMapping("post/write")
	public String communityWriteSubmit(PostDTO dto, HttpServletRequest req, HttpSession session) throws Exception {
	    // 1. 세션에서 유저 번호 꺼내기
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    dto.setUserNum(info.getMemberIdx());
	    dto.setPostType("COMMUNITY");
	    
	    // 2. 파일 업로드 처리 (Cloudinary 등 기존 PostController 로직 사용)
	    // ...
	    
	    // 3. DB 저장 (PostServiceImpl 사용)
	    postService.insertPost(dto); 
	    
	    // 4. 성공 후 해당 커뮤니티로 리다이렉트
	    session.setAttribute("toastMsg", "게시글이 등록되었습니다.");
	    session.setAttribute("toastType", "success");
	    return "redirect:/community/main?community_id=" + dto.getCommunityId();
	}
	
}
