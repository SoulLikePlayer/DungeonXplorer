function rollForLoot(lootTable) {
    const obtainedLoot = [];
    for (let i = 0; i < 3; i++) {
        const randomIndex = Math.floor(Math.random() * lootTable.length);
        const loot = lootTable[randomIndex];

        if (Math.random() * 100 <= loot.proba) {
            obtainedLoot.push({ id: loot.id, name: loot.name, quantity: loot.quantity });
        }
    }
    return obtainedLoot;
}

function displayLoot(obtainedLoot) {
    const lootContainer = document.getElementById('lootContainer');
    lootContainer.innerHTML = '';

    lootContainer.style.display = 'block';

    if (obtainedLoot.length > 0) {
        obtainedLoot.forEach(item => {
            const lootElement = document.createElement('p');
            lootElement.textContent = `${item.quantity}x ${item.name}`;
            lootContainer.appendChild(lootElement);
        });
    } else {
        const noLootMessage = document.createElement('p');
        noLootMessage.textContent = "Aucun loot obtenu.";
        lootContainer.appendChild(noLootMessage);
    }
}

function saveLootToInventory(obtainedLoot) {
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
            if (data.success) {
                console.log(`Loot ${item.name} ajouté à l'inventaire`);
            } else {
                console.error(`Erreur lors de l'ajout du loot ${item.name}`);
            }
        })
        .catch(error => {
            console.error('Erreur de communication avec le serveur:', error);
        });
    });
}



function handleLoot(lootTable) {
    const obtainedLoot = rollForLoot(lootTable);
    displayLoot(obtainedLoot);
    if (obtainedLoot.length > 0) {
        console.log(obtainedLoot);
        saveLootToInventory(obtainedLoot);
    }
}
