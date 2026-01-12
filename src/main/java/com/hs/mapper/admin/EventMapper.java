package com.hs.mapper.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.admin.EventDTO;

public interface EventMapper {
	public long eventseq();
	
	// 이벤트 등록
	public void insertEvent(EventDTO dto) throws SQLException;
	// 이벤트 수정
	public void updateEvent(EventDTO dto) throws SQLException;
	// 이벤트 삭제(1개씩)
	public void deleteEvent(long event_num) throws SQLException;
	// 이벤트 삭제(1개 이상)
	public void deleteListEvent(List<Long> list) throws SQLException;
	
	// 데이터 개수(한페이지 출력시 사용)
	public int dataCount(Map<String, Object> map);
	
	// 리스트 첫줄
	public List<EventDTO> listEventTop();
	public List<EventDTO> listEvent(Map<String, Object> map);
	
	// 제목 검색
	public EventDTO findById(long event_num);
	// 이전글
	public EventDTO findByPrev(Map<String, Object> map);
	// 다음글
	public EventDTO findByNext(Map<String, Object> map);
	// 조회수
	public void updateHitCount(long num) throws SQLException;
	
	
	// 첨부파일 등록
	public void insertEventFile(EventDTO dto) throws SQLException;
	// 첨부파일 삭제
	public void deleteEventFile(List<Long> list) throws SQLException;
	
	// 첨부파일 리스트
	public List<EventDTO> listEventFile(long num);
	// 첨부파일 검색
	public EventDTO findByFileId(long file_at_id);
}
