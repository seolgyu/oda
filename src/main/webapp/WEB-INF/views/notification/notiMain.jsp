<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <style type="text/css">
        /* 1. 알림 페이지 전용 레이아웃 */
        .noti-page-container {
            max-width: 800px;
            width: 100%;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        /* 2. 섹션 타이틀 (오늘, 어제 등) */
        .noti-date-label {
            font-size: 0.75rem;
            font-weight: 700;
            color: #a855f7; /* 마이페이지 포인트 컬러 */
            text-transform: uppercase;
            letter-spacing: 2px;
            margin: 2rem 0 1rem 0.5rem;
            opacity: 0.8;
        }

        /* 3. 전체 알림 아이템 (Glassmorphism) */
        .full-noti-item {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 1.25rem;
            padding: 1.25rem 1.5rem;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: flex-start;
            gap: 1.25rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
        }

        .full-noti-item:hover {
            background: rgba(255, 255, 255, 0.06);
            transform: translateY(-2px);
            border-color: rgba(255, 255, 255, 0.15);
        }

        /* 안읽음 상태 강조 */
        .full-noti-item.unread {
            background: rgba(99, 102, 241, 0.05); /* 인디고 빛 */
            border-left: 3px solid #6366f1;
        }

        /* 4. 아바타 및 타입 배지 (마이페이지 스타일 계승) */
        .noti-avatar-box {
            position: relative;
            flex-shrink: 0;
            width: 52px;
            height: 52px;
        }

        .noti-type-icon-badge {
            position: absolute;
            bottom: -2px;
            right: -2px;
            width: 24px;
            height: 24px;
            background: #0f0f14;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1.5px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 2px 5px rgba(0,0,0,0.5);
        }

        /* 5. 텍스트 요소 */
        .noti-user-name {
            color: #ffffff;
            font-weight: 700;
            margin-right: 4px;
        }

        .noti-post-quote {
            display: block;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.4);
            font-style: italic;
            margin-top: 4px;
            padding-left: 8px;
            border-left: 2px solid rgba(255, 255, 255, 0.1);
        }

        .noti-time-text {
            font-size: 0.75rem;
            color: rgba(255, 255, 255, 0.3);
            margin-top: 8px;
        }

        /* 6. 안읽음 점 */
        .unread-glow-dot {
            width: 8px;
            height: 8px;
            background: #6366f1;
            border-radius: 50%;
            margin-top: 1.5rem;
            box-shadow: 0 0 12px rgba(99, 102, 241, 0.8);
        }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/views/home/header.jsp"%>

    <div class="app-body">
        <%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

        <main class="app-main">
            <div class="space-background">
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="stars3"></div>
                <div class="planet planet-1"></div>
                <div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container custom-scrollbar">
                <div class="noti-page-container">
                    
                    <div class="d-flex justify-content-between align-items-end mb-4 px-2">
                        <div>
                            <h2 class="text-white fw-bold mb-1" style="font-size: 2rem; letter-spacing: -1px;">Notifications</h2>
                            <p class="text-secondary text-sm mb-0">새로운 소식을 확인하세요.</p>
                        </div>
                        <button class="btn btn-sm btn-outline-light border-white border-opacity-10 rounded-pill px-3 opacity-50 hover-white">
                            전체 읽음 처리
                        </button>
                    </div>

                    <div id="fullNotiList">
                        
                        <div class="noti-date-label">Today</div>

                        <div class="full-noti-item unread">
                            <div class="noti-avatar-box">
                                <div class="rounded-circle w-100 h-100 overflow-hidden border border-white border-opacity-10" style="background: linear-gradient(135deg, #6366f1, #a855f7);">
                                    <img src="https://i.pravatar.cc/150?u=12" class="w-100 h-100 object-fit-cover">
                                </div>
                                <div class="noti-type-icon-badge">
                                    <span class="material-symbols-outlined text-danger" style="font-size: 15px; font-variation-settings: 'FILL' 1;">favorite</span>
                                </div>
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <p class="text-white text-sm mb-0">
                                    <span class="noti-user-name">Nova_Explorer</span>님이 내 게시글을 좋아합니다.
                                </p>
                                <span class="noti-post-quote text-truncate">"안드로메다 은하에서 발견된 새로운 성운에 대하여..."</span>
                                <p class="noti-time-text">방금 전</p>
                            </div>
                            <div class="unread-glow-dot"></div>
                        </div>

                        <div class="full-noti-item unread">
                            <div class="noti-avatar-box">
                                <div class="rounded-circle w-100 h-100 overflow-hidden d-flex align-items-center justify-content-center text-white fw-bold" style="background: #4338ca; font-size: 1.2rem;">
                                    S
                                </div>
                                <div class="noti-type-icon-badge">
                                    <span class="material-symbols-outlined text-primary" style="font-size: 15px; font-variation-settings: 'FILL' 1;">person_add</span>
                                </div>
                            </div>
                            <div class="flex-grow-1">
                                <p class="text-white text-sm mb-0">
                                    <span class="noti-user-name">StarLord_99</span>님이 나를 팔로우하기 시작했습니다.
                                </p>
                                <p class="noti-time-text">2시간 전</p>
                            </div>
                            <div class="unread-glow-dot"></div>
                        </div>

                        <div class="noti-date-label">Earlier</div>

                        <div class="full-noti-item">
                            <div class="noti-avatar-box">
                                <div class="rounded-circle w-100 h-100 overflow-hidden border border-white border-opacity-10">
                                    <img src="https://i.pravatar.cc/150?u=5" class="w-100 h-100 object-fit-cover">
                                </div>
                                <div class="noti-type-icon-badge">
                                    <span class="material-symbols-outlined text-success" style="font-size: 15px; font-variation-settings: 'FILL' 1;">chat_bubble</span>
                                </div>
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <p class="text-white text-sm mb-0">
                                    <span class="noti-user-name">Cosmos_Watcher</span>님이 댓글을 남겼습니다: 
                                    <span class="text-white-50">"사진 정보 공유 감사합니다! 정말 멋지네요."</span>
                                </p>
                                <span class="noti-post-quote text-truncate">"화성 탐사 로봇 퍼서비어런스의 최신 사진 공유"</span>
                                <p class="noti-time-text">어제 오후 11:45</p>
                            </div>
                        </div>

                    </div> </div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>