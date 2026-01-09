package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.NoticeMapper;
import com.hs.model.admin.NoticeDTO;
import com.hs.mybatis.support.MapperContainer;

public class NoticeServiceImpl implements NoticeService{
	private NoticeMapper mapper = MapperContainer.get(NoticeMapper.class);
	

	@Override
	public List<NoticeDTO> noticeListTop() {
		List<NoticeDTO> list = null;

		try {
			list = mapper.noticeListTop();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public List<NoticeDTO> noticeList(Map<String, Object> map) {
		List<NoticeDTO> list = null;
		
		try {
			list = mapper.noticeList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void noticeDelete(long num) throws Exception {
		try {
			mapper.noticeDelete(num);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void noticeDeleteList(List<Long> list) throws Exception {
		try {
			mapper.noticeDeleteList(list);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public NoticeDTO findById(long num) {
		NoticeDTO dto = null;
		
		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}
}
