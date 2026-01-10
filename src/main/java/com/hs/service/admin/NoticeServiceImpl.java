package com.hs.service.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.NoticeMapper;
import com.hs.model.admin.NoticeDTO;
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
}
