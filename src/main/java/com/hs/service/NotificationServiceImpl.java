package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.mapper.NotificationMapper;
import com.hs.model.NotificationDTO;
import com.hs.mybatis.support.MapperContainer;

public class NotificationServiceImpl implements NotificationService {
	
	private static NotificationService instance = new NotificationServiceImpl();
    
    private NotificationServiceImpl() {}

    public static NotificationService getInstance() {
        return instance;
    }
	
	private NotificationMapper mapper = MapperContainer.get(NotificationMapper.class);

	@Override
	public List<NotificationDTO> listNotification(Map<String, Object> map) throws Exception {
		List<NotificationDTO> list = null;
		try {
			list = mapper.listNotification(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertNotification(Map<String, Object> map) throws Exception {
		try {
			mapper.insertNotification(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateChecked(Long notiId) throws Exception {
		try {
			mapper.updateChecked(notiId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateCheckedAll(Long userNum) throws Exception {
		try {
			mapper.updateCheckedAll(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteNotification(Long notiId) throws Exception {
		try {
			mapper.deleteNotification(notiId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOldNotification(Long userNum) throws Exception {
		try {
			mapper.deleteOldNotification(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int getUncheckedCount(Long userNum) throws Exception {
		try {
			return mapper.getUncheckedCount(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

}
