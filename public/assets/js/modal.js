document.addEventListener('DOMContentLoaded', function () {
    const modal = document.getElementById('inventoryModal');
    const showInventoryButton = document.getElementById('showInventoryButton');
    const closeModalButton = document.getElementById('closeModalButton');
    const inventoryList = document.getElementById('inventoryList');
    const inventoryData = JSON.parse(showInventoryButton.getAttribute('data-inventory'));

    const itemName = document.getElementById('itemName');
    const itemType = document.getElementById('itemType');
    const itemDescription = document.getElementById('itemDescription');
    const itemWeight = document.getElementById('itemWeight');
    const itemGoldValue = document.getElementById('itemGoldValue');
    const itemQuantity = document.getElementById('itemQuantity');
    const itemImage = document.getElementById('itemImage');

    function openModal() {
        modal.style.display = 'flex';
        inventoryList.innerHTML = '';

        if (inventoryData.length === 0) {
            inventoryList.innerHTML = '<li>Aucun objet dans l\'inventaire.</li>';
        } else {
            inventoryData.forEach(item => {
                const listItem = document.createElement('li');
                listItem.textContent = item.name;
                listItem.classList.add('inventory-item');
                listItem.setAttribute('data-id', item.id);

                listItem.dataset.item = JSON.stringify(item);
                listItem.addEventListener('click', () => displayItemDetails(item));
                inventoryList.appendChild(listItem);
            });
        }
    }

    function displayItemDetails(item) {
        itemName.textContent = item.name;
        itemType.textContent = item.item_type;
        itemDescription.textContent = item.description;
        itemWeight.textContent = item.poids;
        itemGoldValue.textContent = item.gold_value;
        itemQuantity.textContent = item.quantity;

        if (item.imageName) {
            itemImage.src = `../../public/assets/PixelArt/${item.imageName}`;
            itemImage.style.display = 'block';
        } else {
            itemImage.style.display = 'none'; 
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
