package com.hs.mapper.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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
}
