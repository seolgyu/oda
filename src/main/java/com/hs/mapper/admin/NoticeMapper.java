package com.hs.mapper.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.NoticeDTO;

public interface NoticeMapper {
	public int dataCount(Map<String, Object> map);
	public List<NoticeDTO> noticeListTop();
	public List<NoticeDTO> noticeList(Map<String, Object> map);
}
