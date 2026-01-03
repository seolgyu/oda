
if (window.tailwind) {
    tailwind.config = {
        theme: {
            extend: {
                colors: { primary: "#a855f7", secondary: "#9333ea" }
            }
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const privacyInputs = document.querySelectorAll('input[name="isPrivate"]');
    privacyInputs.forEach(input => {
        input.addEventListener('change', (e) => {
            const container = e.target.closest('.grid');
            if(!container) return;

            container.querySelectorAll('.privacy-card').forEach(card => {
                card.classList.replace('card-selected', 'card-unselected');
                const title = card.querySelector('.title-text');
                const icon = card.querySelector('.material-symbols-outlined:first-child');
                const check = card.querySelector('.check-container');
                
                if(title) title.classList.replace('text-primary', 'text-white');
                if(icon) icon.className = 'material-symbols-outlined icon-inactive text-2xl';
                if(check) check.innerHTML = '';
            });

            const selectedCard = e.target.closest('label');
            selectedCard.classList.replace('card-unselected', 'card-selected');
            
            const activeTitle = selectedCard.querySelector('.title-text');
            const activeIcon = selectedCard.querySelector('.material-symbols-outlined:first-child');
            const activeCheck = selectedCard.querySelector('.check-container');

            if(activeTitle) activeTitle.classList.replace('text-white', 'text-primary');
            if(activeCheck) activeCheck.innerHTML = '<span class="material-symbols-outlined text-primary text-2xl">check_circle</span>';
            
            if(e.target.value === '0') { // Public
                if(activeIcon) activeIcon.classList.add('icon-public-active');
            } else { // Private
                if(activeIcon) activeIcon.classList.add('icon-private-active');
            }
        });
    });
});