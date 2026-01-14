// 차트 데이터 (JSP에서 window.chartData로 전달받음)
const visitorData = {
    labels: window.chartData ? window.chartData.labels : ['월', '화', '수', '목', '금', '토', '일'],
    generalVisitors: window.chartData ? window.chartData.noticeCount : [0, 0, 0, 0, 0, 0, 0],  // 게시물 수
    memberVisitors: window.chartData ? window.chartData.loginCount : [0, 0, 0, 0, 0, 0, 0]     // 로그인 수
};

// 합계 계산 및 표시
const totalGeneral = visitorData.generalVisitors.reduce((sum, val) => sum + val, 0);
const totalMember = visitorData.memberVisitors.reduce((sum, val) => sum + val, 0);

// DOM 요소가 존재하는지 확인 후 업데이트
const totalGeneralElement = document.getElementById('totalGeneral');
const totalMemberElement = document.getElementById('totalMember');

if (totalGeneralElement) {
    totalGeneralElement.textContent = totalGeneral.toLocaleString();
}
if (totalMemberElement) {
    totalMemberElement.textContent = totalMember.toLocaleString();
}

// Chart.js 설정
const ctx = document.getElementById('visitorChart');
if (ctx) {
    const visitorChart = new Chart(ctx.getContext('2d'), {
        type: 'line',
        data: {
            labels: visitorData.labels,
            datasets: [
                {
                    label: '게시물 수',
                    data: visitorData.generalVisitors,
                    borderColor: '#3b82f6',
                    backgroundColor: function(context) {
                        const ctx = context.chart.ctx;
                        const gradient = ctx.createLinearGradient(0, 0, 0, 280);
                        gradient.addColorStop(0, 'rgba(59, 130, 246, 0.3)');
                        gradient.addColorStop(1, 'rgba(59, 130, 246, 0)');
                        return gradient;
                    },
                    fill: true,
                    tension: 0.4,
                    borderWidth: 3,
                    pointRadius: 0,
                    pointHoverRadius: 6,
                    pointHoverBackgroundColor: '#1e293b',
                    pointHoverBorderColor: '#3b82f6',
                    pointHoverBorderWidth: 2
                },
                {
                    label: '로그인 수',
                    data: visitorData.memberVisitors,
                    borderColor: '#a855f7',
                    backgroundColor: function(context) {
                        const ctx = context.chart.ctx;
                        const gradient = ctx.createLinearGradient(0, 0, 0, 280);
                        gradient.addColorStop(0, 'rgba(168, 85, 247, 0.3)');
                        gradient.addColorStop(1, 'rgba(168, 85, 247, 0)');
                        return gradient;
                    },
                    fill: true,
                    tension: 0.4,
                    borderWidth: 3,
                    pointRadius: 0,
                    pointHoverRadius: 6,
                    pointHoverBackgroundColor: '#1e293b',
                    pointHoverBorderColor: '#a855f7',
                    pointHoverBorderWidth: 2
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: 'index',
                intersect: false
            },
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#1e293b',
                    titleColor: '#f8fafc',
                    bodyColor: '#cbd5e1',
                    borderColor: '#334155',
                    borderWidth: 1,
                    padding: 12,
                    displayColors: true,
                    boxWidth: 8,
                    boxHeight: 8,
                    usePointStyle: true,
                    callbacks: {
                        label: function(context) {
                            return context.dataset.label + ': ' + context.parsed.y.toLocaleString() + '건';
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    border: {
                        display: false
                    },
                    ticks: {
                        color: '#64748b',
                        font: {
                            size: 11
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(51, 65, 85, 0.3)',
                        drawBorder: false
                    },
                    border: {
                        display: false
                    },
                    ticks: {
                        display: false
                    }
                }
            }
        }
    });
}