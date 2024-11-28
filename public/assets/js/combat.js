try{
    document.getElementById('startCombatButton').addEventListener('click', function () {
        const hero = {
            name: this.dataset.heroName,
            pv: parseInt(this.dataset.heroPv),
            pvMax: parseInt(this.dataset.heroPvMax),
            mana: parseInt(this.dataset.heroMana),
            manaMax: parseInt(this.dataset.heroManaMax),
            strength: parseInt(this.dataset.heroStrength),
            initiative: parseInt(this.dataset.heroInitiative),
            isThief: this.dataset.heroIsThief === 'true',
            primaryWeaponName: this.dataset.heroPrimaryWeaponName,
            primaryWeaponDamageBonus: parseInt(this.dataset.heroPrimaryWeaponDamageBonus),
            primaryWeaponDefenseBonus: parseInt(this.dataset.heroPrimaryWeaponDefenseBonus),
            secondaryWeaponName: this.dataset.heroSecondaryWeaponName,
            secondaryWeaponDamageBonus: parseInt(this.dataset.heroSecondaryWeaponDamageBonus),
            secondaryWeaponDefenseBonus: parseInt(this.dataset.heroSecondaryWeaponDefenseBonus),
            totalDefenseBonus: parseInt(this.dataset.heroTotalDefenseBonus),
            activeBonuses: [],
            activeDebuff: []
        };

        const monster = {
            name: this.dataset.monsterName,
            pv: parseInt(this.dataset.monsterPv),
            strength: parseInt(this.dataset.monsterStrength),
            initiative: parseInt(this.dataset.monsterInitiative),
            loot: JSON.parse(this.dataset.monsterLoot || '[]'),
            activeBonuses: [],
            activeDebuff: []
        };

        const consumablesData = JSON.parse(document.getElementById('useItemButton').getAttribute('data-inventory'));
        const codexData = JSON.parse(document.getElementById('useSpellButton').getAttribute('data-spells'));

        const nextChapterWin = this.dataset.nextChapterWin;
        const nextChapterLose = this.dataset.nextChapterLose;
        const nextChapterRun = this.dataset.nextChapterRun;

        initializeCombat(hero, monster, consumablesData, nextChapterWin, nextChapterLose, nextChapterRun, codexData);
    });

    function initializeCombat(hero, monster, consumablesData, nextChapterWin, nextChapterLose, nextChapterRun, codexData) {
        const heroInitiativeRoll = rollDie() + hero.initiative;
        const monsterInitiativeRoll = rollDie() + monster.initiative;

        displayCombatMessage(`${hero.name} lance un dé pour l'initiative : ${heroInitiativeRoll}`);
        displayCombatMessage(`${monster.name} lance un dé pour l'initiative : ${monsterInitiativeRoll}`);

        document.getElementById('monsterPv').textContent = monster.pv;
        document.getElementById('heroPv').textContent = hero.pv;
        document.getElementById('heroMana').textContent = hero.mana;

        let firstAttacker = 
            heroInitiativeRoll > monsterInitiativeRoll || 
            (heroInitiativeRoll === monsterInitiativeRoll && hero.isThief)
                ? 'hero'
                : 'monster';

        if (firstAttacker === 'monster') {
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun);
        }

        document.getElementById('startCombatButton').style.display = 'none';
        document.getElementById('combatActions').style.display = 'block';

        document.getElementById('useSpellButton').addEventListener('click', function(){
            openSpellModal(codexData, hero, monster)
        })

        document.getElementById('attackButton').addEventListener('click', function () {
            performHeroAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun, consumablesData);
        });
        document.getElementById('runButton').addEventListener('click', function () {
            attemptEscape(hero, monster, nextChapterRun, consumablesData);
        });
        document.getElementById('useItemButton').addEventListener('click', function () {
            openConsumableModal(consumablesData, hero);
        });
    }

    function openSpellModal(codexData, hero, monster){
        const spellModal = document.getElementById('spellModal');
        const spellList = document.getElementById('spellList');

        spellModal.style.display='flex';

        const codexItems = Object.values(codexData);

        if (codexItems.length === 0) {
            spellList.innerHTML ="<li>Aucun codex dans l\'inventaire.</li>";
        }else{
            codexItems.forEach(item => {
                itemArray = Object.values(item)
                const listItem = document.createElement('li')
                listItem.textContent = `${item.name} :`;
                spellList.appendChild(listItem);
                itemArray[3].forEach(spell => {
                    console.log(spell);
                    const spellItem = document.createElement('button');
                    spellItem.className = "SpellButton";
                    spellItem.textContent = `${spell.name}`;
                    spellItem.addEventListener('click', function () {
                        analyzeEffectFunction(spell.effect_function, hero, monster);
                        spellModal.style.display = 'none';
                    });
                    spellList.append(spellItem);
                })
            });
        }

        document.getElementById('closeCodexModalButton').addEventListener('click', function () {
            spellModal.style.display = 'none';
        });

        window.addEventListener('click', function (event) {
            if (event.target === spellModal) {
                spellModal.style.display = 'none';
            }
        });
    }

    function analyzeEffectFunction(effectFunction, user, cible) {
        const effects = effectFunction.split(';').map(effect => effect.trim());
        effects.forEach(effect => {
            const match = effect.match(/(\w+)\(([^)]+)\)/);
            if (!match) return;
            const effectName = match[1];
            const params = match[2].split(',').map(param => param.trim());
            switch (effectName) {
                case 'burst' :
                    cible.activeDebuff.push({ type : "burst", duration : params[0]})
                    break;
                case 'reduce_attack':
                    console.log(`Réduit l'attaque de ${params[0]} pour ${params[1]} tours.`);
                    break;
                case 'reduce_perception':
                    console.log(`Réduit la perception de ${params[0]} pour ${params[1]} tours.`);
                    break;
                case 'reduce_moral':
                    console.log(`Réduit la force de ${params[0]} pour ${params[1]} tours.`)
                    break
                case 'reduce_resistances':
                    console.log(`Réduit la resistance de ${params[0]} pour ${params[1]} tours.`)    
                    break
                case 'paralyze':
                    console.log(`Paralyse l'ennemi pendant ${params[0]} tour(s).`);
                    break;
                case 'gain_mana':
                    console.log(`L'utilisateur regagne ${params[0]} points de mana pendant ${params[1]} tour(s).`);
                    break;
                case 'heal_user':
                    console.log(`Soigne l'utilisateur de ${params[0]} points pendant ${params[1]} tour(s).`);
                    break;
                case 'damage':
                    const dieRoll = rollDie()
                    damage = dieRoll + parseInt(params[0]);
                    console.log(dieRoll);
                    console.log(params[0])
                    cible.pv -= damage;
                    displayCombatMessage(`${user.name} attaque avec un sort et inflige ${damage} dégât.`);                    
                    break;
                default:
                    console.log(`Effet inconnu : ${effectName} avec paramètres ${params.join(', ')}.`);
            }
        });
    }
    

    function openConsumableModal(consumablesData, hero) {
        const consumableModal = document.getElementById('consumableModal');
        const consumablesList = document.getElementById('consumablesList');

        consumableModal.style.display = 'flex';
        consumablesList.innerHTML = '';

        if (consumablesData.length === 0) {
            consumablesList.innerHTML = '<li>Aucun consommable dans l\'inventaire.</li>';
        } else {
            console.log(consumablesData);
            consumablesData.forEach((item, index) => {
                const listItem = document.createElement('button');
                listItem.textContent = `${item.name} (X${item.quantity})`;
                listItem.addEventListener('click', function () {
                    useConsumable(item, hero, consumablesData, index);
                    consumableModal.style.display = 'none';
                });
                consumablesList.appendChild(listItem);
            });
        }

        document.getElementById('closeConsumableModalButton').addEventListener('click', function () {
            consumableModal.style.display = 'none';
        });

        window.addEventListener('click', function (event) {
            if (event.target === consumableModal) {
                consumableModal.style.display = 'none';
            }
        });
    }


    function useConsumable(item, hero, consumablesData, index) {
        if (item.effect_type === 'heal') {
            hero.pv = Math.min(hero.pv + item.heal_amount, hero.pvMax);
            document.getElementById('heroPv').textContent = hero.pv;
        } else if (item.effect_type === 'mana') {
            hero.mana = Math.min(hero.mana + item.mana_amount, hero.manaMax);
            document.getElementById('heroMana').textContent = hero.mana;
        } else if (item.effect_type === 'buff') {
            if (item.attack_buff) {
                hero.activeBonuses.push({ type: 'attack', value: item.attack_buff, remainingTurns: item.duration });
            }
            if (item.defense_buff) {
                hero.activeBonuses.push({ type: 'defense', value: item.defense_buff, remainingTurns: item.duration });
            }
        }
    
        item.quantity--;
        if (item.quantity <= 0) {
            consumablesData.splice(index, 1);
        }
    }

    function rollDie() {
        return Math.floor(Math.random() * 6) + 1;
    }

    
    function Debuff(character) {
        if (!Array.isArray(character.activeDebuff)) {
            character.activeDebuff = [];
        }
    
        const debuffMessages = [];
    
        character.activeDebuff.forEach(debuff => {
            switch (debuff.type) {
                case "burst":
                    character.pv -= 2;
                    debuffMessages.push(`${character.name} a pris <span style="color:red;">-2</span> de vie dû au débuff Burst.`);
                    break;
            }
            debuff.duration --;
        });

        character.activeDebuff = character.activeDebuff.filter(debuff => debuff.duration > 0);

        debuffMessages.forEach(message => displayCombatMessage(message));

        document.getElementById('monsterPv').textContent = character.pv = Math.max(0, character.pv);
    }    

    function calculateAttack(character) {
        if (!Array.isArray(character.activeBonuses)) {
            character.activeBonuses = []; 
        }
        const dieRoll = rollDie();
        const baseAttack = dieRoll + character.strength;
        const bonusAttack = character.activeBonuses
            .filter(bonus => bonus.type === 'attack')
            .reduce((total, bonus) => total + bonus.value, 0);
    
        displayCombatMessage(
            `Lancer d'attaque: ${dieRoll} <span style="color: #85c1e9 ;">+${character.strength}</span>` +
            (bonusAttack > 0 ? ` <span style="color:green;">+${bonusAttack}</span>` : '') +
            ` = Total: <strong>${baseAttack + bonusAttack}</strong>`
        );
    
        return baseAttack + bonusAttack;
    }
    
    
    function updateBonuses(character) {
        character.activeBonuses.forEach(bonus => bonus.remainingTurns--);
        character.activeBonuses = character.activeBonuses.filter(bonus => bonus.remainingTurns > 0);
    }

    function calculateDefense(character) {
        if (!Array.isArray(character.activeBonuses)) {
            character.activeBonuses = []; 
        }
        const dieRoll = rollDie();
        const baseDefense = character.isThief
            ? dieRoll + Math.floor(character.initiative / 2)
            : dieRoll + Math.floor(character.strength / 2);
    
        const bonusDefense = character.activeBonuses
            .filter(bonus => bonus.type === 'defense')
            .reduce((total, bonus) => total + bonus.value, 0);
    
        displayCombatMessage(
            `Lancer de défense: ${dieRoll} ` +
            `<span style="color: #85c1e9 ;">+${character.isThief ? Math.floor(character.initiative / 2) : Math.floor(character.strength / 2)}</span>` +
            (bonusDefense > 0 ? ` + <span style="color:green;">+${bonusDefense}</span>` : '') +
            ` <span style="color: #85c1e9 ;">+${character.totalDefenseBonus || 0}</span>` +
            ` = Total: <strong>${baseDefense + bonusDefense + (character.totalDefenseBonus || 0)}</strong>`
        );
    
        return baseDefense + bonusDefense + (character.totalDefenseBonus || 0);
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

    function saveConsumablesState(consumablesData) {
        console.log(consumablesData);
        fetch('/DungeonXplorer/inventory/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(consumablesData)
        });
    }

    function performHeroAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun, consumablesData) {
        clearCombatMessages();
        Debuff(hero);
        const weaponChoice = document.getElementById('weaponChoice').value;
        const weaponBonus = getWeaponBonus(hero, weaponChoice);

        const attack = calculateAttack(hero) + weaponBonus.damageBonus
        
        const defense = calculateDefense(monster);
        const damage = Math.max(0, attack - defense);

        displayCombatMessage(`${hero.name} attaque avec ${weaponBonus.weaponName} (<span style="color:green;">+${weaponBonus.damageBonus}</span>)  et inflige ${damage} dégâts.`);
        monster.pv -= damage;
        document.getElementById('monsterPv').textContent = Math.max(0, monster.pv);

        if (monster.pv <= 0) {
            displayCombatMessage(`${monster.name} a été vaincu !`);
            handleLoot(monster.loot);
            const data = {
                pv: hero.pv,
                mana: hero.mana
            }
            fetch('/DungeonXplorer/hero/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)  
            })
            .then(response => response.json())  
            .then(data => {
                if (data.success) {
                    console.log(`Héro mise a jour`);
                } else {
                    console.error(`Erreur lors de la mise a jour du héro`);
                }
            })
            .catch(error => {
                console.error('Erreur de communication avec le serveur:', error);
            });
            saveConsumablesState(consumablesData);
            setTimeout(() => window.location.href = `/DungeonXplorer/chapter/view/${nextChapterWin}`, 3000);
        } else {
            updateBonuses(hero);
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun);
        }
    }

    function performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun) {
        Debuff(monster);
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

    function attemptEscape(hero, monster, nextChapterRun, consumablesData) {
        clearCombatMessages();

        const escapeRoll = rollDie();
        const monsterReactionRoll = rollDie();

        displayCombatMessage(`${hero.name} tente de fuir avec un jet de ${escapeRoll}`);
        displayCombatMessage(`${monster.name} réagit avec un jet de ${monsterReactionRoll}`);

        if (escapeRoll > monsterReactionRoll) {
            displayCombatMessage(`${hero.name} parvient à s'échapper !`);

            const data = {
                pv: hero.pv,
                mana: hero.mana
            }
            fetch('/DungeonXplorer/hero/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)  
            })
            .then(response => response.json())  
            .then(data => {
                if (data.success) {
                    console.log(`Héro mise a jour`);
                } else {
                    console.error(`Erreur lors de la mise a jour du héro`);
                }
            })
            .catch(error => {
                console.error('Erreur de communication avec le serveur:', error);
            });
            saveConsumablesState(consumablesData);
            setTimeout(() => window.location.href = `/DungeonXplorer/chapter/view/${nextChapterRun}`, 1500);
        } else {
            updateBonuses(hero);
            displayCombatMessage(`${hero.name} échoue à fuir et reste engagé dans le combat.`);
            performMonsterAttack(hero, monster);
        }
    }

    function clearCombatMessages() {
        const combatMessages = document.getElementById('combatMessages');
        combatMessages.innerHTML = ''; 
    }
    

    function displayCombatMessage(message) {
        const messageElement = document.createElement('p');
        messageElement.innerHTML = message; 
        const combatMessages = document.getElementById('combatMessages');
        combatMessages.appendChild(messageElement);
        combatMessages.scrollTop = combatMessages.scrollHeight;
    }
    
}catch{}