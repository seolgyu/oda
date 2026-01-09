document.addEventListener('DOMContentLoaded', () => {
    const updateForm = document.getElementById('updateForm'); 
    const selectedTopicInput = document.getElementById('category_id_input');
    const dbIsPrivateEl = document.getElementById('db_is_private');
    const dbTopicIdEl = document.getElementById('db_category_id');
    
	const dbIsPrivate = dbIsPrivateEl ? dbIsPrivateEl.value : null;
    const dbTopicId = dbTopicIdEl ? dbTopicIdEl.value : null;
	
	const privacyCards = document.querySelectorAll('.privacy-card');
	privacyCards.forEach(card => {
		card.addEventListener('click', function() {
			privacyCards.forEach(c => {
				c.classList.remove('card-selected', 'border-primary/50', 'bg-primary/10');
				c.classList.add('card-unselected', 'border-white/10');
	                
				const title = c.querySelector('.title-text');
				const check = c.querySelector('.check-container');
	                
				if(title) {
					title.classList.remove('text-[#a855f7]');
					title.classList.add('text-white');
				}
				if(check) check.innerHTML = ''; 
			});

			// 선택된 카드 디자인 적용
			this.classList.remove('card-unselected', 'border-white/10');
			this.classList.add('card-selected', 'border-primary/50', 'bg-primary/10');
	            
			const title = this.querySelector('.title-text');
			const check = this.querySelector('.check-container');
			const radio = this.querySelector('input[type="radio"]');

			if(title) {
				title.classList.remove('text-white');
				title.classList.add('text-[#a855f7]');
			}
			if(check) {
				check.innerHTML = '<span class="material-symbols-outlined text-[#a855f7] text-2xl check-mark">check_circle</span>';
			}
			if(radio) radio.checked = true;
		});
	});

	if (dbIsPrivate !== null) {
		privacyCards.forEach(card => {
			const input = card.querySelector('input[name="is_private"]');
			if (input) {
				if ((dbIsPrivate === "0" && input.value === "public") || 
					(dbIsPrivate === "1" && input.value === "private")) {
	                    card.click();
				}
			}
		});
	}

    const topicBtns = document.querySelectorAll('.topic-btn');
    topicBtns.forEach(btn => {
        if (dbTopicId && btn.getAttribute('data-id') === dbTopicId) {
            btn.classList.add('selected');
        }

        btn.addEventListener('click', () => {
            topicBtns.forEach(b => b.classList.remove('selected'));
            btn.classList.add('selected');
            
            if (selectedTopicInput) {
                selectedTopicInput.value = btn.getAttribute('data-id');
            }
        });
    });

    if (updateForm) {
        updateForm.addEventListener('submit', function(e) {
            e.preventDefault();

            const formData = new FormData(updateForm);
            const params = {};
            formData.forEach((value, key) => {
                params[key] = value;
            });

            ajaxRequest('update', 'POST', params, 'json', function(response) {
                if (response.status === "success") {
                    alert("성공적으로 수정되었습니다.");
                    location.href = "main?community_id=" + response.community_id;
                } else {
                    alert("수정 실패: " + (response.message || "오류가 발생했습니다."));
                }
            });
        });
    }
});

document.addEventListener("DOMContentLoaded", function() {
    document.body.classList.add('community-app-mode');
    
    const style = document.createElement('style');
    style.innerHTML = `
        .community-app-mode {
            -webkit-user-select: none;
            user-select: none;
        }
        .community-app-mode input, 
        .community-app-mode textarea,
        .community-app-mode [contenteditable="true"] {
            -webkit-user-select: text;
            user-select: text;
            cursor: text;
        }
    `;
    document.head.appendChild(style);
});