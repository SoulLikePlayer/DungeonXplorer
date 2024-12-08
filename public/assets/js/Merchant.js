document.addEventListener('DOMContentLoaded', () => {
    const buyButton = document.getElementById('buyButton');
    const finishButton = document.getElementById('finishButton');
    const quantityInputs = document.querySelectorAll('.quantity-input');
    const totalPriceElement = document.getElementById('totalPrice');
    const purchaseList = [];
    let merchantStock = {}; 

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

    // Calculer le total à chaque modification
    const calculateTotal = () => {
        let total = 0;

        quantityInputs.forEach(input => {
            const price = parseInt(input.getAttribute('data-price'), 10) || 0;
            const quantity = parseInt(input.value, 10) || 0;

            total += price * quantity;
        });

        totalPriceElement.textContent = total;
    };

    quantityInputs.forEach(input => {
        input.addEventListener('input', calculateTotal);
    });

    // Gestion du clic sur "Acheter"
    buyButton.addEventListener('click', () => {
        let purchaseMade = false;

        quantityInputs.forEach(input => {
            const quantity = parseInt(input.value, 10) || 0;

            if (quantity > 0) {
                const itemId = input.getAttribute('data-item-id');
                const itemName = input.name.replace('quantity_', ''); // Extrait le nom
                const price = parseInt(input.getAttribute('data-price'), 10);

                // Vérifier le stock disponible
                if (merchantStock[itemId] >= quantity) {
                    merchantStock[itemId] -= quantity; // Réduire le stock

                    // Ajouter à la liste des achats
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
            updateStockDisplay(); // Mettre à jour l'affichage des stocks
            calculateTotal(); // Recalculer le total
            alert("Achat effectué !");
        } else {
            alert("Aucun achat effectué !");
        }
    });

    // Gestion du clic sur "Terminer les achats"
    finishButton.addEventListener('click', () => {
        if (purchaseList.length > 0) {
            purchaseList.forEach(item => {
                const data = {
                    itemId: item.id,
                    quantity: item.quantity
                };

                // Envoyer les articles au serveur
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

            alert("Achats terminés et ajoutés à l'inventaire.");
        } else {
            alert("Aucun article à ajouter.");
        }
    });
});
