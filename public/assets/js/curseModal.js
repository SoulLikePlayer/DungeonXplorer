document.addEventListener('DOMContentLoaded', function () {
    const curseModal = document.getElementById('curseModal');
    const curseModif = curseModal.getAttribute('data-curse-modif');
    const closeModalButton = document.getElementById('closeModalButton');

    if (curseModif !== "aucun") {
        curseModal.style.display = 'flex';
    }

    function closeModal() {
        curseModal.style.display = 'none';
    }

    closeModalButton.addEventListener('click', closeModal);

    window.addEventListener('click', function (event) {
        if (event.target === curseModal) {
            closeModal();
        }
    });
});
