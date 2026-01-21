package com.hs.mapper;

import java.util.List;
import java.util.Map;

import com.hs.model.NotificationDTO;

public interface NotificationMapper {
	
	public List<NotificationDTO> listNotification(Long userNum) throws Exception;
	public List<NotificationDTO> listAllNotification(Map<String, Object> map) throws Exception;
	
	public void insertNotification(Map<String, Object> map) throws Exception;

	public void updateChecked(Long notiId) throws Exception;
    public void updateCheckedAll(Long userNum) throws Exception;

    public void deleteNotification(Long notiId) throws Exception;
    public void deleteOldNotification(Long userNum) throws Exception;
    
    public int getUncheckedCount(Long userNum) throws Exception;
}
