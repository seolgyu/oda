document.addEventListener('DOMContentLoaded', () => { 
    const topicBtns = document.querySelectorAll('.topic-btn');
	const selectedTopicInput = document.getElementById('selectedTopic');
	
	if (topicBtns.length > 0 && selectedTopicInput && !selectedTopicInput.value) {
	        selectedTopicInput.value = topicBtns[0].getAttribute('data-id');
	    }
	
    topicBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            topicBtns.forEach(b => b.classList.remove('selected'));
            btn.classList.add('selected');
			
			if (selectedTopicInput) {
				selectedTopicInput.value = btn.getAttribute('data-id');
			}
        });
    });
	
	const privacyCards = document.querySelectorAll('.privacy-card');

	privacyCards.forEach(card => {
	    card.addEventListener('click', function() {
	        const input = this.querySelector('input[name="is_private"]');
	        if (!input) return;

	        input.checked = true;

	        privacyCards.forEach(c => {
	            c.classList.remove('card-selected');
	            c.classList.add('card-unselected');
	            const title = c.querySelector('.title-text');
	            const check = c.querySelector('.check-container');
	            if (title) {
	                title.classList.remove('text-[#a855f7]');
	                title.classList.add('text-white');
	            }
	            if (check) check.innerHTML = '';
	        });

	        this.classList.replace('card-unselected', 'card-selected');
	        const activeTitle = this.querySelector('.title-text');
	        const activeCheck = this.querySelector('.check-container');
	        
	        if (activeTitle) {
	            activeTitle.classList.remove('text-white');
	            activeTitle.classList.add('text-[#a855f7]');
	        }
	        if (activeCheck) {
	            activeCheck.innerHTML = '<span class="material-symbols-outlined text-[#a855f7] text-2xl animate-in fade-in zoom-in duration-200">check_circle</span>';
	        }
	    });
	});
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