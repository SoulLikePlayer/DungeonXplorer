function rollForLoot(lootTable, soul) {
    const obtainedLoot = [];
    for (let i = 0; i < 3; i++) {
        const randomIndex = Math.floor(Math.random() * lootTable.length);
        const loot = lootTable[randomIndex];

        if (Math.random() * 100 <= loot.proba) {
            obtainedLoot.push({ id: loot.id, name: loot.name, quantity: loot.quantity });
        }
    }

    obtainedLoot.push({ id: soul.id, name : soul.name, quantity : 1});
    return obtainedLoot;
}

function saveLootToInventory(obtainedLoot) {
    const lootContainer = document.getElementById('lootContainer');
    lootContainer.innerHTML = '';

    lootContainer.style.display = 'block';
    if (obtainedLoot.length > 0) {
        obtainedLoot.forEach(item => {
            const data = {
                itemId: item.id,
                quantity: item.quantity
            };

            fetch('/DungeonXplorer/inventory/saveLoot', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)  
            })
            .then(response => response.json())  
            .then(data => {
                const lootElement = document.createElement('p');
                if (data.success) {
                    lootElement.textContent = `${item.quantity}x ${item.name}`;
                    console.log(`Loot ${item.name} ajouté à l'inventaire`);
                } else {
                    lootElement.textContent = `Vous n'avez pas assez de place pour ${item.quantity}x ${item.name}`
                }
                lootContainer.appendChild(lootElement);
            })
            .catch(error => {
                console.log('Erreur de communication avec le serveur:', error);
            });
        });
        fetch('/DungeonXplorer/inventory/getUpdateInventory')
        .then(response => response.json())
        .then(data => {
            if (data.success !== false) {
                console.log(data['inventory']);
                document.getElementById('showInventoryButton').setAttribute('data-inventory', JSON.stringify(data['inventory']))
            }
        })
        .catch(error => {
            console.error('Error fetching inventory:', error);
        });
    } else {
        const noLootMessage = document.createElement('p');
        noLootMessage.textContent = "Aucun loot obtenu.";
        lootContainer.appendChild(noLootMessage);
    }
}


function handleLoot(lootTable, soul) {
    const obtainedLoot = rollForLoot(lootTable, soul);
    saveLootToInventory(obtainedLoot);
}
