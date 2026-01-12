package com.hs.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

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
		// 로그인 여부와 상관없이 리스트는 볼 수 있음 (단, 좋아요 여부는 로그인 유저 기준)
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		long userNum = 0;
		if (info != null) {
			userNum = info.getMemberIdx();
		}

		long postId = Long.parseLong(req.getParameter("postId"));

		// 서비스에서 댓글 목록 가져오기 (계층형으로 정렬됨)
		List<CommentDTO> list = service.listComment(postId, userNum);

		// 댓글 목록만 뿌려줄 전용 JSP 페이지로 포워딩
		ModelAndView mav = new ModelAndView("post/listReply");
		mav.addObject("listReply", list);

		// 게시글 작성자 번호도 넘기면 좋음 (댓글 삭제 권한 체크용)
		// mav.addObject("postUserNum", ...);

		return mav;
	}

	// 4. 댓글 삭제 (AJAX)
	@PostMapping("deleteReply")
	public void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// 본인 확인 로직 필요
		try {
			long commentId = Long.parseLong(req.getParameter("commentId"));
			service.deleteComment(commentId);
			resp.getWriter().print("success");
		} catch (Exception e) {
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

}