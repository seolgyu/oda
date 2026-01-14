package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.EventMapper;
import com.hs.model.admin.EventDTO;
import com.hs.mybatis.support.MapperContainer;
import com.hs.util.MyMultipartFile;

public class EventServiceImpl implements EventService {
	private EventMapper mapper = MapperContainer.get(EventMapper.class);
	
	@Override
	public void insertEvent(EventDTO dto) throws Exception {
		// 이벤트 등록
		try {
			Long event_num_seq = mapper.event_num_seq();
			dto.setEvent_num(event_num_seq);

			mapper.insertEvent(dto);
			
			if(dto.getListFile().size() != 0) {
				for(MyMultipartFile mf: dto.getListFile()) {
					dto.setFile_path(mf.getSaveFilename());
					dto.setFile_name(mf.getOriginalFilename());
					dto.setFile_size(mf.getSize());
					
					mapper.insertEventFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void updateEvent(EventDTO dto) throws Exception {
		// 이벤트 수정
		try {
			mapper.updateEvent(dto);
			
			if(dto.getListFile().size() != 0) {
				for(MyMultipartFile mf: dto.getListFile()) {
					dto.setFile_path(mf.getSaveFilename());
					dto.setFile_name(mf.getOriginalFilename());
					dto.setFile_size(mf.getSize());
					
					mapper.insertEventFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void deleteEvent(long event_num) throws Exception {
		// 이벤트 삭제(1개씩)
		try {
			mapper.deleteEvent(event_num);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}
	
	@Override
	public void deleteListEvent(List<Long> list) throws Exception {
		// 삭제 1개 이상
		try {
			mapper.deleteListEvent(list);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}	
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
		List<EventDTO> list = null;

		try {
			list = mapper.listEventTop();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<EventDTO> listEvent(Map<String, Object> map) {
		// 리스트
		List<EventDTO> list = null;
		
		try {
			list = mapper.listEvent(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public EventDTO findById(long event_num) {
		EventDTO dto = null;
		
		try {
			dto = mapper.findById(event_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public EventDTO findByPrev(Map<String, Object> map) {
		// 이전글
		EventDTO dto = null;
		
		try {
			// dto = mapper.findByPrev(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public EventDTO findByNext(Map<String, Object> map) {
		// 다음글
		EventDTO dto = null;
		
		try {
			// dto = mapper.findByPrev(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// 조회수
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public List<EventDTO> listEventFile(long num) {
		// 파일 리스트
		List<EventDTO> eventfilelist = null;
		
		try {
			eventfilelist = mapper.listEventFile(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return eventfilelist;
	}
	
	
	@Override
	public EventDTO findByFileId(long fileid) {
		// 파일 검색
		EventDTO dto = null;
		
		try {
			dto = mapper.findByFileId(fileid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteEventFile(long event_num) throws Exception {
		// 첨부파일 삭제
		try {
			mapper.deleteEventFile(event_num);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}


}
