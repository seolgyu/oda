package com.hs.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static String calculateTimeAgo(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return "";
        }
   
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        
        try {
           
            if(dateStr.length() > 16) {
                sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }
            
            Date date = sdf.parse(dateStr);
            long diff = new Date().getTime() - date.getTime();

            long minutes = diff / (1000 * 60);
            long hours = minutes / 60;
            long days = hours / 24;

            if (minutes < 1) {
                return "방금 전";
            } else if (minutes < 60) {
                return minutes + "분 전";
            } else if (hours < 24) {
                return hours + "시간 전";
            } else if (days < 7) {
                return days + "일 전";
            } else {
                // 7일이 넘어가면 그냥 날짜로 표시 (yyyy-MM-dd)
                return dateStr.substring(0, 10);
            }

        } catch (Exception e) {
            // 변환 실패 시 원래 날짜 그대로 리턴
            return dateStr;
        }
    }
}