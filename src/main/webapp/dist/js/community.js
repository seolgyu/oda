document.addEventListener('DOMContentLoaded', () => { 
    const topicBtns = document.querySelectorAll('.topic-btn');
    topicBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            topicBtns.forEach(b => b.classList.remove('selected'));
            btn.classList.add('selected');
        });
    });

	
    const privacyInputs = document.querySelectorAll('input[name="privacy-type"], input[name="privacy"]');
    
    privacyInputs.forEach(input => {
        input.addEventListener('change', (e) => {
            const groupName = e.target.name;
            const allCards = document.querySelectorAll(`input[name="${groupName}"]`);
            
            allCards.forEach(inp => {
                const card = inp.closest('.privacy-card');
                if (!card) return;

                // 초기화
                card.classList.replace('card-selected', 'card-unselected');
                const title = card.querySelector('.title-text');
                const check = card.querySelector('.check-container');
                const icon = card.querySelector('.material-symbols-outlined:first-child');

                if (title) {
                    title.classList.remove('text-[#a855f7]');
                    title.classList.add('text-white');
                }
                if (check) check.innerHTML = '';
                
                if (icon && icon.classList.contains('material-symbols-outlined')) {
                    icon.classList.remove('icon-public-active', 'icon-private-active');
                    icon.classList.add('icon-inactive');
                }
            });

            const selectedLabel = e.target.closest('.privacy-card');
            if (selectedLabel) {
                selectedLabel.classList.replace('card-unselected', 'card-selected');
                
                const activeTitle = selectedLabel.querySelector('.title-text');
                const activeCheck = selectedLabel.querySelector('.check-container');
                const activeIcon = selectedLabel.querySelector('.material-symbols-outlined:first-child');

                if (activeTitle) {
                    activeTitle.classList.remove('text-white');
                    activeTitle.classList.add('text-[#a855f7]');
                }
                if (activeCheck) {
                    activeCheck.innerHTML = '<span class="material-symbols-outlined text-[#a855f7] text-2xl animate-in fade-in zoom-in duration-200">check_circle</span>';
                }
                
                if (activeIcon) {
                    activeIcon.classList.remove('icon-inactive');
                    if (e.target.value === 'public') {
                        activeIcon.classList.add('icon-public-active');
                    } else {
                        activeIcon.classList.add('icon-private-active');
                    }
                }
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