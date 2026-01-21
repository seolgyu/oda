package com.hs.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.EventMapper;
import com.hs.model.admin.EventDTO;
import com.hs.model.admin.EventReplyDTO;
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
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "event_num");
			map.put("num", event_num);
			
			mapper.deleteEventFile(map);
			mapper.deleteBoardLikeAll(event_num);
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
			
			mapper.deletelistEventFile(list);
			mapper.deleteBoardLikeList(list);
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
			dto = mapper.findByPrev(map);
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
			dto = mapper.findByNext(map);
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
	public void deleteEventFile(Map<String, Object> map) throws Exception {
		// 첨부파일
		try {
			mapper.deleteEventFile(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public boolean isUserBoardLiked(Map<String, Object> map) {
		int result = 0;
	    try {
	        // XML에서 resultType="Integer"로 바꿨다면 여기서 숫자가 잘 담깁니다.
	        result = mapper.hasUserBoardLiked(map); 
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 에러가 나면 일단 false를 리턴하게 해서 페이지는 뜨게 만듭니다.
	        return false;
	    }
	    // 0보다 크면(데이터가 있으면) true, 없으면 false!
	    return result > 0;
	}

	
	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		// 종아요
		try {
			mapper.insertBoardLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		// 좋아요 삭제
		try {
			mapper.deleteBoardLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public int boardLikeCount(long num) {
		// 종아요 수
		try {
			return mapper.boardLikeCount(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public void insertReply(EventReplyDTO dto) throws Exception {
		// 댓글 등록
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		// 댓글 삭제
		try {
			mapper.deleteReply(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		// 댓글 수
		try {
			return mapper.replyCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public List<EventReplyDTO> listReply(Map<String, Object> map) {
		// 댓글 리스트
		try {
			return mapper.listReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public List<EventReplyDTO> listReplyAnswer(Map<String, Object> map) {
		// 댓글 대댓글
		List<EventReplyDTO> list = null;
		
		try {
			list = mapper.listReplyAnswer(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int replyAnswerCount(Map<String, Object> map) {
		// 대댓글 수
		int result = 0;
		
		try {
			result = mapper.replyAnswerCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void updateReplyShowHide(Map<String, Object> map) {
		// 댓글 숨기기
		try {
			mapper.updateReplyShowHide(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		// 댓글 좋아요
		
		try {
			mapper.insertReplyLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		// 댓글 좋아요 수
		Map<String, Object> countMap = null;
		
		try {
			countMap = mapper.replyLikeCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return countMap;
	}

	@Override
	public Integer hasUserReplyLiked(Map<String, Object> map) {
		// 공감여부를 하지 않은 상태 0, 1-공감
		Integer result = -1;
		
		try {
			result = mapper.hasUserReplyLiked(map);
			
			if(result == null) {
				result = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
