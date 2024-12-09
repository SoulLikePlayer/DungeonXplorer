document.addEventListener('DOMContentLoaded', () => {
    const npcContainer = document.getElementById('npcContainer');
    const buyButton = document.getElementById('buyButton');
    const quantityInputs = document.querySelectorAll('.quantity-input');
    const totalPriceElement = document.getElementById('totalPrice');
    const merchantContainer = document.getElementById('merchantContainer')
    const purchaseList = [];
    let merchantStock = {}; 
    let discountPercentage = 0; 
    const npcChoicesContainer = document.querySelector('.npc-choices');

    quantityInputs.forEach(input => {
        const itemId = input.getAttribute('data-item-id');
        const stock = parseInt(input.getAttribute('max'), 10);
        merchantStock[itemId] = stock;
    });

    const updateStockDisplay = () => {
        quantityInputs.forEach(input => {
            const itemId = input.getAttribute('data-item-id');
            const stock = merchantStock[itemId];

            if (stock > 0) {
                input.setAttribute('max', stock);
            } else {
                input.setAttribute('max', 0);
                input.value = 0; 
                const parentCell = input.parentNode;
                parentCell.innerHTML = '<span>Rupture de stock</span>';
            }
        });
    };

    // Calculer le total avec la réduction
    const calculateTotal = () => {
        let total = 0;

        quantityInputs.forEach(input => {
            const price = parseInt(input.getAttribute('data-price'), 10) || 0;
            const quantity = parseInt(input.value, 10) || 0;
            total += price * quantity;
        });

        const discountedTotal = total * (1 - discountPercentage); 
        totalPriceElement.textContent = discountedTotal.toFixed(2); 
    };

    quantityInputs.forEach(input => {
        input.addEventListener('input', calculateTotal);
    });

    buyButton.addEventListener('click', () => {
        let purchaseMade = false;

        quantityInputs.forEach(input => {
            const quantity = parseInt(input.value, 10) || 0;

            if (quantity > 0) {
                const itemId = input.getAttribute('data-item-id');
                const itemName = input.name.replace('quantity_', ''); 
                const price = parseInt(input.getAttribute('data-price'), 10);

                if (merchantStock[itemId] >= quantity) {
                    merchantStock[itemId] -= quantity;

                    purchaseList.push({
                        id: itemId,
                        name: itemName,
                        quantity: quantity,
                        price: price
                    });

                    purchaseMade = true;
                } else {
                    alert(`Stock insuffisant pour ${itemName}`);
                }
            }

            // Réinitialiser les quantités saisies
            input.value = 0;
        });

        if (purchaseMade) {
            alert("Achat effectué !");
            
            purchaseList.forEach(item => {
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
                        console.log(`Article ${item.name} ajouté à l'inventaire`);
                    } else {
                        console.error(`Erreur pour l'article ${item.name}`);
                    }
                })
                .catch(error => {
                    console.error('Erreur de communication avec le serveur:', error);
                });
            });
            console.log(parseInt(totalPriceElement.textContent))
            const gold = {
                goldSpent : parseInt(totalPriceElement.textContent)
            }

            fetch('/DungeonXplorer/hero/updateGold', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(gold)
            })
            .then(response => response.json())
            .then(gold => {
                if (gold.success) {
                    console.log(`quantité d'or mise a jour`);
                } else {
                    console.error(`Erreur de mise a jour de la quantité d'or`);
                }
            })
            .catch(error => {
                console.error('Erreur de communication avec le serveur:', error);
            });

            updateStockDisplay(); 
            calculateTotal();

        } else {
            alert("Aucun achat effectué !");
        }
        merchantContainer.style.display = "none";
        const continueButton = document.createElement('button');
        continueButton.textContent = "Continuer l'aventure";
        continueButton.id = "continueButton";
        continueButton.addEventListener('click', function () {
            window.location.href = `/DungeonXplorer/chapter/view/${npcContainer.dataset.nextChapterId}`;
        });
        npcChoicesContainer.appendChild(continueButton);
    });

    const negotiateButton = document.getElementById('negotiateButton');
    const negotiationModal = document.getElementById('negotiationModal');
    const rollDiceButton = document.getElementById('rollDiceButton');
    const merchantRollElement = document.getElementById('merchantRoll');
    const playerRollElement = document.getElementById('playerRoll');
    const successCountElement = document.getElementById('successCount');
    const negotiationMessageElement = document.getElementById('negotiationMessage');
    const discountElement = document.getElementById('discount');
    let successCount = 0;

    negotiateButton.addEventListener('click', () => {
        count = 0;
        discountPercentage = 0;
        successCount = 0;
        successCountElement.textContent = successCount;
        negotiationMessageElement.textContent = '';
        discountElement.textContent = 'Aucune réduction';
        negotiationModal.style.display = 'flex';
    });

    const rollDie = () => {
        return Math.floor(Math.random() * 6) + 1;
    };

    rollDiceButton.addEventListener('click', () => {
        const merchantRoll = rollDie();
        const playerRoll = rollDie();
        merchantRollElement.textContent = merchantRoll;
        playerRollElement.textContent = playerRoll;

        if (playerRoll > merchantRoll) {
            successCount++;
            successCountElement.textContent = successCount;

            if (successCount === 1) {
                discountPercentage = 0.25;
            } else if (successCount === 2) {
                discountPercentage = 0.50;
            } else if (successCount === 3) {
                discountPercentage = 0.75;
            }

            negotiationMessageElement.textContent = `Vous avez gagné cette tentative !`;
        } else {
            negotiationMessageElement.textContent = `Vous avez perdu cette tentative.`;
        }

        count++;

        discountElement.textContent = `${discountPercentage * 100}% de réduction`;
        calculateTotal();

        if (count >= 3) {
            setTimeout(() => {
                negotiationModal.style.display = 'none';
                alert(`Vous avez joué toutes les tentatives ! Réduction de ${discountPercentage * 100}% appliquée.`);
                negotiationModal.style.display = 'none';
                negotiateButton.style.display = 'none';
            }, 1000);
        }
    });

});
