document.addEventListener('DOMContentLoaded', function () {
    class InventoryStrategy {
        constructor(url, data) {
            this.url = url;
            this.data = data;
        }

        sendRequest() {
            fetch(this.url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(this.data)
            })
            .then(response => response.json())
            .then(data => {
                console.log('Success:', data);
                window.location.reload();
            })
            .catch(error => console.error('Error:', error));
        }
    }

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
        } else if (item.item_type === 'âme') {
            createSoulButton(item);
        }
    }

    function createWeaponButtons(item) {
        const primaryButton = document.createElement('button');
        primaryButton.textContent = 'Equiper en arme principale';
        primaryButton.addEventListener('click', () => new InventoryStrategy('/DungeonXplorer/hero/updateWeaponSet', {id: item.item_id, type: 'primary'}).sendRequest());
        itemActionButtons.appendChild(primaryButton);

        const secondaryButton = document.createElement('button');
        secondaryButton.textContent = 'Equiper en arme secondaire';
        secondaryButton.addEventListener('click', () => new InventoryStrategy('/DungeonXplorer/hero/updateWeaponSet', {id: item.item_id, type: 'secondary'}).sendRequest());
        itemActionButtons.appendChild(secondaryButton);
    }

    function createArmorButton(item) {
        const equipButton = document.createElement('button');
        equipButton.textContent = 'Equiper';
        equipButton.addEventListener('click', () => new InventoryStrategy('/DungeonXplorer/hero/updateArmorSet', {id: item.item_id}).sendRequest());
        itemActionButtons.appendChild(equipButton);
    }

    function createSoulButton(item) {
        const consSoulButton = document.createElement('button');
        consSoulButton.textContent = "Consommer l'" + item.name;
        consSoulButton.addEventListener('click', () => consSoul(item));
        itemActionButtons.appendChild(consSoulButton);
    }

    function consSoul(item) {
        const soulChoiceModal = document.getElementById('soulChoiceModal').querySelector(".modal-content");
        console.log(soulChoiceModal);
        const SoulName = document.getElementById('SoulName');
        const soulContent = document.createElement('div');
        soulContent.classList.add('soul-choices');

        SoulName.textContent = item.name;
        document.getElementById('soulChoiceModal').style.display = 'flex';

        fetch(`/DungeonXplorer/soul/getSoulCapacity/${item.item_id}`)
            .then(response => response.json())
            .then(data => {
                soulContent.innerHTML = '';
                if (data.success && data.capacities.length > 0) {
                    data.capacities.forEach(capacity => {
                        const button = document.createElement('button');
                        button.textContent = capacity.name;
                        button.addEventListener('click', () => new InventoryStrategy('/DungeonXplorer/soul/applyEffect', {capacityId: capacity.id}).sendRequest());
                        soulContent.appendChild(button);
                    });
                } else {
                    soulContent.innerHTML = '<p>Aucune capacité disponible.</p>';
                }
            });

        soulChoiceModal.appendChild(soulContent);
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
