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
import com.hs.model.ReportDTO;
import com.hs.model.SessionInfo;
import com.hs.util.CloudinaryUtil;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.MemberService;
import com.hs.service.MemberServiceImpl;
import com.hs.service.NotificationService;
import com.hs.service.NotificationServiceImpl;
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
		fileSizeThreshold = 1024 * 1024 * 2, 
		maxFileSize = 1024 * 1024 * 200,
		maxRequestSize = 1024 * 1024 * 300 
)
public class PostController {

	private PostService service = new PostServiceImpl();
	private MemberService memberservice = new MemberServiceImpl();
	private NotificationService notiService = NotificationServiceImpl.getInstance();

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
		
		String communityId = req.getParameter("community_id");
	    String comName = req.getParameter("com_name");
	    
	    mav.addObject("communityId", communityId);
	    mav.addObject("com_name", comName);
		mav.addObject("mode", "write");
		return mav;
	}

	// 2. 글 등록 처리 (POST) 
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
			
			String communityId = req.getParameter("community_id");
	        if(communityId != null && !communityId.isEmpty()) {
	            dto.setCommunityId(Long.parseLong(communityId));
	            dto.setPostType("COMMUNITY");
	        } else {
	            dto.setPostType("PERSONAL"); // 마이피드
	        }

			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));

			String chkReply = req.getParameter("chkReply");
			dto.setReplyEnabled(chkReply != null ? "0" : "1");

			String chkLikes = req.getParameter("chkLikes");
			dto.setShowLikes(chkLikes != null ? "0" : "1");

			String chkViews = req.getParameter("chkViews");
			dto.setShowViews(chkViews != null ? "0" : "1");
			
			String chkPrivate = req.getParameter("chkPrivate");
			if (chkPrivate != null) {
			    dto.setState("나만보기");
			} else {
			    dto.setState("정상");
			}
			
			dto.setUserNum(info.getMemberIdx());
			

			List<FileAtDTO> fileList = new ArrayList<>();
			String root = req.getServletContext().getRealPath("/");
			String tempPath = root + "temp";

			File tempDir = new File(tempPath);
			if (!tempDir.exists())
				tempDir.mkdirs(); 

			Collection<Part> parts = req.getParts();
			int order = 0;

			for (Part part : parts) {
				
				if (part.getName().equals("selectFile") && part.getSize() > 0 && part.getSubmittedFileName() != null
						&& !part.getSubmittedFileName().trim().isEmpty()) {

					String originalFileName = part.getSubmittedFileName();
					File tempFile = new File(tempPath, originalFileName);
					part.write(tempFile.getAbsolutePath());

					
					String uploadedUrl = CloudinaryUtil.uploadFile(tempFile);

					if (uploadedUrl != null) {
						FileAtDTO fileDto = new FileAtDTO();
						fileDto.setFileName(originalFileName);
						fileDto.setFilePath(uploadedUrl); 
						fileDto.setFileSize(part.getSize());
						fileDto.setFileOrder(order++);
		
						String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
						fileDto.setFileType(ext);

						fileList.add(fileDto);
					}

					if (tempFile.exists()) {
						tempFile.delete();
					}
				}
			}

			dto.setFileList(fileList);
			
			service.insertPost(dto);
			
		    session.setAttribute("toastMsg", "새로운 게시글이 등록되었습니다.");
		    session.setAttribute("toastType", "success");
		    
		    if(dto.getCommunityId() != null) {
	            return new ModelAndView("redirect:/community/main?community_id=" + dto.getCommunityId());
	        }

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
			
			String communityId = req.getParameter("communityId");
	        if(communityId != null && !communityId.isEmpty()) {
	            dto.setCommunityId(Long.parseLong(communityId));
	            dto.setPostType("COMMUNITY");
	        } else {
	        	dto.setPostType("PERSONAL");
	        }
	        
			String chkReply = req.getParameter("chkReply");
			dto.setReplyEnabled(chkReply != null ? "0" : "1");
			
			String chkLikes = req.getParameter("chkLikes");
			dto.setShowLikes(chkLikes != null ? "0" : "1");

			String chkViews = req.getParameter("chkViews");
			dto.setShowViews(chkViews != null ? "0" : "1");

			String chkPrivate = req.getParameter("chkPrivate");
			if (chkPrivate != null) {
			    dto.setState("나만보기");
			} else {
			    dto.setState("정상");
			}
			
			dto.setUserNum(info.getMemberIdx());

			
			String[] delFiles = req.getParameterValues("delfile");
			if (delFiles != null && delFiles.length > 0) {
				for (String fileIdStr : delFiles) {
					long fileId = Long.parseLong(fileIdStr);
					service.deleteFileAt(fileId);
				}
			}
			
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

					String uploadedUrl = CloudinaryUtil.uploadFile(tempFile);

					if (uploadedUrl != null) {
						FileAtDTO fileDto = new FileAtDTO();
						fileDto.setFileName(originalFileName);
						fileDto.setFilePath(uploadedUrl);
						fileDto.setFileSize(part.getSize());

						String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
						fileDto.setFileType(ext);

						fileList.add(fileDto);
					}
					if (tempFile.exists())
						tempFile.delete();
				}
			}
			dto.setFileList(fileList);

			service.updatePost(dto); 
			
			
		    session.setAttribute("toastMsg", "게시글이 성공적으로 수정되었습니다.");
		    session.setAttribute("toastType", "success");
		    
		    if(dto.getCommunityId() != null) {
	            return new ModelAndView("redirect:/community/main?community_id=" + dto.getCommunityId());
	        }

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
		
		long postId = 0;

		try {
			String postIdStr = req.getParameter("postId");
			if (postIdStr != null) {
				postId = Long.parseLong(postIdStr);
			}
		} catch (Exception e) {
		
			return new ModelAndView("redirect:/main");
		}

		PostDTO dto = service.findById(postId);
		
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
		mav.addObject("listFile", dto.getFileList());
		
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

			PostDTO dto = service.findById(postId);
			if (dto != null && dto.getUserNum() == info.getMemberIdx()) {
				service.deletePost(postId); // 서비스 호출
				
		        session.setAttribute("toastMsg", "게시글이 삭제되었습니다.");
		        session.setAttribute("toastType", "success");
		        
		        if (dto.getCommunityId() != null && dto.getCommunityId() != 0) {
	                return new ModelAndView("redirect:/community/main?community_id=" + dto.getCommunityId());
	            }
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

			boolean liked = service.insertPostLike(postId, info.getMemberIdx());
			
			PostDTO dto = service.findById(postId);
			
			Long userNum = info.getMemberIdx();
			Long authorUserNum = dto.getUserNum();
			
			if(liked) {
				Map<String, Object> noti = new HashMap<String, Object>();
				noti.put("fromUserNum", userNum);
				noti.put("toUserNum", authorUserNum);
				noti.put("type", "POST_LIKE");
				noti.put("target", postId);
				
				notiService.insertNotification(noti);
			}

			int likeCount = service.countPostLike(postId); 

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
			dto.setUserId(info.getUserId());
			
			Map<String, Object> noti = new HashMap<String, Object>();

			String parentId = req.getParameter("parentCommentId");
			if (parentId != null && !parentId.isEmpty()) {
				dto.setParentCommentId(Long.parseLong(parentId));
				noti.put("type", "REPLY");
				noti.put("toUserNum", service.getCommentWriterNum(Long.parseLong(parentId)));
			} else {
				noti.put("type", "COMMENT");
				noti.put("toUserNum", service.getPostAuthorNum(Long.parseLong(req.getParameter("postId"))));
			}

			service.insertComment(dto);
			
			noti.put("fromUserNum", info.getMemberIdx());
			noti.put("target", dto.getCommentId());
			
			if (!info.getMemberIdx().equals(noti.get("toUserNum"))) {
				notiService.insertNotification(noti);
		    }
			
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

		List<CommentDTO> list = service.listComment(postId, userNum);

		long commentCount = 0;
		if (list != null) {
			
			commentCount = list.stream().filter(dto -> "0".equals(dto.getIsDeleted())).count();
		}

		ModelAndView mav = new ModelAndView("post/listReply");
		mav.addObject("listReply", list);
		mav.addObject("commentCount", commentCount); 

		return mav;
	}

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
			dto.setUserNum(info.getMemberIdx()); 

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

			boolean liked = service.insertCommentLike(commentId, info.getMemberIdx());

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
	
	// 무한 스크롤용 데이터 로드 
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
        
        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";
        
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
        map.put("keyword", keyword);
        
        List<PostDTO> list = service.listPostMain(map);
        
        ModelAndView mav = new ModelAndView("post/listPostData"); 
        mav.addObject("list", list);
        mav.addObject("viewMode", view);
        
        return mav;
    }
    
    @PostMapping("report")
    public void reportSubmit(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
            String reason = req.getParameter("reason");

            ReportDTO dto = new ReportDTO();
            dto.setReportUserNum(info.getMemberIdx());
            dto.setReportReason(reason);
            dto.setReportType("POST");
            dto.setReportContent(String.valueOf(postId));

            service.insertReport(dto); 

            jobj.put("state", "success");

        } catch (Exception e) {
            e.printStackTrace();
            jobj.put("state", "error");
        }

        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().print(jobj.toString());
    }
    
 
    @PostMapping("tempSave")
    public void tempSave(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
            PostDTO dto = new PostDTO();
            dto.setUserNum(info.getMemberIdx());
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setPostType("COMMUNITY"); 
            dto.setState("임시저장"); 
            
            dto.setReplyEnabled("1");
            dto.setShowLikes("1");
            dto.setShowViews("1");

            service.saveTempPost(dto); 

            jobj.put("state", "success");

        } catch (Exception e) {
            e.printStackTrace();
            jobj.put("state", "error");
        }

        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().print(jobj.toString());
    }

   
    @PostMapping("loadTemp")
    public void loadTemp(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        JSONObject jobj = new JSONObject();

        if (info == null) {
            jobj.put("state", "login_required");
            resp.getWriter().print(jobj.toString());
            return;
        }

        try {
            PostDTO dto = service.findTempPost(info.getMemberIdx());

            if (dto != null) {
                jobj.put("state", "success");
                jobj.put("title", dto.getTitle());
                jobj.put("content", dto.getContent());
            } else {
                jobj.put("state", "not_found"); 
            }

        } catch (Exception e) {
            e.printStackTrace();
            jobj.put("state", "error");
        }

        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().print(jobj.toString());
    }
	
    // 게시글 저장 기능 (AJAX)
    @PostMapping("insertPostSave")
    public void insertPostSave(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
 
            boolean saved = service.insertPostSave(postId, info.getMemberIdx());

            jobj.put("state", "success");
            jobj.put("saved", saved);

        } catch (Exception e) {
            e.printStackTrace();
            jobj.put("state", "error");
        }

        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().print(jobj.toString());
    }

    // 게시글 리그렘 기능 (AJAX)
    @PostMapping("insertPostRepost")
    public void insertPostRepost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
 
            boolean reposted = service.insertPostRepost(postId, info.getMemberIdx());

            jobj.put("state", "success");
            jobj.put("reposted", reposted);

        } catch (Exception e) {
            e.printStackTrace();
            jobj.put("state", "error");
        }

        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().print(jobj.toString());
    }
}