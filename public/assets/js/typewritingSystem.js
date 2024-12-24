document.addEventListener('DOMContentLoaded', () => {
    const chapterContent = document.querySelector('.chapter-content p');
    const chapterText = chapterContent.innerHTML;
    let i = 0;
    let skipTyping = false;

    chapterContent.innerHTML = '';

    function typeWriter() {
        if (skipTyping) {
            chapterContent.innerHTML = chapterText; 
            showNextSection();
            return;
        }

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
        const npcContainer = document.getElementById('npcContainer');
        const treasureContainer = document.getElementById('treasureContainer')

        if (combatContainer) {
            combatContainer.style.display = 'block';
        }else if(treasureContainer){
            treasureContainer.style.display="block";
        } else if (linksContainer) {
            linksContainer.style.display = 'flex';
        } else if (npcContainer) {
            npcContainer.style.display = 'block';
        }
    }

    document.addEventListener('keydown', (event) => {
        if (event.code === 'Space') {
            skipTyping = true;
        }
    });

    typeWriter();
});
