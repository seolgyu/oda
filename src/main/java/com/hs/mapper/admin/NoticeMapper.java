package com.hs.mapper.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.NoticeReplyDTO;
import com.hs.model.admin.NoticeDTO;

public interface NoticeMapper {
	public long noticeSeq();
	
	public int dataCount(Map<String, Object> map);
	public List<NoticeDTO> noticeListTop();
	public List<NoticeDTO> noticeList(Map<String, Object> map);
	
	public void noticeDelete(long num) throws SQLException;
	public void noticeDeleteList(List<Long> list) throws SQLException;
	public NoticeDTO findById(long num);
	
	public void noticeInsert(NoticeDTO dto) throws SQLException;
	public void insertNoticeFile(NoticeDTO dto) throws SQLException;
	
	public NoticeDTO findByFileId(long fileNum);
	public void deleteNoticeFile(Map<String, Object> map) throws SQLException;
	public List<NoticeDTO> listNoticeFile(long num);
	
	public NoticeDTO findByPrev(Map<String, Object> map);
	public NoticeDTO findByNext(Map<String, Object> map);
	public void updateHitCount(long num) throws SQLException;
	
	public void updateNotice(NoticeDTO dto) throws SQLException;
	
	public void insertReply(NoticeReplyDTO dto) throws SQLException;
	public void deleteReply(Map<String, Object> map) throws SQLException;
	public int replyCount(Map<String, Object> map);
	public List<NoticeReplyDTO> listReply(Map<String, Object> map);
	public List<NoticeReplyDTO> listReplyAnswer(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	public void updateReplyShowHide(Map<String, Object> map);
	
	public Integer hasUserReplyLiked(Map<String, Object> map);
}
