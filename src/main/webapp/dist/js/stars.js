/**
 * 
 */

function generateStars(count) {
	let value = '';
	for (let i = 0; i < count; i++) {
		const x = Math.floor(Math.random() * 2000);
		const y = Math.floor(Math.random() * 2000);
		value += `${x}px ${y}px #FFF`;
		if (i < count - 1) value += ', ';
	}
	return value;
}
document.addEventListener('DOMContentLoaded', () => {
	const stars1 = document.querySelector('.stars');
	if (stars1) stars1.style.boxShadow = generateStars(700);
	const stars2 = document.querySelector('.stars2');
	if (stars2) stars2.style.boxShadow = generateStars(200);
	const stars3 = document.querySelector('.stars3');
	if (stars3) stars3.style.boxShadow = generateStars(100);
});


