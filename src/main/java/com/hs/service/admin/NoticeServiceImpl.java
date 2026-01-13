package com.hs.service.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.NoticeMapper;
import com.hs.model.admin.NoticeDTO;
import com.hs.model.admin.NoticeReplyDTO;
import com.hs.mybatis.support.MapperContainer;
import com.hs.util.MyMultipartFile;

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

	@Override
	public void noticeInsert(NoticeDTO dto) throws SQLException {
		try {
			Long seq = mapper.noticeSeq();
			dto.setNotice_num(seq);
			
			mapper.noticeInsert(dto);
			
			if (dto.getListFile().size() != 0) {
				for (MyMultipartFile mf: dto.getListFile()) {
					dto.setSaveFilename(mf.getSaveFilename());
					dto.setOriginalFilename(mf.getOriginalFilename());
					dto.setFileSize(mf.getSize());
					
					mapper.insertNoticeFile(dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public NoticeDTO findByFileId(long fileNum) {
		NoticeDTO dto = null;
		
		try {
			dto = mapper.findByFileId(fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void deleteNoticeFile(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteNoticeFile(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public List<NoticeDTO> listNoticeFile(long num) {
		List<NoticeDTO> list = null;

		try {
			list = mapper.listNoticeFile(num);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public NoticeDTO findByPrev(Map<String, Object> map) {
		NoticeDTO dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public NoticeDTO findByNext(Map<String, Object> map) {
		NoticeDTO dto = null;
		
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void updateNotice(NoticeDTO dto) throws Exception {
		try {
			mapper.updateNotice(dto);
			
			if (dto.getListFile().size() != 0) {
				for (MyMultipartFile mf: dto.getListFile()) {
					dto.setSaveFilename(mf.getSaveFilename());
					dto.setOriginalFilename(mf.getOriginalFilename());
					dto.setFileSize(mf.getSize());
					
					mapper.insertNoticeFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void insertReply(NoticeReplyDTO dto) throws Exception {
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteReply(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		try {
			return mapper.replyCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<NoticeReplyDTO> listReply(Map<String, Object> map) {
		try {
			return mapper.listReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<NoticeReplyDTO> listReplyAnswer(Map<String, Object> map) {
		List<NoticeReplyDTO> list = null;
		
		try {
			list = mapper.listReplyAnswer(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(Map<String, Object> map) {
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
		
		try {
			mapper.updateReplyShowHide(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public Integer hasUserReplyLiked(Map<String, Object> map) {
		Integer result = -1;
		
		//-1 : 공감여부를 하지 않은 상태, 0 : 비공감, 1 : 공감
		
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

	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertBoardLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteBoardLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int boardLikeCount(long num) {
		try {
			return mapper.boardLikeCount(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public boolean isUserBoardLiked(Map<String, Object> map) {
		try {
			NoticeDTO dto = mapper.hasUserBoardLiked(map);
			
			if(dto != null) {
				return true;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertReplyLike(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		Map<String, Object> countMap = null;
		
		try {
			countMap = mapper.replyLikeCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countMap;
	}
	
	
}
