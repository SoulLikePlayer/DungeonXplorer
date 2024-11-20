document.getElementById('startCombatButton').addEventListener('click', function() {
    const hero = {
        name: this.dataset.heroName,
        pv: parseInt(this.dataset.heroPv),
        strength: parseInt(this.dataset.heroStrength),
        initiative: parseInt(this.dataset.heroInitiative),
        isThief: this.dataset.heroIsThief === 'true',
        primaryWeaponName: this.dataset.heroPrimaryWeaponName,
        primaryWeaponDamageBonus: this.dataset.heroPrimaryWeaponDamageBonus,
        primaryWeaponDefenseBonus: this.dataset.heroPrimaryWeaponDefenseBonus,
        secondaryWeaponName: this.dataset.heroSecondaryWeaponName,
        secondaryWeaponDamageBonus: this.dataset.heroSecondaryWeaponDamageBonus,
        secondaryWeaponDefenseBonus: this.dataset.heroSecondaryWeaponDefenseBonus,
        totalDefenseBonus: this.dataset.heroTotalDefenseBonus
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

    document.getElementById('monsterPv').textContent = monster.pv;
    document.getElementById('heroPv').textContent = hero.pv;

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
    let defense = 0;
    if (character.isThief) {
        defense += rollDie() + Math.floor(character.initiative / 2);
    } else {
        defense += rollDie() + Math.floor(character.strength / 2);
    }
    defense += parseInt(character.totalDefenseBonus || 0); 
    return defense;
}

function getWeaponBonus(hero, weaponChoice) {
    if (weaponChoice === 'primary') {
        return {
            damageBonus: parseInt(hero.primaryWeaponDamageBonus),
            defenseBonus: parseInt(hero.primaryWeaponDefenseBonus),
            weaponName: hero.primaryWeaponName
        };
    } else if (weaponChoice === 'secondary') {
        return {
            damageBonus: parseInt(hero.secondaryWeaponDamageBonus),
            defenseBonus: parseInt(hero.secondaryWeaponDefenseBonus),
            weaponName: hero.secondaryWeaponName
        };
    }
    return { damageBonus: 0, defenseBonus: 0, weaponName: 'Aucune arme' };
}

function performHeroAttack(hero, monster, nextChapterWin, nextChapterLose) {
    const weaponChoice = document.getElementById('weaponChoice').value;
    const weaponBonus = getWeaponBonus(hero, weaponChoice);

    const attack = rollDie() + hero.strength + weaponBonus.damageBonus;
    const defense = calculateDefense(monster);
    const damage = Math.max(0, attack - defense);

    displayCombatMessage(`${hero.name} attaque avec ${weaponBonus.weaponName} et inflige ${damage} dégâts`);

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
