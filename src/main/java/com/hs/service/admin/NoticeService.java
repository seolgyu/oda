package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.NoticeDTO;

public interface NoticeService {
	public List<NoticeDTO> noticeListTop();
	public List<NoticeDTO> noticeList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public void noticeDelete(long num) throws Exception;
	public void noticeDeleteList(List<Long> list) throws Exception;
	
	public NoticeDTO findById(long num);
}
