package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.EventDTO;

public interface EventService {
	// 이벤트 등록
	public void insertEvent(EventDTO dto) throws Exception;
	// 이벤트 수정
	public void updateEvent(EventDTO dto) throws Exception;
	// 이벤트 삭제(1개씩)
	public void deleteEvent(EventDTO dto) throws Exception;
	// 이벤트 삭제(1개 이상)
	public void deleteListEvent(EventDTO dto) throws Exception;
	
	// 데이터 개수(한페이지 출력시 사용)
	public int dataCount(Map<String, Object> map);
	
	// 리스트 첫줄
	public List<EventDTO> listEventTop();
	public List<EventDTO> listEvent(Map<String, Object> map);
	
	// 제목 검색
	public EventDTO findByTitle(String event_title);
	// 이전글
	public EventDTO findByPrev(Map<String, Object> map);
	// 다음글
	public EventDTO findByNext(Map<String, Object> map);
	// 조회수
	public void updateHitCount(long num) throws Exception;
	
	// 첨부파일 등록
	public void insertEventFile(EventDTO dto) throws Exception;
	// 첨부파일 삭제
	public void deleteEventFile(Map<String, Object> map) throws Exception;
	
	public List<EventDTO> listEventFile(long num);
}
