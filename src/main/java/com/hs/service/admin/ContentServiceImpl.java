package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.ContentMapper;
import com.hs.model.admin.ContentDTO;
import com.hs.mybatis.support.MapperContainer;

public class ContentServiceImpl implements ContentService{
	private ContentMapper mapper = MapperContainer.get(ContentMapper.class);
	
	@Override
	public int postAllCount() {
		int postAllCount = 0;
		try {
			postAllCount = mapper.postAllCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postAllCount;
	}

	@Override
	public int postNormalCount() {
		int postNormalCount = 0;
		try {
			postNormalCount = mapper.postNormalCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postNormalCount;
	}

	@Override
	public int postDeclaCount() {
		int postDeclaCount = 0;
		try {
			postDeclaCount = mapper.postDeclaCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postDeclaCount;
	}

	@Override
	public int postProCount() {
		int postProCount = 0;
		try {
			postProCount = mapper.postProCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postProCount;
	}
	
	@Override
	public int userCount(Map<String, Object> map) {
		int countDto = 0;
		try {
			countDto = mapper.userCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countDto;
	}
	
	@Override
	public List<ContentDTO> memberList(Map<String, Object> map) {
		List<ContentDTO> meberList = null;
		
		try {
			meberList = mapper.memberList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return meberList;
	}
	
	@Override
	public int updateMemberStatus(Map<String, Object> map) throws Exception {
	    int result = 0;
	    
	    try {
	        result = mapper.updateMemberStatus(map);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
	    return result;
	}

}
