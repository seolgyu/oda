package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.mapper.NotificationMapper;
import com.hs.model.NotificationDTO;
import com.hs.mybatis.support.MapperContainer;

public class NotificationServiceImpl implements NotificationService {
	
	private static NotificationService instance = new NotificationServiceImpl();
    
    private NotificationServiceImpl() {}

    public static NotificationService getInstance() {
        return instance;
    }
	
	private NotificationMapper mapper = MapperContainer.get(NotificationMapper.class);
	
	private MemberService memberService = new MemberServiceImpl();
	private PostService postService = new PostServiceImpl();

	@Override
	public List<NotificationDTO> listNotification(Long userNum) throws Exception {
		List<NotificationDTO> list = null;
		try {
			list = mapper.listNotification(userNum);
			
			for(NotificationDTO item : list) {
				String type = item.getType();
				
				switch (type) {
		        case "FOLLOW":
		        	item.setFromUserInfo(memberService.findByIdx(item.getFromUserNum()));
		            break;
		            
		        case "POST_LIKE":
		        	Long target = Long.parseLong(item.getTarget());
		        	item.setTarget("/member/page?id=" + item.getTarget());
		        	item.setFromUserInfo(memberService.findByIdx(item.getFromUserNum()));
		        	item.setTargetPost(postService.findById(target));
		            break;
		            
		        case "COMMENT":
		            break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<NotificationDTO> listAllNotification(Map<String, Object> map) throws Exception {
		List<NotificationDTO> list = null;
		try {
			list = mapper.listAllNotification(map);
			
			for(NotificationDTO item : list) {
				String type = item.getType();
				
				switch (type) {
		        case "FOLLOW":
		        	item.setFromUserInfo(memberService.findByIdx(item.getFromUserNum()));
		            break;
		            
		        case "POST_LIKE":
		        	Long target = Long.parseLong(item.getTarget());
		        	item.setTarget("/member/page?id=" + item.getTarget());
		        	item.setFromUserInfo(memberService.findByIdx(item.getFromUserNum()));
		        	item.setTargetPost(postService.findById(target));
		            break;
		            
		        case "COMMENT":
		            break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertNotification(Map<String, Object> map) throws Exception {
		
		if(map.get("fromUserNum").equals(map.get("toUserNum"))) {
			return;
		}
		
		String type = (String) map.get("type");
	    String content = "";

	    switch (type) {
	        case "FOLLOW":
	            content = "님이 회원님을 팔로우하기 시작했습니다.";
	            break;
	            
	        case "POST_LIKE":
	            content = "님이 회원님의 게시글을 좋아합니다.";
	            break;
	            
	        case "COMMENT":
	            content = "님이 게시글에 댓글을 남겼습니다.";
	            break;
	    }

	    map.put("content", content);
		try {
			mapper.insertNotification(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateChecked(Long notiId) throws Exception {
		try {
			mapper.updateChecked(notiId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateCheckedAll(Long userNum) throws Exception {
		try {
			mapper.updateCheckedAll(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteNotification(Long notiId) throws Exception {
		try {
			mapper.deleteNotification(notiId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOldNotification(Long userNum) throws Exception {
		try {
			mapper.deleteOldNotification(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int getUncheckedCount(Long userNum) throws Exception {
		try {
			return mapper.getUncheckedCount(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

}
