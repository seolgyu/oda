package com.hs.service.admin;

import java.util.List;
import java.util.Map;


import com.hs.model.admin.EventDTO;
import com.hs.model.admin.EventReplyDTO;

public interface EventService {
	// 이벤트 등록
	public void insertEvent(EventDTO dto) throws Exception;
	// 이벤트 수정
	public void updateEvent(EventDTO dto) throws Exception;
	// 이벤트 삭제(1개씩)
	public void deleteEvent(long event_num) throws Exception;
	// 이벤트 삭제(1개 이상)
	public void deleteListEvent(List<Long> list) throws Exception;
	
	// 데이터 개수(한페이지 출력시 사용)
	public int dataCount(Map<String, Object> map);
	
	// 리스트 첫줄
	public List<EventDTO> listEventTop();
	public List<EventDTO> listEvent(Map<String, Object> map);
	
	// 
	public EventDTO findById(long event_num);
	// 이전글
	public EventDTO findByPrev(Map<String, Object> map);
	// 다음글
	public EventDTO findByNext(Map<String, Object> map);
	// 조회수
	public void updateHitCount(long num) throws Exception;
	

	// 첨부파일 삭제
	public void deleteEventFile(Long file_at_id) throws Exception;
	
	public List<EventDTO> listEventFile(long num);
	EventDTO findByFileId(long fileid);

	
	public boolean isUserBoardLiked(Map<String, Object> map);
	public void insertBoardLike(Map<String, Object> map) throws Exception;
	public void deleteBoardLike(Map<String, Object> map) throws Exception;
	public int boardLikeCount(long num);
	
	public void insertReply(EventReplyDTO dto) throws Exception;
	public void deleteReply(Map<String, Object> map) throws Exception;
	public int replyCount(Map<String, Object> map);
	public List<EventReplyDTO> listReply(Map<String, Object> map);
	public List<EventReplyDTO> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	public void updateReplyShowHide(Map<String, Object> map);
	
	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public Map<String, Object> replyLikeCount(Map<String, Object> map);
	public Integer hasUserReplyLiked(Map<String, Object> map);
	
}
