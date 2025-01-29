document.addEventListener('DOMContentLoaded', function () {
    const modal = document.getElementById('inventoryModal');
    const showInventoryButton = document.getElementById('showInventoryButton');
    const closeModalButton = document.getElementById('closeModalButton');
    const inventoryList = document.getElementById('inventoryList');

    const itemName = document.getElementById('itemName');
    const itemType = document.getElementById('itemType');
    const itemDescription = document.getElementById('itemDescription');
    const itemWeight = document.getElementById('itemWeight');
    const itemGoldValue = document.getElementById('itemGoldValue');
    const itemQuantity = document.getElementById('itemQuantity');
    const itemImage = document.getElementById('itemImage');
    const itemActionButtons = document.getElementById('itemActionButtons'); 

    function openModal() {
        modal.style.display = 'flex';
        inventoryList.innerHTML = '';
        const inventoryData = JSON.parse(showInventoryButton.getAttribute('data-inventory'));

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

        itemActionButtons.innerHTML = '';

        if (item.imageName) {
            itemImage.src = `../../public/assets/PixelArt/${item.imageName}`;
            itemImage.style.display = 'block';
        } else {
            itemImage.style.display = 'none'; 
        }

        if (item.item_type === 'arme') {
            createWeaponButtons(item);
        } else if (item.item_type === 'armure') {
            createArmorButton(item);
        }
    }

    function createWeaponButtons(item) {
        console.log(item)
        const primaryButton = document.createElement('button');
        primaryButton.textContent = 'Equiper en arme principal';
        primaryButton.addEventListener('click', () => equipWeapon(item.item_id, 'primary'));
        itemActionButtons.appendChild(primaryButton);

        const secondaryButton = document.createElement('button');
        secondaryButton.textContent = 'Equiper en arme secondaire';
        secondaryButton.addEventListener('click', () => equipWeapon(item.item_id, 'secondary'));
        itemActionButtons.appendChild(secondaryButton);
    }

    function createArmorButton(item) {
        const equipButton = document.createElement('button');
        equipButton.textContent = 'Equiper';
        equipButton.addEventListener('click', () => equipArmor(item.item_id));
        itemActionButtons.appendChild(equipButton);
    }

    function equipWeapon(itemId, type) {
        const url = `/DungeonXplorer/hero/updateWeaponSet`;
        const data = {
            id: itemId,
            type: type
        };
        sendRequest(url, data);
    }

    function equipArmor(itemId) {
        const url = `/DungeonXplorer/hero/updateArmorSet`;
        const data = {
            id: itemId
        };
        sendRequest(url, data);
    }

    function sendRequest(url, data) {
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            window.location.reload()
        })
        .catch(error => {
            console.error('Error:', error);
        });
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
