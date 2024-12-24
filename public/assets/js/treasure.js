document.addEventListener("DOMContentLoaded", () => {
    const rollDiceButton = document.getElementById("roll-dice");
    const treasureResult = document.getElementById("treasure-result");
    const chapterLinks = document.getElementById("chapter-links");

    chapterLinks.style.display = "none";


    if (rollDiceButton) {
        rollDiceButton.addEventListener("click", () => {
            const condition = parseInt(rollDiceButton.dataset.condition, 10);
            const itemName = rollDiceButton.dataset.itemName;
            const itemId = rollDiceButton.dataset.itemId;
            const itemQuantity = rollDiceButton.dataset.itemQuantity;
            const roll = Math.floor(Math.random() * 6) + 1; // Dé 6 faces
            
            if (roll >= condition) {
                const data = {
                    itemId: itemId,
                    quantity: itemQuantity
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
                        treasureResult.textContent = `Félicitations ! Vous avez trouvé ${itemQuantity}x${itemName} avec un score de ${roll}.`;
                        console.log(`Loot ${item.name} ajouté à l'inventaire`);
                    } else {
                        treasureResult.textContent =  `vous n'avez pas assez de place pour ${itemQuantity}x${itemName}.`;
                    }
                })
                .catch(error => {
                    console.log('Erreur de communication avec le serveur:', error);
                });
            } else {
                treasureResult.textContent = `Quel dommage... Vous avez échoué avec un score de ${roll}.`;
            }

            // Afficher les liens après le lancer de dé
            chapterLinks.style.display = "flex";
            // Désactiver le bouton pour empêcher plusieurs lancers
            rollDiceButton.disabled = true;
        });
    }
});
