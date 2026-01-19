<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<%-- 
    [공통 미디어 뷰어]
    사용법: 
    <c:set var="mediaPath" value="${파일경로}" scope="request" />
    <c:set var="mediaMode" value="article" scope="request" /> 
    <jsp:include page="/WEB-INF/views/post/media_view.jsp" />
--%>

<%-- 1. 확장자 및 타입 분석 --%>
<c:set var="fullPath" value="${fn:toLowerCase(mediaPath)}" />
<c:set var="isMovie" value="${fn:endsWith(fullPath, '.mp4') or fn:endsWith(fullPath, '.mov') or fn:endsWith(fullPath, '.webm') or fn:endsWith(fullPath, '.avi')}" />

<div class="media-container w-100 h-100 d-flex align-items-center justify-content-center bg-black position-relative" style="overflow: hidden;">
    
    <c:choose>
        <%-- [TYPE A] 동영상일 경우 --%>
        <c:when test="${isMovie}">
            
            <%-- Cloudinary 주소 변환 로직 --%>
            <c:choose>
                <c:when test="${fn:startsWith(mediaPath, 'http')}">
                    <c:set var="originalUrl" value="${mediaPath}" />
                    <c:set var="urlParts" value="${fn:split(originalUrl, '.')}" />
                    <c:set var="baseUrl" value="" />
                    <c:forEach var="part" items="${urlParts}" varStatus="stat">
                        <c:if test="${!stat.last}">
                            <c:set var="baseUrl" value="${baseUrl}${part}." />
                        </c:if>
                    </c:forEach>
                    <c:set var="baseUrl" value="${fn:substring(baseUrl, 0, fn:length(baseUrl)-1)}" />
                    
                    <c:set var="finalVideoUrl" value="${baseUrl}.mp4" />
                    <c:set var="finalPosterUrl" value="${baseUrl}.jpg" />
                </c:when>
                <c:otherwise>
                    <c:set var="finalVideoUrl" value="${pageContext.request.contextPath}/uploads/photo/${mediaPath}" />
                    <c:set var="finalPosterUrl" value="" />
                </c:otherwise>
            </c:choose>

            <%-- 모드(mediaMode)에 따른 태그 출력 차별화 --%>
            <c:choose>
                <%-- 1. 상세 페이지용 (컨트롤바 O) --%>
                <c:when test="${mediaMode eq 'article'}">
                    <video class="d-block w-100 h-100" poster="${finalPosterUrl}" style="object-fit: contain; z-index: 10;"
                           controls autoplay muted loop playsinline preload="metadata">
                        <source src="${finalVideoUrl}" type="video/mp4">
                    </video>
                </c:when>
                
                <%-- 2. 피드/메인화면용 (자동재생, 컨트롤바 X, 클릭이벤트) --%>
                <c:when test="${mediaMode eq 'feed'}">
                    <video class="slider-img feed-video w-100 h-100" poster="${finalPosterUrl}" style="object-fit: contain;"
                           loop muted playsinline preload="metadata">
                        <source src="${finalVideoUrl}" type="video/mp4">
                    </video>
                    <div class="video-sound-btn" onclick="toggleSound(this, event)">
                        <span class="material-symbols-outlined">volume_off</span>
                    </div>
                </c:when>
                
                <%-- 3. 축약형 썸네일용 (클릭 시 모달) --%>
                <c:when test="${mediaMode eq 'compact'}">
                    <div class="w-100 h-100 position-relative" 
                         onclick="event.stopPropagation(); showImageModal('${finalVideoUrl}', 'video');">
                        <video class="compact-thumb-img w-100 h-100" poster="${finalPosterUrl}" 
                               muted preload="metadata" style="object-fit: cover;">
                            <source src="${finalVideoUrl}" type="video/mp4">
                        </video>
                        <span class="material-symbols-outlined position-absolute top-50 start-50 translate-middle text-white" 
                              style="font-size: 2rem; text-shadow: 0 0 5px rgba(0,0,0,0.5);">play_circle</span>
                    </div>
                </c:when>
            </c:choose>
        </c:when>
        
        <%-- [TYPE B] 이미지일 경우 --%>
        <c:otherwise>
            <c:choose>
                <c:when test="${fn:startsWith(mediaPath, 'http')}">
                    <c:set var="imgSrc" value="${mediaPath}" />
                </c:when>
                <c:otherwise>
                    <c:set var="imgSrc" value="${pageContext.request.contextPath}/uploads/photo/${mediaPath}" />
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${mediaMode eq 'compact'}">
                    <div class="w-100 h-100" onclick="event.stopPropagation(); showImageModal('${imgSrc}', 'image');">
                        <img src="${imgSrc}" class="compact-thumb-img w-100 h-100" style="object-fit: cover;">
                    </div>
                </c:when>
                <c:otherwise>
                    <img src="${imgSrc}" class="d-block w-100 h-100" style="object-fit: contain;">
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</div>