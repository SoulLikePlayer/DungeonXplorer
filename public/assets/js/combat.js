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

    const nextChapterWin = this.dataset.nextChapterWin;
    const nextChapterLose = this.dataset.nextChapterLose;

    const heroInitiativeRoll = rollDie() + hero.initiative;
    const monsterInitiativeRoll = rollDie() + monster.initiative;

    displayCombatMessage(`${hero.name} lance un dé pour l'initiative : ${heroInitiativeRoll}`);
    displayCombatMessage(`${monster.name} lance un dé pour l'initiative : ${monsterInitiativeRoll}`);

    let firstAttacker;

    if (heroInitiativeRoll > monsterInitiativeRoll) {
        firstAttacker = 'hero';
    } else if (heroInitiativeRoll < monsterInitiativeRoll) {
        firstAttacker = 'monster';
    } else {
        if (hero.isThief) {
            firstAttacker = 'hero';
        } else {
            firstAttacker = 'monster';
        }
    }

    if (firstAttacker === 'hero') {
        displayCombatMessage(`${hero.name} attaque en premier !`);
    } else {
        displayCombatMessage(`${monster.name} attaque en premier !`);
        performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose);
    }

    document.getElementById('startCombatButton').style.display = 'none';
    document.getElementById('combatActions').style.display = 'block';

    document.getElementById('attackButton').addEventListener('click', function() {
        performHeroAttack(hero, monster, nextChapterWin, nextChapterLose);
    });
    
    document.getElementById('useItemButton').addEventListener('click', function() {
        displayCombatMessage("Utiliser un objet (fonctionnalité à implémenter)");
    });
    
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

    displayCombatMessage(`${hero.name} attaque ${monster.name} et inflige ${damage} dégâts`);

    monster.pv -= damage;
    document.getElementById('monsterPv').textContent = Math.max(0, monster.pv);

    if (monster.pv <= 0) {
        displayCombatMessage(`${monster.name} a été vaincu !`);
        setTimeout(function() {
            window.location.href = `/DungeonXplorer/chapter/view/${nextChapterWin}`;
        }, 1500);
    } else {
        setTimeout(function() {
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose);
        }, 1500);
    }
}

function performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose) {
    const attack = calculateAttack(monster);
    const defense = calculateDefense(hero);
    const damage = Math.max(0, attack - defense);

    displayCombatMessage(`${monster.name} attaque ${hero.name} et inflige ${damage} dégâts`);

    hero.pv -= damage;
    document.getElementById('heroPv').textContent = Math.max(0, hero.pv);

    if (hero.pv <= 0) {
        displayCombatMessage(`${hero.name} a été vaincu !`);
        setTimeout(function() {
            window.location.href = `/DungeonXplorer/chapter/view/${nextChapterLose}`;
        }, 1500);
    }
}

function displayCombatMessage(message) {
    const messageElement = document.createElement('p');
    messageElement.textContent = message;
    document.getElementById('combatMessages').appendChild(messageElement);
    document.getElementById('combatMessages').scrollTop = document.getElementById('combatMessages').scrollHeight;
}
