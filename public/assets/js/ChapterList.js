document.addEventListener("DOMContentLoaded", function() {
    const chapterButtons = document.querySelectorAll('.chapter-button');
    const modal = document.getElementById('chapter-content');
    const closeModalButton = document.getElementById('close-modal');
    const editButton = document.getElementById('edit-chapter');
    const saveButton = document.getElementById('save-changes');
    const editSection = document.getElementById('edit-section');
    const chapterTitle = document.getElementById('chapter-title');
    const chapterDescription = document.getElementById('chapter-description');
    const chapterEvents = document.getElementById('chapter-events');
    
    let currentChapterId = null;

    chapterButtons.forEach(button => {
        button.addEventListener('click', function() {
            currentChapterId = this.getAttribute('data-chapter-id');
            getChapter(currentChapterId);
        });
    });

    closeModalButton.addEventListener('click', function() {
        modal.style.display = 'none';
    });

    editButton.addEventListener('click', function() {
        document.getElementById('edit-title').value = chapterTitle.textContent;
        document.getElementById('edit-content').value = chapterDescription.innerHTML;

        chapterTitle.style.display = 'none';
        chapterDescription.style.display = 'none';
        chapterEvents.style.display = 'none';
        editButton.style.display = 'none';

        editSection.style.display = 'block';
    });

    saveButton.addEventListener('click', function() {
        const newTitle = document.getElementById('edit-title').value;
        const newContent = document.getElementById('edit-content').value;

        updateChapter(currentChapterId, newTitle, newContent);
    });

    function getChapter(chapterId) {
        fetch(`/DungeonXplorer/chapter/getChapter/${chapterId}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const chapter = data.chapter;
                    console.log(chapter);
                    chapterTitle.textContent = chapter.title;
                    chapterDescription.innerHTML = chapter.content;
                    chapterEvents.innerHTML = 'type : ' + chapter.events || '';
                    
                    chapterTitle.style.display = 'block';
                    chapterDescription.style.display = 'block';
                    chapterEvents.style.display = 'block';

                    editSection.style.display = 'none';

                    modal.style.display = 'flex';
                } else {
                    alert("Chapitre non trouvé.");
                }
            })
            .catch(error => {
                console.error('Erreur:', error);
                alert('Une erreur est survenue.');
            });
    }

    function updateChapter(chapterId, newTitle, newContent) {
        fetch(`/DungeonXplorer/chapter/updateChapter`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                chapterId: chapterId,
                title: newTitle,
                content: newContent
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Chapitre mis à jour !");
                modal.style.display = 'none';
                getChapter(chapterId);
            } else {
                alert("Échec de la mise à jour du chapitre.");
            }
        })
        .catch(error => {
            console.error('Erreur:', error);
            alert('Une erreur est survenue lors de la mise à jour du chapitre.');
        });
    }
});
