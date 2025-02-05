document.addEventListener('DOMContentLoaded', () => {
    const chapterContent = document.querySelector('.chapter-content p');
    const chapterText = chapterContent.innerHTML;
    let i = 0;
    let skipTyping = false;

    chapterContent.innerHTML = '';

    function typeWriter() {
        if (skipTyping) {
            chapterContent.innerHTML = highlightCarnifex(chapterText); 
            showNextSection();
            return;
        }

        if (i < chapterText.length) {
            const currentChar = chapterText.charAt(i);
            chapterContent.innerHTML += currentChar;

            const displayedText = chapterContent.innerHTML;
            chapterContent.innerHTML = highlightCarnifex(displayedText);

            i++;
            setTimeout(typeWriter, 25);
        } else {
            showNextSection();
        }
    }

    function highlightCarnifex(text) {
        const regex = /(carnifex)/gi;
        return text.replace(regex, '<span style="color: #8B0000;">$1</span>');
    }

    function showNextSection() {
        const combatContainer = document.getElementById('combatContainer');
        const linksContainer = document.querySelector('.links');
        const npcContainer = document.getElementById('npcContainer');
        const treasureContainer = document.getElementById('treasureContainer')

        if (combatContainer) {
            combatContainer.style.display = 'block';
        } else if (treasureContainer) {
            treasureContainer.style.display = "block";
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