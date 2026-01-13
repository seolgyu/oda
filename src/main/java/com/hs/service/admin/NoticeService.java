package com.hs.service.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.NoticeReplyDTO;
import com.hs.model.admin.NoticeDTO;

public interface NoticeService {
	public List<NoticeDTO> noticeListTop();
	public List<NoticeDTO> noticeList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public void noticeDelete(long num) throws Exception;
	public void noticeDeleteList(List<Long> list) throws Exception;
	
	public NoticeDTO findById(long num);
	
	public void noticeInsert(NoticeDTO dto) throws SQLException;
	
	public void deleteNoticeFile(Map<String, Object> map) throws Exception;
	public List<NoticeDTO> listNoticeFile(long num);
	public NoticeDTO findByFileId(long fileNum);
	
	public NoticeDTO findByPrev(Map<String, Object> map);
	public NoticeDTO findByNext(Map<String, Object> map);
	public void updateHitCount(long num) throws Exception;
	
	public void updateNotice(NoticeDTO dto) throws Exception;
	
	public void insertReply(NoticeReplyDTO dto) throws Exception;
	public void deleteReply(Map<String, Object> map) throws Exception;
	public int replyCount(Map<String, Object> map);
	public List<NoticeReplyDTO> listReply(Map<String, Object> map);
	public List<NoticeReplyDTO> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	
	public void updateReplyShowHide(Map<String, Object> map);
	
	public Integer hasUserReplyLiked(Map<String, Object> map);
	
	public void insertBoardLike(Map<String, Object> map) throws Exception;
	public void deleteBoardLike(Map<String, Object> map) throws Exception;
	public int boardLikeCount(long num);
	
	public boolean isUserBoardLiked(Map<String, Object> map);
	
	public void insertReplyLike (Map<String, Object> map) throws Exception;
	public Map<String, Object> replyLikeCount(Map<String, Object> map);
}
