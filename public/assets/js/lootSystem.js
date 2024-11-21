function rollForLoot(lootTable) {
    const obtainedLoot = [];
    for (let i = 0; i < 3; i++) {
        const randomIndex = Math.floor(Math.random() * lootTable.length);
        const loot = lootTable[randomIndex];

        if (Math.random() * 100 <= loot.proba) {
            obtainedLoot.push({ name: loot.name, quantity: loot.quantity });
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

function handleLoot(lootTable) {
    const obtainedLoot = rollForLoot(lootTable);
    displayLoot(obtainedLoot);
    // TODO: Ajouter la persistance du loot dans la base de données
}
