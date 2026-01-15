package com.hs.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static String calculateTimeAgo(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return "";
        }
        
        dateStr = dateStr.replaceAll("\\s+", " ").trim();
        
        // 1. 시도할 날짜 포맷들 (순서대로 시도)
        String[] formats = {
            "yyyy-MM-dd HH:mm:ss.S", // 밀리초가 있는 경우 (Timestamp)
            "yyyy-MM-dd HH:mm:ss",   // 일반적인 경우
            "yyyy-MM-dd HH:mm"       // 초 단위가 없는 경우
        };

        Date date = null;
        
        // 2. 포맷 매칭 시도
        for (String format : formats) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat(format);
                sdf.setLenient(false); // 엄격하게 검사
                date = sdf.parse(dateStr);
                break; // 성공하면 반복 종료
            } catch (Exception e) {
                // 실패하면 다음 포맷 시도
            }
        }

        // 3. 모든 포맷이 실패했거나 변환 오류면 원래 문자열 반환 (콘솔에 원인 출력)
        if (date == null) {
            System.out.println("[DateUtil 에러] 날짜 변환 실패: " + dateStr);
            return dateStr;
        }

        // 4. 시간차 계산
        long diff = System.currentTimeMillis() - date.getTime();
        
        long seconds = diff / 1000;
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;
        
        // 미래 시간인 경우(서버 시간 차이 등) 방금 전으로 처리
        if (diff < 0) return "방금 전";

        if (minutes < 10) {
            return "방금 전";
        } else if (minutes < 60) {
            return minutes + "분 전";
        } else if (hours < 24) {
            return hours + "시간 전";
        } else if (days < 7) {
            return days + "일 전";
        } else {
            // 7일 지나면 날짜(yyyy-MM-dd)만 잘라서 반환
            if (dateStr.length() >= 10) {
                return dateStr.substring(0, 10);
            }
            return dateStr;
        }
    }
}