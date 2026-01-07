package com.hs.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.hs.model.FileAtDTO;
import com.hs.model.MemberDTO;
import com.hs.model.PostDTO;
import com.hs.model.SessionInfo;
import com.hs.util.FileManager; // 기존 파일매니저 import
import com.hs.util.MyMultipartFile; // 기존 파일매니저의 인터페이스 import
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.MemberService;
import com.hs.service.MemberServiceImpl;
import com.hs.service.PostService;
import com.hs.service.PostServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/post/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB (메모리 임계값)
    maxFileSize = 1024 * 1024 * 30,       // 30MB (개별 파일 최대)
    maxRequestSize = 1024 * 1024 * 50     // 50MB (전체 요청 최대)
)
public class PostController {
	
	// Spring이 아니므로 직접 객체 생성
	private PostService service = new PostServiceImpl();
	private MemberService memberservice = new MemberServiceImpl();

	// 1. 글쓰기 폼 (GET)
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		ModelAndView mav = new ModelAndView("post/write");
		mav.addObject("mode", "write");
		return mav;
	}

	// 2. 글 등록 처리 (POST)
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			PostDTO dto = new PostDTO();
			
			// [1] 일반 파라미터 받기
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			// 공지사항 처리
			String isNotice = req.getParameter("isNotice");
			dto.setPostType(isNotice != null ? "NOTICE" : "COMMUNITY");
			
			// 댓글 기능 해제 처리
			String chkReply = req.getParameter("chkReply");
			dto.setReplyEnabled(chkReply != null ? "0" : "1"); 

			// 좋아요/조회수 숨기기 처리
			String chkCounts = req.getParameter("chkCounts");
			dto.setShowCounts(chkCounts != null ? "0" : "1");
			
			dto.setUserNum(info.getMemberIdx()); 
			dto.setState("정상");

			// [2] 파일 업로드 처리 (기존 FileManager 활용)
			FileManager fileManager = new FileManager();
			
			// 저장 경로 설정 (webapp/uploads/photo)
			String root = req.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "photo";
			
			// input type="file"의 name="selectFile"인 파트들을 포함하여 모든 파트 수집
			Collection<Part> parts = req.getParts();
			
			// FileManager를 통해 실제 파일 저장 및 정보 획득
			List<MyMultipartFile> uploadedFiles = fileManager.doFileUpload(parts, pathname);
			
			// [3] MyMultipartFile -> FileAtDTO 변환
			List<FileAtDTO> fileList = new ArrayList<>();
			if(uploadedFiles != null && !uploadedFiles.isEmpty()) {
				int order = 0;
				for(MyMultipartFile mf : uploadedFiles) {
					FileAtDTO fileDto = new FileAtDTO();
					fileDto.setFileName(mf.getOriginalFilename()); // 원본명
					fileDto.setFilePath(mf.getSaveFilename());     // 저장명
					fileDto.setFileSize(mf.getSize());             // 사이즈
					fileDto.setFileOrder(order++);                 // 순서
					
					// 파일 타입 추출 (확장자 기반)
					String originalName = mf.getOriginalFilename();
					String ext = originalName.substring(originalName.lastIndexOf(".") + 1);
					fileDto.setFileType(ext); 
					
					fileList.add(fileDto);
				}
			}
			
			// DTO에 파일 리스트 담기
			dto.setFileList(fileList);

			// [4] 서비스 호출
			service.insertPost(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/post/list");
	}

	// 3. 수정 폼 (GET)
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			long postId = Long.parseLong(req.getParameter("postId"));
			
			PostDTO dto = service.findById(postId);
			
			if(dto == null || dto.getUserNum() != info.getMemberIdx()) {
				return new ModelAndView("redirect:/post/list");
			}
			
			ModelAndView mav = new ModelAndView("post/write");
			mav.addObject("dto", dto);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/post/list");
	}

	// 4. 수정 처리 (POST)
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			PostDTO dto = new PostDTO();
			
			dto.setPostId(Long.parseLong(req.getParameter("postId")));
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			String isNotice = req.getParameter("isNotice");
			dto.setPostType(isNotice != null ? "NOTICE" : "COMMUNITY");
			
			String chkReply = req.getParameter("chkReply");
			dto.setReplyEnabled(chkReply != null ? "0" : "1");

			String chkCounts = req.getParameter("chkCounts");
			dto.setShowCounts(chkCounts != null ? "0" : "1");
			
			dto.setState("정상");
			dto.setUserNum(info.getMemberIdx());
			
			service.updatePost(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/post/list");
	}
	
	// 5. 게시글 리스트
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("post/list");
		
		List<PostDTO> list = service.listPost();
		
		mav.addObject("list", list);
		
		return mav;
	}
	
	// 6. 게시글 상세 보기 (GET)
	@GetMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // 1. 파라미터 받기
	    String page = req.getParameter("page");
	    long postId = 0;
	    
	    try {
	        String postIdStr = req.getParameter("postId");
	        if(postIdStr != null) {
	            postId = Long.parseLong(postIdStr);
	        }
	    } catch (Exception e) {
	        return new ModelAndView("redirect:/post/list");
	    }

	    // 2. 서비스 호출 (조회수 증가 + 파일 리스트 포함된 DTO 리턴)
	    PostDTO dto = service.findById(postId);
	    
	    if(dto == null) {
	        return new ModelAndView("redirect:/post/list?page=" + page);
	    }	    
	    
	    MemberDTO memberdto = memberservice.findByIdx(dto.getUserNum());
	    
	    ModelAndView mav = new ModelAndView("post/article");
	    mav.addObject("dto", dto);
	    mav.addObject("memberdto", memberdto);
	    mav.addObject("page", page);
	    
	    return mav;
	}
}