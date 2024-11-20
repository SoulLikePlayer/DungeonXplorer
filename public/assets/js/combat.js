document.getElementById('startCombatButton').addEventListener('click', function() {
    const hero = {
        name: this.dataset.heroName,
        pv: parseInt(this.dataset.heroPv),
        strength: parseInt(this.dataset.heroStrength),
        initiative: parseInt(this.dataset.heroInitiative),
        isThief: this.dataset.heroIsThief === 'true'
    };

    const monster = {
        name: this.dataset.monsterName,
        pv: parseInt(this.dataset.monsterPv),
        strength: parseInt(this.dataset.monsterStrength),
        initiative: parseInt(this.dataset.monsterInitiative)
    };

    // Récupérer les liens de redirection
    const nextChapterWin = this.dataset.nextChapterWin;
    const nextChapterLose = this.dataset.nextChapterLose;

    // Update combat info
    document.getElementById('heroName').textContent = hero.name;
    document.getElementById('heroPv').textContent = hero.pv;
    document.getElementById('monsterName').textContent = monster.name;
    document.getElementById('monsterPv').textContent = monster.pv;

    // Hide "Commencer le combat" button and show the combat action buttons
    document.getElementById('combatMessage').textContent = `Le combat commence contre ${monster.name}`;
    document.getElementById('startCombatButton').style.display = 'none';
    document.getElementById('combatActions').style.display = 'block';

    // Attaque physique
    document.getElementById('attackButton').addEventListener('click', function() {
        performHeroAttack(hero, monster, nextChapterWin, nextChapterLose); // Commencer l'attaque du héros
    });

    // Utiliser un objet (fonctionnalité à ajouter selon ta logique)
    document.getElementById('useItemButton').addEventListener('click', function() {
        displayCombatMessage("Utiliser un objet (fonctionnalité à implémenter)");
    });

    // Fuir (fonctionnalité à ajouter selon ta logique)
    document.getElementById('runButton').addEventListener('click', function() {
        displayCombatMessage("Fuir (fonctionnalité à implémenter)");
    });
});

function rollDie() {
    return Math.floor(Math.random() * 6) + 1;
}

function calculateAttack(character) {
    return rollDie() + character.strength;
}

function calculateDefense(character) {
    if (character.isThief) {
        return rollDie() + Math.floor(character.initiative / 2);
    } else {
        return rollDie() + Math.floor(character.strength / 2);
    }
}

function performHeroAttack(hero, monster, nextChapterWin, nextChapterLose) {
    const attack = calculateAttack(hero);
    const defense = calculateDefense(monster);
    const damage = Math.max(0, attack - defense);

    // Afficher message de l'attaque du héros
    displayCombatMessage(`${hero.name} attaque ${monster.name} et inflige ${damage} dégâts`);

    // Mettre à jour les PV du monstre
    monster.pv -= damage;
    document.getElementById('monsterPv').textContent = min(0, monster.pv);

    // Vérifier si le monstre est mort
    if (monster.pv <= 0) {
        displayCombatMessage(`${monster.name} a été vaincu !`);
        // Rediriger après la victoire
        setTimeout(function() {
            window.location.href = `/DungeonXplorer/chapter/view/${nextChapterWin}`;
        }, 1500); // Attendre 1.5 seconde avant la redirection
    } else {
        // Le monstre attaque après un délai
        setTimeout(function() {
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose);
        }, 1500); // Attente de 1.5 seconde avant que le monstre attaque
    }
}

function performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose) {
    const attack = calculateAttack(monster);
    const defense = calculateDefense(hero);
    const damage = Math.max(0, attack - defense);

    // Afficher message de l'attaque du monstre
    displayCombatMessage(`${monster.name} attaque ${hero.name} et inflige ${damage} dégâts`);

    // Mettre à jour les PV du héros
    hero.pv -= damage;
    document.getElementById('heroPv').textContent = hero.pv;

    // Vérifier si le héros est mort
    if (hero.pv <= 0) {
        displayCombatMessage(`${hero.name} a été vaincu !`);
        // Rediriger après la défaite
        setTimeout(function() {
            window.location.href = `/DungeonXplorer/chapter/view/${nextChapterLose}`;
        }, 1500); // Attendre 1.5 seconde avant la redirection
    }
}

function displayCombatMessage(message) {
    const messageElement = document.createElement('p');
    messageElement.textContent = message;
    document.getElementById('combatMessages').appendChild(messageElement);
    document.getElementById('combatMessages').scrollTop = document.getElementById('combatMessages').scrollHeight; // Scroll automatique vers le bas
}
