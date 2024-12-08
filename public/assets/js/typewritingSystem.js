document.addEventListener('DOMContentLoaded', () => {
    const chapterContent = document.querySelector('.chapter-content p');
    const chapterText = chapterContent.innerHTML;
    let i = 0;

    chapterContent.innerHTML = '';
    
    function typeWriter() {
        if (i < chapterText.length) {
            chapterContent.innerHTML += chapterText.charAt(i);
            i++;
            setTimeout(typeWriter, 25); 
        } else {
            showNextSection();
        }
    }

    function showNextSection() {
        const combatContainer = document.getElementById('combatContainer');
        const linksContainer = document.querySelector('.links');
        const npcContainer = document.getElementById('npcContainer')

        if (combatContainer) {
            combatContainer.style.display = 'block';
        } else if (linksContainer) {
            linksContainer.style.display = 'flex';
        }  else if (npcContainer) {
            npcContainer.style.display = 'block';
        }
    }

    typeWriter();
});
