package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.EventMapper;
import com.hs.model.admin.EventDTO;
import com.hs.mybatis.support.MapperContainer;

public class EventServiceImpl implements EventService {
	private EventMapper mapper = MapperContainer.get(EventMapper.class);
	
	@Override
	public void insertEvent(EventDTO dto) throws Exception {
		// 이벤트 등록
		
	}

	@Override
	public void updateEvent(EventDTO dto) throws Exception {
		// 이벤트 수정
		
	}

	@Override
	public void deleteEvent(EventDTO dto) throws Exception {
		// 이벤트 삭제(1개씩)
		
	}

	@Override
	public void deleteListEvent(EventDTO dto) throws Exception {
		// 이벤트 삭제(1개이상)
		
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
	public List<EventDTO> listEventTop() {
		// 리스트 첫줄
		
		return null;
	}

	@Override
	public List<EventDTO> listEvent(Map<String, Object> map) {
		List<EventDTO> list = null;
		
		try {
			list = mapper.listEvent(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public EventDTO findByTitle(String event_title) {
		// 제목검색
		
		return null;
	}

	@Override
	public EventDTO findByPrev(Map<String, Object> map) {
		// 이전글
		
		return null;
	}

	@Override
	public EventDTO findByNext(Map<String, Object> map) {
		// 다음글
		
		return null;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// 조회수
		
	}

	@Override
	public void insertEventFile(EventDTO dto) throws Exception {
		// 첨부파일 등록
		
	}

	@Override
	public void deleteEventFile(Map<String, Object> map) throws Exception {
		// 첨부파일 삭제
		
	}

	@Override
	public List<EventDTO> listEventFile(long num) {
		// 파일 리스트
		return null;
	}

}
