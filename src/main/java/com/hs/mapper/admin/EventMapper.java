package com.hs.mapper.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.EventDTO;
import com.hs.model.admin.EventReplyDTO;

public interface EventMapper {
	public long event_num_seq();
	
	// 이벤트 등록(ok)
	public void insertEvent(EventDTO dto) throws SQLException;
	// 이벤트 수정(ok)
	public void updateEvent(EventDTO dto) throws SQLException;
	// 이벤트 삭제(1개씩)(ok)
	public void deleteEvent(long event_num) throws SQLException;
	// 이벤트 삭제(1개 이상)(ok)
	public void deleteListEvent(List<Long> list) throws SQLException;
	
	// 데이터 개수(한페이지 출력시 사용)(ok)
	public int dataCount(Map<String, Object> map);
	
	// 리스트 첫줄(ok)
	public List<EventDTO> listEventTop();
	// (ok)
	public List<EventDTO> listEvent(Map<String, Object> map);
	
	// (ok)
	public EventDTO findById(long event_num);
	// 이전글
	public EventDTO findByPrev(Map<String, Object> map);
	// 다음글
	public EventDTO findByNext(Map<String, Object> map);
	// 조회수(ok)
	public void updateHitCount(long num) throws SQLException;
	
	
	// 첨부파일 등록
	public void insertEventFile(EventDTO dto) throws SQLException;
	// 첨부파일 삭제
	public void deleteEventFile(long event_num) throws SQLException;
	
	// 첨부파일 리스트(ok)
	public List<EventDTO> listEventFile(long num);
	// 첨부파일 검색
	public EventDTO findByFileId(long file_at_id);
	
	
	// 좋아요
	public EventDTO hasUserBoardLiked(Map<String, Object> map);
	public void insertBoardLike(Map<String, Object> map) throws SQLException;
	public void deleteBoardLike(Map<String, Object> map) throws SQLException;
	public int boardLikeCount(long num);
	
	// 댓글
	public void insertReply(EventReplyDTO dto) throws SQLException;
	public void deleteReply(Map<String, Object> map) throws SQLException;
	public int replyCount(Map<String, Object> map);
	
	public List<EventReplyDTO> listReply(Map<String, Object> map);
	public List<EventReplyDTO> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	public void updateReplyShowHide(Map<String, Object> map);
	
	// 댓글 좋아요
	public void insertReplyLike(Map<String, Object> map) throws SQLException;
	public Map<String, Object> replyLikeCount(Map<String, Object> map);
	public Integer hasUserReplyLiked(Map<String, Object> map);
	
}
