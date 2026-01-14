package com.hs.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.hs.model.CommentDTO;
import com.hs.model.FileAtDTO;
import com.hs.model.MemberDTO;
import com.hs.model.PostDTO;
import com.hs.model.SessionInfo;
import com.hs.util.CloudinaryUtil;
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
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB (메모리 임계값)
		maxFileSize = 1024 * 1024 * 30, // 30MB (개별 파일 최대)
		maxRequestSize = 1024 * 1024 * 50 // 50MB (전체 요청 최대)
)
public class PostController {

	// Spring이 아니므로 직접 객체 생성
	private PostService service = new PostServiceImpl();
	private MemberService memberservice = new MemberServiceImpl();

	// 1. 글쓰기 폼 (GET)
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		ModelAndView mav = new ModelAndView("post/write");
		mav.addObject("mode", "write");
		return mav;
	}

	// 2. 글 등록 처리 (POST) - Cloudinary 적용됨
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
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

			dto.setPostType("COMMUNITY");

			// 댓글 기능 해제 처리
			String chkReply = req.getParameter("chkReply");
			dto.setReplyEnabled(chkReply != null ? "0" : "1");

			// 좋아요/조회수 숨기기 처리
			String chkCounts = req.getParameter("chkCounts");
			dto.setShowCounts(chkCounts != null ? "0" : "1");

			dto.setUserNum(info.getMemberIdx());
			dto.setState("정상");

			// [2] 파일 업로드 처리 (Cloudinary 연동)
			List<FileAtDTO> fileList = new ArrayList<>();
			String root = req.getServletContext().getRealPath("/");
			String tempPath = root + "temp"; // 임시 저장 경로

			File tempDir = new File(tempPath);
			if (!tempDir.exists())
				tempDir.mkdirs(); // 폴더 없으면 생성

			Collection<Part> parts = req.getParts();
			int order = 0;

			for (Part part : parts) {
				// name이 "selectFile"이고 실제 파일 데이터가 있는 경우만 처리
				if (part.getName().equals("selectFile") && part.getSize() > 0 && part.getSubmittedFileName() != null
						&& !part.getSubmittedFileName().trim().isEmpty()) {

					// 1. 임시 파일로 저장
					String originalFileName = part.getSubmittedFileName();
					File tempFile = new File(tempPath, originalFileName);
					part.write(tempFile.getAbsolutePath());

					// 2. Cloudinary로 전송 및 URL 획득
					String uploadedUrl = CloudinaryUtil.uploadFile(tempFile);

					if (uploadedUrl != null) {
						FileAtDTO fileDto = new FileAtDTO();
						fileDto.setFileName(originalFileName);
						fileDto.setFilePath(uploadedUrl); // ★ 이제 여기에 https://... 주소가 들어갑니다.
						fileDto.setFileSize(part.getSize());
						fileDto.setFileOrder(order++);

						// 확장자 추출
						String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
						fileDto.setFileType(ext);

						fileList.add(fileDto);
					}

					// 3. 임시 파일 삭제 (서버 용량 확보)
					if (tempFile.exists()) {
						tempFile.delete();
					}
				}
			}

			// DTO에 파일 리스트 담기
			dto.setFileList(fileList);

			// [3] 서비스 호출
			service.insertPost(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/main");
	}

	// 3. 수정 폼 (GET)
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			long postId = Long.parseLong(req.getParameter("postId"));

			PostDTO dto = service.findById(postId);

			if (dto == null || dto.getUserNum() != info.getMemberIdx()) {
				return new ModelAndView("redirect:/main");
			}

			ModelAndView mav = new ModelAndView("post/write");
			mav.addObject("dto", dto);
			mav.addObject("mode", "update");

			return mav;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/main");
	}

	// 4. 수정 처리 (POST)
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
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
			dto.setPostType("COMMUNITY");

			String chkReply = req.getParameter("chkReply");
			dto.setReplyEnabled(chkReply != null ? "0" : "1");

			String chkCounts = req.getParameter("chkCounts");
			dto.setShowCounts(chkCounts != null ? "0" : "1");

			dto.setState("정상");
			dto.setUserNum(info.getMemberIdx());

			// 삭제할 파일 처리 (delfile 파라미터가 여러 개 올 수 있음)
			String[] delFiles = req.getParameterValues("delfile");
			if (delFiles != null && delFiles.length > 0) {
				for (String fileIdStr : delFiles) {
					long fileId = Long.parseLong(fileIdStr);
					service.deleteFileAt(fileId); // ★ Service에 이 메서드 추가 필요
				}
			}
			// [추가] 새로운 파일 업로드 처리 (기존 파일 뒤에 이어붙이기)
			List<FileAtDTO> fileList = new ArrayList<>();
			String root = req.getServletContext().getRealPath("/");
			String tempPath = root + "temp";

			File tempDir = new File(tempPath);
			if (!tempDir.exists())
				tempDir.mkdirs();

			Collection<Part> parts = req.getParts();

			for (Part part : parts) {
				if (part.getName().equals("selectFile") && part.getSize() > 0 && part.getSubmittedFileName() != null
						&& !part.getSubmittedFileName().trim().isEmpty()) {

					String originalFileName = part.getSubmittedFileName();
					File tempFile = new File(tempPath, originalFileName);
					part.write(tempFile.getAbsolutePath());

					// Cloudinary 업로드
					String uploadedUrl = CloudinaryUtil.uploadFile(tempFile);

					if (uploadedUrl != null) {
						FileAtDTO fileDto = new FileAtDTO();
						fileDto.setFileName(originalFileName);
						fileDto.setFilePath(uploadedUrl);
						fileDto.setFileSize(part.getSize());
						// fileOrder는 Service에서 처리하는 게 안전함

						String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
						fileDto.setFileType(ext);

						fileList.add(fileDto);
					}
					if (tempFile.exists())
						tempFile.delete();
				}
			}
			dto.setFileList(fileList);

			service.updatePost(dto); // Service 내부에서 파일 저장 처리

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/main");
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
		// 1. 파라미터 받기 (page 변수 삭제함)
		long postId = 0;

		try {
			String postIdStr = req.getParameter("postId");
			if (postIdStr != null) {
				postId = Long.parseLong(postIdStr);
			}
		} catch (Exception e) {
			// [수정] 에러 발생 시 그냥 리스트 첫 화면으로 이동
			return new ModelAndView("redirect:/main");
		}

		// 2. 서비스 호출
		PostDTO dto = service.findById(postId);

		// [수정] 게시글이 없을 경우 리스트 첫 화면으로 이동 (page 파라미터 제거)
		if (dto == null) {
			return new ModelAndView("redirect:/main");
		}

		MemberDTO memberdto = memberservice.findByIdx(dto.getUserNum());

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info != null) {
			boolean liked = service.isLiked(postId, info.getMemberIdx());
			dto.setLikedByUser(liked);
		}

		ModelAndView mav = new ModelAndView("post/article");
		mav.addObject("dto", dto);
		mav.addObject("memberdto", memberdto);

		return mav;
	}

	// 7. 게시글 삭제 (GET)
	@GetMapping("delete")
	public ModelAndView deletePost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			long postId = Long.parseLong(req.getParameter("postId"));

			// 본인 확인 (Service에서 체크하거나 여기서 체크)
			PostDTO dto = service.findById(postId);
			if (dto != null && dto.getUserNum() == info.getMemberIdx()) {
				service.deletePost(postId); // 서비스 호출
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/main");
	}

	// 1. 게시글 좋아요 (AJAX)
	@PostMapping("insertPostLike")
	public void insertPostLike(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		JSONObject jobj = new JSONObject();

		if (info == null) {
			jobj.put("state", "login_required");
			resp.setContentType("application/json; charset=UTF-8");
			resp.getWriter().print(jobj.toString());
			return;
		}

		try {
			long postId = Long.parseLong(req.getParameter("postId"));

			// 서비스 호출 (토글 수행)
			boolean liked = service.insertPostLike(postId, info.getMemberIdx());

			// 변경된 좋아요 개수 가져오기
			int likeCount = service.countPostLike(postId); // 서비스/매퍼에 메소드 필요

			jobj.put("state", "success");
			jobj.put("liked", liked); // true: 핑크 하트, false: 빈 하트
			jobj.put("likeCount", likeCount);

		} catch (Exception e) {
			e.printStackTrace();
			jobj.put("state", "error");
		}

		resp.setContentType("application/json; charset=UTF-8");
		resp.getWriter().print(jobj.toString());
	}

	// 2. 댓글 등록 (AJAX)
	@PostMapping("insertReply")
	public void insertReply(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			resp.getWriter().print("login_required");
			return;
		}

		try {
			CommentDTO dto = new CommentDTO();
			dto.setPostId(Long.parseLong(req.getParameter("postId")));
			dto.setContent(req.getParameter("content"));
			dto.setUserNum(info.getMemberIdx());
			dto.setUserId(info.getUserId()); // 세션에서 아이디 가져옴

			// 대댓글인 경우 부모 ID 설정
			String parentId = req.getParameter("parentCommentId");
			if (parentId != null && !parentId.isEmpty()) {
				dto.setParentCommentId(Long.parseLong(parentId));
			}

			service.insertComment(dto);

			resp.getWriter().print("success");

		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().print("error");
		}
	}

	// 3. 댓글 리스트 (AJAX - HTML 조각 리턴)
	@GetMapping("listReply")
	public ModelAndView listReply(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		long userNum = 0;
		if (info != null) {
			userNum = info.getMemberIdx();
		}

		long postId = Long.parseLong(req.getParameter("postId"));

		// 1. 댓글 목록 가져오기
		List<CommentDTO> list = service.listComment(postId, userNum);

		// 2. [추가] 삭제되지 않은('0') 댓글 개수 계산 (화면 갱신용)
		long commentCount = 0;
		if (list != null) {
			// Java Stream을 이용해 isDeleted가 "0"인 것만 카운트
			commentCount = list.stream().filter(dto -> "0".equals(dto.getIsDeleted())).count();
		}

		ModelAndView mav = new ModelAndView("post/listReply");
		mav.addObject("listReply", list);
		mav.addObject("commentCount", commentCount); // ★ 댓글 개수 전달

		return mav;
	}

	// 4. 댓글 삭제 (AJAX)
	@PostMapping("deleteReply")
	public void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			resp.getWriter().print("login_required");
			return;
		}

		try {
			long commentId = Long.parseLong(req.getParameter("commentId"));

			// 본인 확인을 위해 userNum도 함께 전달 (Service 인터페이스 수정 필요 시 반영)
			service.deleteComment(commentId, info.getMemberIdx());

			resp.getWriter().print("success");
		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().print("error");
		}
	}

	@PostMapping("updateReply")
	public void updateReply(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			resp.getWriter().print("login_required");
			return;
		}

		try {
			CommentDTO dto = new CommentDTO();
			dto.setCommentId(Long.parseLong(req.getParameter("commentId")));
			dto.setContent(req.getParameter("content"));
			dto.setUserNum(info.getMemberIdx()); // 본인만 수정 가능하도록 DTO에 담음

			service.updateComment(dto);

			resp.getWriter().print("success");
		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().print("error");
		}
	}

	// 5. 댓글 좋아요 (AJAX)
	@PostMapping("insertCommentLike")
	public void insertCommentLike(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		JSONObject jobj = new JSONObject();

		if (info == null) {
			jobj.put("state", "login_required");
			resp.setContentType("application/json; charset=UTF-8");
			resp.getWriter().print(jobj.toString());
			return;
		}

		try {
			long commentId = Long.parseLong(req.getParameter("commentId"));

			// 서비스 호출 (토글 수행)
			boolean liked = service.insertCommentLike(commentId, info.getMemberIdx());

			// 변경된 좋아요 개수 가져오기 (화면 갱신용)
			int likeCount = 0;
			try {

				likeCount = service.countCommentLike(commentId);

			} catch (Exception e) {
				e.printStackTrace();
			}

			jobj.put("state", "success");
			jobj.put("liked", liked);
			jobj.put("likeCount", likeCount);

		} catch (Exception e) {
			e.printStackTrace();
			jobj.put("state", "error");
		}

		resp.setContentType("application/json; charset=UTF-8");
		resp.getWriter().print(jobj.toString());
	}
	
	// 무한 스크롤용 데이터 로드 (HTML 조각 리턴)
    @GetMapping("listPostAjax")
    public ModelAndView listPostAjax(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        long userNum = (info != null) ? info.getMemberIdx() : 0;
        
        // 파라미터 받기
        String sort = req.getParameter("sort");
        if (sort == null || sort.isEmpty()) sort = "latest";
        
        String view = req.getParameter("view");
        if (view == null || view.isEmpty()) view = "card";
        
        int page = 1;
        String pageStr = req.getParameter("page");
        
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1; 
            }
        }

        int size = "compact".equals(view) ? 15 : 10;
        int offset = (page - 1) * size;

        Map<String, Object> map = new HashMap<>();
        map.put("sort", sort);
        map.put("userNum", userNum);
        map.put("offset", offset);
        map.put("size", size);
        
        List<PostDTO> list = service.listPostMain(map);
        
        ModelAndView mav = new ModelAndView("post/listPostData"); 
        mav.addObject("list", list);
        mav.addObject("viewMode", view);
        
        return mav;
    }
	
}