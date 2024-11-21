document.getElementById('startCombatButton').addEventListener('click', function () {
    const hero = {
        name: this.dataset.heroName,
        pv: parseInt(this.dataset.heroPv),
        strength: parseInt(this.dataset.heroStrength),
        initiative: parseInt(this.dataset.heroInitiative),
        isThief: this.dataset.heroIsThief === 'true',
        primaryWeaponName: this.dataset.heroPrimaryWeaponName,
        primaryWeaponDamageBonus: parseInt(this.dataset.heroPrimaryWeaponDamageBonus),
        primaryWeaponDefenseBonus: parseInt(this.dataset.heroPrimaryWeaponDefenseBonus),
        secondaryWeaponName: this.dataset.heroSecondaryWeaponName,
        secondaryWeaponDamageBonus: parseInt(this.dataset.heroSecondaryWeaponDamageBonus),
        secondaryWeaponDefenseBonus: parseInt(this.dataset.heroSecondaryWeaponDefenseBonus),
        totalDefenseBonus: parseInt(this.dataset.heroTotalDefenseBonus)
    };

    const monster = {
        name: this.dataset.monsterName,
        pv: parseInt(this.dataset.monsterPv),
        strength: parseInt(this.dataset.monsterStrength),
        initiative: parseInt(this.dataset.monsterInitiative),
        loot: JSON.parse(this.dataset.monsterLoot || '[]')
    };

    const nextChapterWin = this.dataset.nextChapterWin;
    const nextChapterLose = this.dataset.nextChapterLose;

    initializeCombat(hero, monster, nextChapterWin, nextChapterLose);
});

function initializeCombat(hero, monster, nextChapterWin, nextChapterLose) {
    const heroInitiativeRoll = rollDie() + hero.initiative;
    const monsterInitiativeRoll = rollDie() + monster.initiative;

    displayCombatMessage(`${hero.name} lance un dé pour l'initiative : ${heroInitiativeRoll}`);
    displayCombatMessage(`${monster.name} lance un dé pour l'initiative : ${monsterInitiativeRoll}`);

    document.getElementById('monsterPv').textContent = monster.pv;
    document.getElementById('heroPv').textContent = hero.pv;

    let firstAttacker =
        heroInitiativeRoll > monsterInitiativeRoll ||
        (heroInitiativeRoll === monsterInitiativeRoll && hero.isThief)
            ? 'hero'
            : 'monster';

    if (firstAttacker === 'monster') {
        performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose);
    }

    document.getElementById('startCombatButton').style.display = 'none';
    document.getElementById('combatActions').style.display = 'block';

    document.getElementById('attackButton').addEventListener('click', function () {
        performHeroAttack(hero, monster, nextChapterWin, nextChapterLose);
    });

    document.getElementById('useItemButton').addEventListener('click', function () {
        displayCombatMessage("Utiliser un objet (fonctionnalité à implémenter)");
    });

    document.getElementById('runButton').addEventListener('click', function () {
        displayCombatMessage("Fuir (fonctionnalité à implémenter)");
    });
}

function rollDie() {
    return Math.floor(Math.random() * 6) + 1;
}

function calculateAttack(character) {
    return rollDie() + character.strength;
}

function calculateDefense(character) {
    const baseDefense = character.isThief
        ? rollDie() + Math.floor(character.initiative / 2)
        : rollDie() + Math.floor(character.strength / 2);
    return baseDefense + (character.totalDefenseBonus || 0);
}

function getWeaponBonus(hero, weaponChoice) {
    return weaponChoice === 'primary'
        ? {
              damageBonus: hero.primaryWeaponDamageBonus,
              defenseBonus: hero.primaryWeaponDefenseBonus,
              weaponName: hero.primaryWeaponName
          }
        : {
              damageBonus: hero.secondaryWeaponDamageBonus,
              defenseBonus: hero.secondaryWeaponDefenseBonus,
              weaponName: hero.secondaryWeaponName
          };
}

function performHeroAttack(hero, monster, nextChapterWin, nextChapterLose) {
    const weaponChoice = document.getElementById('weaponChoice').value;
    const weaponBonus = getWeaponBonus(hero, weaponChoice);

    const attack = rollDie() + hero.strength + weaponBonus.damageBonus;
    const defense = calculateDefense(monster);
    const damage = Math.max(0, attack - defense);

    displayCombatMessage(`${hero.name} attaque avec ${weaponBonus.weaponName} et inflige ${damage} dégâts.`);
    monster.pv -= damage;
    document.getElementById('monsterPv').textContent = Math.max(0, monster.pv);

    if (monster.pv <= 0) {
        displayCombatMessage(`${monster.name} a été vaincu !`);
        handleLoot(monster.loot);
        setTimeout(() => window.location.href = `/DungeonXplorer/chapter/view/${nextChapterWin}`, 3000);
    } else {
        performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose);
    }
}

function performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose) {
    const attack = calculateAttack(monster);
    const defense = calculateDefense(hero);
    const damage = Math.max(0, attack - defense);

    displayCombatMessage(`${monster.name} attaque ${hero.name} et inflige ${damage} dégâts.`);
    hero.pv -= damage;
    document.getElementById('heroPv').textContent = Math.max(0, hero.pv);

    if (hero.pv <= 0) {
        displayCombatMessage(`${hero.name} a été vaincu !`);
        setTimeout(() => window.location.href = `/DungeonXplorer/chapter/view/${nextChapterLose}`, 1500);
    }
}

function displayCombatMessage(message) {
    const messageElement = document.createElement('p');
    messageElement.textContent = message;
    const combatMessages = document.getElementById('combatMessages');
    combatMessages.appendChild(messageElement);
    combatMessages.scrollTop = combatMessages.scrollHeight;
}
