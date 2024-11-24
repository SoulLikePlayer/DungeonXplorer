document.addEventListener('DOMContentLoaded', function () {
    const modal = document.getElementById('inventoryModal');
    const showInventoryButton = document.getElementById('showInventoryButton');
    const closeModalButton = document.getElementById('closeModalButton');
    const inventoryList = document.getElementById('inventoryList');
    const inventoryData = JSON.parse(showInventoryButton.getAttribute('data-inventory'));

    function openModal() {
        modal.style.display = 'flex';
        inventoryList.innerHTML = '';

        if (inventoryData.length === 0) {
            inventoryList.innerHTML = '<li>Aucun objet dans l\'inventaire.</li>';
        } else {
            inventoryData.forEach(item => {
                const listItem = document.createElement('li');
                listItem.textContent = item.name;
                inventoryList.appendChild(listItem);
            });
        }
    }

    function closeModal() {
        modal.style.display = 'none';
    }

    showInventoryButton.addEventListener('click', openModal);
    closeModalButton.addEventListener('click', closeModal);

    window.addEventListener('click', function (event) {
        if (event.target === modal) {
            closeModal();
        }
    });
});
