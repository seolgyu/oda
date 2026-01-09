package com.hs.util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.File;
import java.util.Map;

public class CloudinaryUtil {

    // 1. Cloudinary 설정 (대시보드에서 확인한 값으로 변경 필수!)
    private static final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
        "cloud_name", "123",      // 사용자분이 알려주신 Cloud Name
        "api_key", "123",    // Dashboard의 API Key 복사
        "api_secret", "456" // Dashboard의 API Secret 복사
    ));

    /**
     * 파일을 Cloudinary로 업로드하고, 웹에서 볼 수 있는 URL을 반환하는 함수
     * @param file : 업로드할 파일 객체
     * @return String : 이미지/동영상 URL (실패 시 null)
     */
    public static String uploadFile(File file) {
        try {
            // 업로드 옵션 설정 (자동으로 리소스 타입 감지: auto)
            Map params = ObjectUtils.asMap(
                "resource_type", "auto", 
                "folder", "oda_project" // Cloudinary 내에 생성될 폴더명
            );

            // 실제 업로드 수행
            Map uploadResult = cloudinary.uploader().upload(file, params);

            // 업로드된 파일의 보안 URL(https) 가져오기
            return (String) uploadResult.get("secure_url");

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}