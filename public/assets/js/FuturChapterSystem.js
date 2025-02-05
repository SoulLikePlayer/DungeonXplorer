document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('future-modal');
    const modalContent = document.getElementById('future-vision-content');
    const closeModal = document.querySelector('.close-modal');

    document.querySelectorAll('.view-future-btn').forEach(button => {
        button.addEventListener('click', async () => {
            const chapterId = button.getAttribute('data-chapter-id');
            try {
                const response = await fetch(`/DungeonXplorer/chapter/previewFuture/${chapterId}`);
                const data = await response.json();

                modalContent.innerHTML = data.words.join(' ... ');
                modal.style.display = 'flex';

                button.disabled = true;
            } catch (error) {
                modalContent.innerHTML = 'Impossible de charger la vision : '+error;
                modal.style.display = 'flex';
            }
        });
    });

    closeModal.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
});