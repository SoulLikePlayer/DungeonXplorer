document.addEventListener('DOMContentLoaded', function () {
    const modal = document.getElementById('inventoryModal');
    const showInventoryButton = document.getElementById('showInventoryButton');
    const closeModalButton = document.getElementById('closeModalButton');
    const inventoryList = document.getElementById('inventoryList');
    const inventoryData = JSON.parse(showInventoryButton.getAttribute('data-inventory'));

    function openModal() {
        modal.style.display = 'flex';
        inventoryList.innerHTML = '';  // Vider la liste avant de la remplir
        if (inventoryData.length === 0) {
            inventoryList.innerHTML = '<li>Aucun objet dans l\'inventaire.</li>';
        } else {
            inventoryData.forEach(item => {
                console.log(item);  // Affiche l'objet dans la console pour débogage
                const listItem = document.createElement('li');
                listItem.textContent = item.name;  // Affiche le nom de l'objet
                inventoryList.appendChild(listItem);  // Ajoute le <li> dans la liste
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
