document.addEventListener('DOMContentLoaded', () => {
    const npcContainer = document.getElementById('npcContainer');
    const buyButton = document.getElementById('buyButton');
    const quantityInputs = document.querySelectorAll('.quantity-input');
    const quantityInputsSell = document.querySelectorAll('.quantity-input-sell');
    const totalPriceElement = document.getElementById('totalPrice');
    const merchantContainer = document.getElementById('merchantContainer')
    const purchaseList = [];
    let merchantStock = {}; 
    let discountPercentage = 0; 
    const buyButtonTab = document.getElementById('buyButtonTab');
    const sellButtonTab =  document.getElementById('sellButtonTab');
    const npcChoicesContainer = document.querySelector('.npc-choices');

    const sellContainer = document.getElementById('sellContainer');
    const npcActionButtons = document.getElementById('npcActionButtons');
    const continueAdventureButton = document.getElementById('continueAdventureButton');

    const totalSalePriceElement = document.getElementById('totalSalePrice');
    const sellButton = document.getElementById('sellButton');
    const priceInputs = document.querySelectorAll('.price-input');
    const totalPrices = document.querySelectorAll('.total-price');
    let inventoryItems = [];


    sellContainer.style.display = 'none';
    merchantContainer.style.display = 'none';
    continueAdventureButton.addEventListener('click', () => {
        window.location.href = `/DungeonXplorer/chapter/view/${npcContainer.dataset.nextChapterId}`;
    });

    try{
        buyButtonTab.addEventListener('click', () => {
            npcActionButtons.style.display = 'none';
            merchantContainer.style.display = 'block';
        });

        quantityInputs.forEach(input => {
            const itemId = input.getAttribute('data-item-id');
            const stock = parseInt(input.getAttribute('max'), 10);
            merchantStock[itemId] = stock;
        });

        sellButtonTab.addEventListener('click', () => {
            npcActionButtons.style.display = 'none';
            sellContainer.style.display = 'block';
        });
    }catch{}

    const returnToButtons = () => {
        npcActionButtons.style.display = 'block';
        sellContainer.style.display = 'none';
        merchantContainer.style.display = 'none';
    };

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

    const updateTotalSalePrice = () => {
        let total = 0;
        quantityInputsSell.forEach((input, index) => {
            const quantity = parseInt(input.value, 10) || 0;
            const price = parseInt(priceInputs[index].value, 10);
            total += quantity * price;
        });
        totalSalePriceElement.textContent = total;
    };

    priceInputs.forEach(input => {
        input.addEventListener('input', updateTotalSalePrice);
    });

    quantityInputsSell.forEach(input => {
        input.addEventListener('input', updateTotalSalePrice);
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
            fetch('/DungeonXplorer/inventory/getUpdateInventory')
            .then(response => response.json())
            .then(data => {
                if (data.success !== false) {
                    document.getElementById('showInventoryButton').setAttribute('data-inventory', data['inventory'])
                }
            })
            .catch(error => {
                console.error('Error fetching inventory:', error);
            });
            console.log(parseInt(totalPriceElement.textContent))
            const gold = {
                goldSpent : 0-parseInt(totalPriceElement.textContent)
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
        returnToButtons();
    });

    sellButton.addEventListener('click', () => {
        let saleMade = false;
        quantityInputsSell.forEach((input, index) => {
            const quantity = parseInt(input.value, 10) || 0;
            if (quantity > 0) {
                const itemId = input.getAttribute('data-item-id');
                const itemName = input.name.replace('quantity_', '');
                const price = parseInt(priceInputs[index].value, 10);

                inventoryItems.push({
                    id: itemId,
                    name: itemName,
                    quantity: quantity,
                    price: price
                });

                saleMade = true;
            }
            input.value = 0;
        });

        if (saleMade) {
            alert("Vente effectuée !");
            inventoryItems.forEach(item => {
                const data = {
                    itemId: item.id,
                    quantity: item.quantity
                };
                fetch('/DungeonXplorer/inventory/sellLoot', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        console.log(`Article ${item.name} vendu`);
                    } else {
                        console.error(`Erreur pour l'article ${item.name}`);
                    }
                })
                .catch(error => {
                    console.error('Erreur de communication avec le serveur:', error);
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
            const gold = {
                goldSpent : parseInt(totalSalePriceElement.textContent)
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
            updateTotalSalePrice();
        } else {
            alert("Aucune vente effectuée !");
        }
        npcActionButtons.style.display = 'block';
        sellContainer.style.display = 'none';
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

    const trickyLevel = parseInt(document.getElementById('npcActionButtons').getAttribute('data-merchant-tricky-level'), 10) || 0;
    const heroDomination = parseInt(document.getElementById('npcActionButtons').getAttribute('data-hero-domination-level'), 10) || 0;
    
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
        const merchantFinal = merchantRoll + trickyLevel;
        const playerFinal = playerRoll + heroDomination;
    
        merchantRollElement.textContent = `${merchantRoll} + ${trickyLevel} = ${merchantFinal}`;
        playerRollElement.textContent = `${playerRoll} + ${heroDomination} = ${playerFinal}`;
    
        if (playerFinal > merchantFinal) {
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
    
        discountElement.textContent = `${(discountPercentage * 100).toFixed(0)}% de réduction`;
        calculateTotal();
    
        if (count >= 3) {
            setTimeout(() => {
                alert(`Vous avez joué toutes les tentatives ! Réduction de ${(discountPercentage * 100).toFixed(0)}% appliquée.`);
                negotiationModal.style.display = 'none';
                negotiateButton.style.display = 'none';
            }, 1000);
        }
    });
    

});
