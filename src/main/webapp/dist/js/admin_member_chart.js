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
$(document).ready(function() {
    // 차트 초기화
    initActivityChart();
});