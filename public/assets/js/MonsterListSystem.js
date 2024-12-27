document.addEventListener("DOMContentLoaded", function() {
    const monsterButtons = document.querySelectorAll('.monster-button');
    const modal = document.getElementById('monster-content');
    const closeModalButton = document.getElementById('close-modal');
    const editButton = document.getElementById('edit-monster');
    const saveButton = document.getElementById('save-changes');
    const editSection = document.getElementById('edit-section');
    const monsterName = document.getElementById('monster-name');
    const monsterStats = document.getElementById('monster-stats');
    const monsterLoots = document.getElementById('monster-loots');
    const monsterAttacks = document.getElementById('monster-attacks');
    
    let currentMonsterId = null;

    monsterButtons.forEach(button => {
        button.addEventListener('click', function() {
            currentMonsterId = this.getAttribute('data-monster-id');
            getMonster(currentMonsterId);
        });
    });

    closeModalButton.addEventListener('click', function() {
        modal.style.display = 'none';
    });

    editButton.addEventListener('click', function() {
        document.getElementById('edit-name').value = monsterName.textContent;
        document.getElementById('edit-stats').value = JSON.stringify(monsterStats.dataset.stats ? JSON.parse(monsterStats.dataset.stats) : {}, null, 2);
        document.getElementById('edit-xp').value = monsterStats.dataset.xp;

        editButton.style.display = 'none';
        monsterName.style.display = 'none';
        monsterStats.style.display = 'none';
        monsterLoots.style.display = 'none';
        monsterAttacks.style.display = 'none';

        editSection.style.display = 'block';
    });

    saveButton.addEventListener('click', function() {
        const newName = document.getElementById('edit-name').value;
        const newStats = document.getElementById('edit-stats').value;
        const newXp = document.getElementById('edit-xp').value;

        updateMonster(currentMonsterId, newName, newStats, newXp);
    });

    function getMonster(monsterId) {
        fetch(`/DungeonXplorer/monster/getMonster/${monsterId}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const monster = data.monster;
                    monsterName.textContent = monster.name;
                    monsterStats.dataset.stats = JSON.stringify(monster.stats);
                    monsterStats.dataset.xp = monster.xp;
                    monsterStats.innerHTML = `
                        <p>PV: ${monster.stats.pv}</p>
                        <p>Mana: ${monster.stats.mana}</p>
                        <p>Initiative: ${monster.stats.initiative}</p>
                        <p>Force: ${monster.stats.strength}</p>
                        <p>XP: ${monster.stats.xp}</p>
                    `;
                    monsterLoots.innerHTML = `<h4>Loots</h4>` + monster.loot.map(loot => `
                        <p>${loot.name} x${loot.quantity} (Probabilité: ${loot.proba}%)</p>
                    `).join('');
                    monsterAttacks.innerHTML = `<h4>Attaques</h4>` + monster.attacks.map(attack => `
                        <p>${attack.name} - Effet: ${attack.effect} - Mana: ${attack.mana_cost}</p>
                    `).join('');

                    monsterName.style.display = 'block';
                    monsterStats.style.display = 'block';
                    monsterLoots.style.display = 'block';
                    monsterAttacks.style.display = 'block';

                    editSection.style.display = 'none';

                    modal.style.display = 'flex';
                } else {
                    alert("Monstre non trouvé.");
                }
            })
            .catch(error => {
                console.error('Erreur:', error);
                alert('Une erreur est survenue.');
            });
    }

    function updateMonster(monsterId, newName, newStats, newXp) {
        try {
            // Parse le JSON des stats
            const parsedStats = JSON.parse(newStats);

            fetch(`/DungeonXplorer/monster/updateMonster`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    monsterId: monsterId,
                    name: newName,
                    stats: parsedStats,
                    xp: newXp
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Monstre mis à jour !");
                    modal.style.display = 'none';
                    getMonster(monsterId); // Recharger le monstre pour voir les changements
                } else {
                    alert("Échec de la mise à jour du monstre.");
                }
            })
            .catch(error => {
                console.error('Erreur:', error);
                alert('Une erreur est survenue lors de la mise à jour du monstre.');
            });
        } catch (error) {
            alert("Erreur dans le format des stats. Veuillez fournir un JSON valide.");
        }
    }
});
