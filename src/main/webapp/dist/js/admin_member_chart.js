// ============================================
// member-detail.js
// 회원 상세 페이지 스크립트
// ============================================

/**
 * 차트 초기화
 */
function initActivityChart() {
    const ctx = document.getElementById('activityChart');
    if (!ctx) {
        console.warn('차트 캔버스를 찾을 수 없습니다.');
        return;
    }
    
    // window.memberData에서 데이터 가져오기
    let chartData = window.memberData?.weeklyActivity || [];
    
    // 데이터가 없으면 기본값 사용
    if (chartData.length === 0) {
        chartData = [
            {dayName: '월', noticeCount: 0, commentCount: 0},
            {dayName: '화', noticeCount: 0, commentCount: 0},
            {dayName: '수', noticeCount: 0, commentCount: 0},
            {dayName: '목', noticeCount: 0, commentCount: 0},
            {dayName: '금', noticeCount: 0, commentCount: 0},
            {dayName: '토', noticeCount: 0, commentCount: 0},
            {dayName: '일', noticeCount: 0, commentCount: 0}
        ];
    }
    
    // 차트 레이블과 데이터 추출
    const labels = chartData.map(item => item.dayName);
    const noticeData = chartData.map(item => item.noticeCount);
    const commentData = chartData.map(item => item.commentCount);

    // Chart.js 차트 생성
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '게시글',
                data: noticeData,
                borderColor: '#2563EB',
                backgroundColor: 'rgba(37, 99, 235, 0.1)',
                tension: 0.4,
                fill: true,
                pointRadius: 4,
                pointHoverRadius: 6,
                pointBackgroundColor: '#2563EB',
                pointBorderColor: '#fff',
                pointBorderWidth: 2
            }, {
                label: '댓글',
                data: commentData,
                borderColor: '#10B981',
                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                tension: 0.4,
                fill: true,
                pointRadius: 4,
                pointHoverRadius: 6,
                pointBackgroundColor: '#10B981',
                pointBorderColor: '#fff',
                pointBorderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: 'index',
                intersect: false,
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top',
                    labels: {
                        color: '#E2E8F0',
                        font: {
                            size: 12,
                            family: "'Noto Sans KR', sans-serif"
                        },
                        padding: 15,
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(15, 23, 42, 0.9)',
                    titleColor: '#F8FAFC',
                    bodyColor: '#E2E8F0',
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 1,
                    padding: 12,
                    displayColors: true,
                    callbacks: {
                        label: function(context) {
                            return context.dataset.label + ': ' + context.parsed.y + '개';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        color: '#94A3B8',
                        font: {
                            size: 11,
                            family: "'Noto Sans KR', sans-serif"
                        },
                        stepSize: 1,
                        callback: function(value) {
                            if (Number.isInteger(value)) {
                                return value;
                            }
                        }
                    },
                    grid: {
                        color: 'rgba(255, 255, 255, 0.05)',
                        drawBorder: false
                    },
                    border: {
                        display: false
                    }
                },
                x: {
                    ticks: {
                        color: '#94A3B8',
                        font: {
                            size: 11,
                            family: "'Noto Sans KR', sans-serif"
                        }
                    },
                    grid: {
                        color: 'rgba(255, 255, 255, 0.05)',
                        drawBorder: false
                    },
                    border: {
                        display: false
                    }
                }
            }
        }
    });
}

/**
 * 모달 열기
 */
function openModal(modalId) {
    $('#' + modalId).addClass('show');
}

/**
 * 모달 닫기
 */
function closeModal(modalId) {
    $('#' + modalId).removeClass('show');
}

/**
 * 정지 모달 열기
 */
function openSuspendModal() {
    openModal('suspendModal');
}

/**
 * 회원 정지 확인
 */
function confirmSuspend() {
    const period = $('#suspendPeriod').val();
    const reason = $('#suspendReason').val();
    
    if(!reason.trim()) {
        alert('정지 사유를 입력해주세요.');
        return;
    }
    
    const url = window.memberData.contextPath + '/admin/member/suspend';
    const params = {
        memberId: window.memberData.userId,
        period: period,
        reason: reason
    };
    
    $.ajax({
        url: url,
        type: 'POST',
        data: params,
        dataType: 'json',
        success: function(data) {
            if(data.state === 'true') {
                alert('회원 정지가 완료되었습니다.');
                closeModal('suspendModal');
                location.reload();
            } else {
                alert('회원 정지에 실패했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('회원 정지 오류:', error);
            alert('오류가 발생했습니다.');
        }
    });
}

/**
 * 회원 활성화
 */
function activateMember() {
    if(!confirm('회원을 활성화하시겠습니까?')) {
        return;
    }
    
    const url = window.memberData.contextPath + '/admin/member/activate';
    const params = { memberId: window.memberData.userId };
    
    $.ajax({
        url: url,
        type: 'POST',
        data: params,
        dataType: 'json',
        success: function(data) {
            if(data.state === 'true') {
                alert('회원이 활성화되었습니다.');
                location.reload();
            } else {
                alert('활성화에 실패했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('회원 활성화 오류:', error);
            alert('오류가 발생했습니다.');
        }
    });
}

/**
 * 휴면 전환
 */
function setDormant() {
    if(!confirm('회원을 휴면 상태로 전환하시겠습니까?')) {
        return;
    }
    
    const url = window.memberData.contextPath + '/admin/member/dormant';
    const params = { memberId: window.memberData.userId };
    
    $.ajax({
        url: url,
        type: 'POST',
        data: params,
        dataType: 'json',
        success: function(data) {
            if(data.state === 'true') {
                alert('휴면 전환이 완료되었습니다.');
                location.reload();
            } else {
                alert('휴면 전환에 실패했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('휴면 전환 오류:', error);
            alert('오류가 발생했습니다.');
        }
    });
}

/**
 * 회원 탈퇴
 */
function deleteMember() {
    if(!confirm('정말로 이 회원을 탈퇴 처리하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
        return;
    }
    
    const url = window.memberData.contextPath + '/admin/member/delete';
    const params = { memberId: window.memberData.userId };
    
    $.ajax({
        url: url,
        type: 'POST',
        data: params,
        dataType: 'json',
        success: function(data) {
            if(data.state === 'true') {
                alert('회원 탈퇴가 완료되었습니다.');
                location.href = window.memberData.contextPath + '/admin/member/list';
            } else {
                alert('회원 탈퇴에 실패했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('회원 탈퇴 오류:', error);
            alert('오류가 발생했습니다.');
        }
    });
}

// ============================================
// 페이지 로드 시 초기화
// ============================================
$(document).ready(function() {
    // 차트 초기화
    initActivityChart();
    
    // 디버깅용 로그 (개발 완료 후 제거)
    console.log('회원 데이터:', window.memberData);
});