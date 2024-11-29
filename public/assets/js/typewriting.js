document.addEventListener('DOMContentLoaded', () => {
    const chapterContent = document.querySelector('.chapter-content p');
    const chapterText = chapterContent.innerHTML;
    let i = 0;

    // Cache le contenu initial pour l'effet de typewriting
    chapterContent.innerHTML = '';
    
    function typeWriter() {
        if (i < chapterText.length) {
            chapterContent.innerHTML += chapterText.charAt(i);
            i++;
            setTimeout(typeWriter, 50); // Vitesse de l'écriture
        } else {
            // Une fois l'écriture terminée, afficher les éléments suivants
            showNextSection();
        }
    }

    function showNextSection() {
        const combatContainer = document.getElementById('combatContainer');
        const linksContainer = document.querySelector('.links');

        if (combatContainer) {
            combatContainer.style.display = 'block';
        } else if (linksContainer) {
            linksContainer.style.display = 'flex';
        }
    }

    // Démarrer l'effet de typewriting
    typeWriter();
});
