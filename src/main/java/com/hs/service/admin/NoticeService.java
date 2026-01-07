package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.NoticeDTO;

public interface NoticeService {
	public List<NoticeDTO> noticeListTop();
	public List<NoticeDTO> noticeList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}
