// 차트 데이터 (실제로는 서버에서 받아올 데이터)
	const visitorData = {
	    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
	    generalVisitors: [4200, 4500, 3800, 4100, 5200, 4800, 5230],
	    memberVisitors: [2800, 2900, 2600, 2850, 3400, 3100, 3150]
		/*labels: [
		        <c:forEach var="stat" items="${visitorStats}" varStatus="status">
		            '${stat.dayShort}'<c:if test="${!status.last}">,</c:if>
		        </c:forEach>
		    ],
		    generalVisitors: [
		        <c:forEach var="stat" items="${visitorStats}" varStatus="status">
		            ${stat.generalCount}<c:if test="${!status.last}">,</c:if>
		        </c:forEach>
		    ],
		    memberVisitors: [
		        <c:forEach var="stat" items="${visitorStats}" varStatus="status">
		            ${stat.memberCount}<c:if test="${!status.last}">,</c:if>
		        </c:forEach>
		    ]
		};*/
	};
	
	// 합계 계산 및 표시
	const totalGeneral = visitorData.generalVisitors[visitorData.generalVisitors.length - 1];
	const totalMember = visitorData.memberVisitors[visitorData.memberVisitors.length - 1];
	document.getElementById('totalGeneral').textContent = totalGeneral.toLocaleString();
	document.getElementById('totalMember').textContent = totalMember.toLocaleString();
	
	// Chart.js 설정
	const ctx = document.getElementById('visitorChart').getContext('2d');
	const visitorChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: visitorData.labels,
	        datasets: [
	            {
	                label: '일반 방문자',
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
	                label: '회원 방문자',
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
	                        return context.dataset.label + ': ' + context.parsed.y.toLocaleString() + '명';
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