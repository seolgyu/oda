package com.hs.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.model.MemberDTO;
import com.hs.model.PostDTO;
import com.hs.model.ReplyDTO;
import com.hs.model.SessionInfo;
import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.GetMapping;
import com.hs.mvc.annotation.PostMapping;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.annotation.ResponseBody;
import com.hs.mvc.view.ModelAndView;
import com.hs.service.MemberService;
import com.hs.service.MemberServiceImpl;
import com.hs.service.PostService;
import com.hs.service.PostServiceImpl;
import com.hs.service.SettingService;
import com.hs.service.SettingServiceImpl;
import com.hs.util.CloudinaryUtil;
import com.hs.util.FileManager;
import com.hs.util.MyMultipartFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/member/settings")
public class SettingController {
	private MemberService service = new MemberServiceImpl();
	private SettingService settingService = new SettingServiceImpl();
	private PostService postService = new PostServiceImpl();
	
	@RequestMapping("")
	public ModelAndView settings(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
	            return new ModelAndView("redirect:/member/login"); 
	        }
			
			Long userNum = info.getMemberIdx();

			MemberDTO dto = service.findByIdx(userNum);
			
			req.setAttribute("user", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	    return new ModelAndView("member/settings");
	}

    @RequestMapping("profile")
    public String settingsProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
	            return "redirect:/member/login"; 
	        }
			
			Long userNum = info.getMemberIdx();

			MemberDTO dto = service.findByIdx(userNum);
			
			req.setAttribute("user", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        return "member/setting/settings_profile";
    }

    @RequestMapping("account")
    public String settingsAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
	            return "redirect:/member/login"; 
	        }
			
			Long userNum = info.getMemberIdx();

			MemberDTO dto = service.findByIdx(userNum);

			req.setAttribute("user", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "member/setting/settings_account";
    }
    
    @RequestMapping("like")
    public String settingsLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	Long userNum = (Long)info.getMemberIdx();
	        
	        // 1페이지 데이터 조회 (예: 1~10번)
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("offset", 0);
	        map.put("size", 10);
	        
	        List<PostDTO> list = settingService.listLikedPost(map);
	        
	       req.setAttribute("list", list);
	       req.setAttribute("totalCount", settingService.totalCountLikedPost(userNum));
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	
        return "member/setting/settings_like";
    }
    
    @RequestMapping("saved")
    public String settingsSaved(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	Long userNum = (Long)info.getMemberIdx();
	        
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("offset", 0);
	        map.put("size", 10);
	        
	        List<PostDTO> list = settingService.listSavedPost(map);
	        
	       req.setAttribute("list", list);
	       req.setAttribute("totalCount", settingService.totalCountSavedPost(userNum));
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	
        return "member/setting/settings_saved";
    }
    
    @RequestMapping("follow")
    public String settingsFollow(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_follow";
    }
    
    @RequestMapping("comments")
    public String settingsComments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	Long userNum = (Long)info.getMemberIdx();
	        
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("offset", 0);
	        map.put("size", 10);
	        
	        List<ReplyDTO> list = settingService.getMyReply(map);
	        
	       req.setAttribute("list", list);
	       req.setAttribute("totalCount", settingService.totalCountMyComment(userNum));
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	
        return "member/setting/settings_comments";
    }

    @RequestMapping("pwdChange")
    public String settingsPwdChange(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_pwdChange";
    }

    @RequestMapping("privacyScope")
    public String settingsPrivacyScope(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return "member/setting/settings_privacyScope";
    }
    
    @PostMapping("updateAccount")
    @ResponseBody
    public Map<String, Object> updateAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
	        String userNickname = req.getParameter("userNickname");
	        String userName = req.getParameter("userName");
	        
	        if (userNickname != null && !userNickname.equals(info.getUserNickname())) {
	            if (service.checkNickname(userNickname.trim()) > 0) {
	                model.put("status", "duplicate");
	                return model;
	            }
	        }
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userNum", info.getMemberIdx());
			map.put("userName", userName);
			map.put("userNickname", userNickname);
			map.put("birth", req.getParameter("birth"));
			map.put("tel", req.getParameter("tel"));
			map.put("zip", req.getParameter("zip"));
			map.put("addr1", req.getParameter("addr1"));
			map.put("addr2", req.getParameter("addr2"));

			service.updateMember(map);
			
			info.setUserName(userName);
	        info.setUserNickname(userNickname);
	        session.setAttribute("member", info);
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
    
    @PostMapping("updatePwd")
    @ResponseBody
    public Map<String, Object> updatePwd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long userNum = info.getMemberIdx();
			MemberDTO dto = service.findByIdx(userNum);
			
			String currentPwd = req.getParameter("currentPwd");
			String newPwd = req.getParameter("newPwd");
	        
			if (currentPwd == null || newPwd == null || newPwd.trim().isEmpty()) {
	            model.put("status", "error");
	            return model;
	        }
			
			System.out.println("현재 비밀번호 : " + currentPwd);
			System.out.println("가져온 비밀번호 : " + dto.getUserPwd());
	        
	        if (!currentPwd.equals(dto.getUserPwd())) {
	        	model.put("status", "fail");
                return model;
	        }
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userNum", info.getMemberIdx());
			map.put("userPwd", newPwd);

			service.updatePwd(map);
			
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
    
    @PostMapping("updateImages")
    @ResponseBody
    public Map<String, Object> updateImages(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	FileManager fm = new FileManager();
    	
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();
    	
    	String root = req.getServletContext().getRealPath("/");
        String profilePath = root + "uploads" + File.separator + "profile";
        String bannerPath = root + "uploads" + File.separator + "banner";

        try {
        	SessionInfo info = (SessionInfo) session.getAttribute("member");
        	Long userNum = info.getMemberIdx();
        	
        	String isAvatarDeleted = req.getParameter("isAvatarDeleted");
        	String isBannerDeleted = req.getParameter("isBannerDeleted");
        	
        	MemberDTO dto = service.findByIdx(userNum);
						
            Part avatarPart = req.getPart("avatarFile");
            if ("true".equals(isAvatarDeleted)) {
                Map<String, Object> map = new HashMap<>();
                
                map.put("userNum", userNum);
                map.put("userProfile", null);
                
                service.updateProfile(map);
                info.setAvatar(null);
                
                String oldProfile = dto.getProfile_photo();
                if (oldProfile != null && !oldProfile.isEmpty()) {
                    fm.doFiledelete(profilePath, oldProfile);
                }
                
            } else if (avatarPart != null && avatarPart.getSize() > 0) {
                MyMultipartFile mFile = fm.doFileUpload(avatarPart, profilePath);
                if (mFile != null) {
                	Map<String, Object> map = new HashMap<String, Object>();
                    String userProfile = mFile.getSaveFilename();
                    
                    map.put("userNum", userNum);
                    map.put("userProfile", userProfile);
                    
                    service.updateProfile(map);
                    info.setAvatar(userProfile);
                    
                    String oldProfile = dto.getProfile_photo();
                    if (oldProfile != null && !oldProfile.isEmpty()) {
                        fm.doFiledelete(profilePath, oldProfile);
                    }
                }
            }

            Part bannerPart = req.getPart("bannerFile");
            if ("true".equals(isBannerDeleted)) {
                Map<String, Object> map = new HashMap<>();
                
                map.put("userNum", userNum);
                map.put("userBanner", null);
                
                service.updateBanner(map);
                
                String oldBanner = dto.getBanner_photo();
                if (oldBanner != null && !oldBanner.isEmpty()) {
                    fm.doFiledelete(bannerPath, oldBanner);
                }
                
            } else if (bannerPart != null && bannerPart.getSize() > 0) {
                MyMultipartFile mFile = fm.doFileUpload(bannerPart, bannerPath);
                if (mFile != null) {
                	Map<String, Object> map = new HashMap<String, Object>();
                    String userBanner = mFile.getSaveFilename();
                    
                    map.put("userNum", userNum);
                    map.put("userBanner", userBanner);
                    
                    service.updateBanner(map);
                    
                    String oldBanner = dto.getBanner_photo();
                    if (oldBanner != null && !oldBanner.isEmpty()) {
                        fm.doFiledelete(bannerPath, oldBanner);
                    }
                }
            }

            model.put("status", "success");
        } catch (Exception e) {
            e.printStackTrace();
            model.put("status", "error");
        }

        return model;
    }
    
    @PostMapping("updateImagesCloud")
    @ResponseBody
    public Map<String, Object> updateImagesCloud(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        Map<String, Object> model = new HashMap<>();
        HttpSession session = req.getSession();

        String root = req.getServletContext().getRealPath("/");
        String tempPath = root + "temp"; 
        
        File tempDir = new File(tempPath);
        if (!tempDir.exists()) tempDir.mkdirs();

        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            Long userNum = info.getMemberIdx();

            String isAvatarDeleted = req.getParameter("isAvatarDeleted");
            String isBannerDeleted = req.getParameter("isBannerDeleted");

            Part avatarPart = req.getPart("avatarFile");
            
            if ("true".equals(isAvatarDeleted)) {
                Map<String, Object> map = new HashMap<>();
                map.put("userNum", userNum);
                map.put("userProfile", null);

                service.updateProfile(map);
                info.setAvatar(null);
            } else if (avatarPart != null && avatarPart.getSize() > 0) {
                String uploadedUrl = processCloudinaryUpload(avatarPart, tempPath);

                if (uploadedUrl != null) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("userNum", userNum);
                    map.put("userProfile", uploadedUrl);

                    service.updateProfile(map);
                    info.setAvatar(uploadedUrl);
                }
            }

            Part bannerPart = req.getPart("bannerFile");

            if ("true".equals(isBannerDeleted)) {
                Map<String, Object> map = new HashMap<>();
                map.put("userNum", userNum);
                map.put("userBanner", null);

                service.updateBanner(map);

            } else if (bannerPart != null && bannerPart.getSize() > 0) {
                String uploadedUrl = processCloudinaryUpload(bannerPart, tempPath);

                if (uploadedUrl != null) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("userNum", userNum);
                    map.put("userBanner", uploadedUrl);

                    service.updateBanner(map);
                }
            }

            model.put("status", "success");

        } catch (Exception e) {
            e.printStackTrace();
            model.put("status", "error");
        }

        return model;
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
    
    @GetMapping("loadLikedPost")
    @ResponseBody
    public Map<String, Object> loadLikedPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	Map<String, Object> model = new HashMap<String, Object>();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	if (info == null) {
	    		model.put("status", "error");
	    		return model;
	    	}
	    	Long userNum = (Long)info.getMemberIdx();
	    	int pageNo = Integer.parseInt(req.getParameter("page"));	
	    	
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("offset", (pageNo - 1) * 10);
	        map.put("size", 10);
	        
	        List<PostDTO> list = settingService.listLikedPost(map);
	        
	       model.put("list", list);
	       model.put("status", "success");
    	} catch(Exception e) {
    		e.printStackTrace();
    		model.put("status", "error");
    	}
    	
        return model;
    }
    
    @GetMapping("loadSavedPost")
    @ResponseBody
    public Map<String, Object> loadSavedPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	Map<String, Object> model = new HashMap<String, Object>();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	if (info == null) {
	    		model.put("status", "error");
	    		return model;
	    	}
	    	Long userNum = (Long)info.getMemberIdx();
	    	int pageNo = Integer.parseInt(req.getParameter("page"));	
	    	
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("offset", (pageNo - 1) * 10);
	        map.put("size", 10);
	        
	        List<PostDTO> list = settingService.listSavedPost(map);
	        
	       model.put("list", list);
	       model.put("status", "success");
    	} catch(Exception e) {
    		e.printStackTrace();
    		model.put("status", "error");
    	}
    	
        return model;
    }
    
    @PostMapping("toggleLike")
    @ResponseBody
    public Map<String, Object> toggleLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			Long userNum = (Long)info.getMemberIdx();
	        Long postId = Long.parseLong(req.getParameter("postId"));
	        
			postService.insertPostLike(postId, userNum);
			
			int likeCount = postService.countPostLike(postId);
			
			model.put("likeCount", likeCount);
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
    
    @PostMapping("toggleSaved")
    @ResponseBody
    public Map<String, Object> toggleSaved(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Map<String, Object> model = new HashMap<String, Object>();
    	HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			if (info == null) {
				model.put("status", "error");
	            return model;
	        }
			
			// Long userNum = (Long)info.getMemberIdx();
	        // Long postId = Long.parseLong(req.getParameter("postId"));
	        
	        // 수정할 부분
			// postService.insertPostLike(postId, userNum);
			
			// int likeCount = postService.countPostLike(postId);
			
			// model.put("likeCount", likeCount);
			model.put("status", "success");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "error");
		}
		
    	return model;
    }
    
    @GetMapping("loadMyReply")
    @ResponseBody
    public Map<String, Object> loadMyReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	Map<String, Object> model = new HashMap<String, Object>();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	if (info == null) {
	    		model.put("status", "error");
	    		return model;
	    	}
	    	Long userNum = (Long)info.getMemberIdx();
	    	int pageNo = Integer.parseInt(req.getParameter("page"));	
	    	
	        Map<String, Object> map = new HashMap<>();
	        map.put("userNum", userNum);
	        map.put("offset", (pageNo - 1) * 10);
	        map.put("size", 10);
	        
	        List<ReplyDTO> list = settingService.getMyReply(map);
	        
	       model.put("list", list);
	       model.put("status", "success");
    	} catch(Exception e) {
    		e.printStackTrace();
    		model.put("status", "error");
    	}
    	
        return model;
    }
    
    @PostMapping("loadMyPosts")
    @ResponseBody
    public Map<String, Object> loadMyPosts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	Map<String, Object> model = new HashMap<String, Object>();
    	
    	try {
	    	SessionInfo info = (SessionInfo) session.getAttribute("member");
	    	Long loginUserNum = (info != null) ? info.getMemberIdx() : 0L;
	    	
	    	if (info == null) {
	    		model.put("status", "error");
	    		return model;
	    	}
	    	
	    	int pageNo = Integer.parseInt(req.getParameter("page"));
	    	String userId = req.getParameter("userId");
	    	
	    	MemberDTO dto = service.findById(userId);
	    	
	        Map<String, Object> map = new HashMap<>();
	        map.put("loginUserNum", loginUserNum);
	        map.put("userNum", dto.getUserIdx());
	        map.put("offset", (pageNo - 1) * 5);
	        map.put("size", 5);
	        
	        List<PostDTO> list = postService.listUserPost(map);
	        
	       model.put("user", dto);
	       model.put("list", list);
	       model.put("status", "success");
    	} catch(Exception e) {
    		e.printStackTrace();
    		model.put("status", "error");
    	}
    	
        return model;
    }
    
}
