try{
    document.getElementById('startCombatButton').addEventListener('click', function () {
        const hero = {
            type: "hero",
            name: this.dataset.heroName,
            level: this.dataset.heroLevel,
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
            activeDebuff: [],
            xp : 0,
            isParalyzed : Boolean(false),
            isBind : Boolean(false),
            isImmobelize: Boolean(false),
            valIncrease: []
        };

        const monster = {
            type: "monster",
            name: this.dataset.monsterName,
            pv: parseInt(this.dataset.monsterPv),
            pvMax: parseInt(this.dataset.monsterPv),
            strength: parseInt(this.dataset.monsterStrength),
            initiative: parseInt(this.dataset.monsterInitiative),
            loot: JSON.parse(this.dataset.monsterLoot || '[]'),
            xp: this.dataset.monsterXp,
            activeBonuses: [],
            activeDebuff: [],
            isParalyzed : Boolean(false),
            isBind : Boolean(false),
            valIncrease: []
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
        document.getElementById('monsterPvMax').textContent = monster.pvMax;
        document.getElementById('heroPv').textContent = hero.pv;
        document.getElementById('heroPvMax').textContent = hero.pvMax;
        document.getElementById('heroMana').textContent = hero.mana;
        document.getElementById('heroManaMax').textContent = hero.manaMax;


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
            openSpellModal(codexData, hero, monster, consumablesData);
        })

        document.getElementById('attackButton').addEventListener('click', function () {
            performHeroAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun, consumablesData);
        });
        document.getElementById('runButton').addEventListener('click', function () {
            attemptEscape(hero, monster, nextChapterRun, nextChapterWin, consumablesData);
        });
        document.getElementById('useItemButton').addEventListener('click', function () {
            openConsumableModal(consumablesData, hero);
        });
    }

    function openSpellModal(codexData, hero, monster, consumablesData) {
        const spellModal = document.getElementById('spellModal');
        const spellList = document.getElementById('spellList');
    
        spellModal.style.display = 'flex';
        spellList.innerHTML = '';
    
        const codexItems = Object.values(codexData);
    
        if (codexItems.length === 0) {
            spellList.innerHTML = "<li>Aucun codex dans l'inventaire.</li>";
        } else {
            codexItems.forEach(item => {
                const itemArray = Object.values(item);
                const listItem = document.createElement('li');
                listItem.textContent = `${item.name} :`;
                spellList.appendChild(listItem);
    
                itemArray[3].forEach(spell => {
                    if (spell.level_required <= hero.level) {
                        const spellItem = document.createElement('button');
                        spellItem.className = "SpellButton";
                        spellItem.textContent = `${spell.name}`;
                        spellItem.addEventListener('click', function () {
                            showSpellDetails(spell, hero, monster, consumablesData, codexData);
                        });
                        spellList.appendChild(spellItem);
                    }
                });
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
    
    function showSpellDetails(spell, hero, monster, consumablesData, codexData) {
        const spellModal = document.getElementById('spellModal');
    
        const spellList = document.getElementById('spellList');
        spellList.innerHTML = `
            <div class="spell-details">
                <h4>${spell.name}</h4>
                <p><strong>Description :</strong> ${spell.effect}</p>
                <p><strong>Coût en Mana :</strong> ${spell.mana_cost}</p>
                <p><strong>Niveau Requis :</strong> ${spell.level_required}</p>
                <div class="spell-actions">
                    <button id="useSpellButton" class="SpellButton">Utiliser</button>
                    <button id="cancelSpellButton" class="CancelButton">Annuler</button>
                </div>
            </div>
        `;
    
        document.getElementById('useSpellButton').addEventListener('click', function () {
            analyzeEffectFunction(spell.effect_function, spell.mana_cost, hero, monster, consumablesData);
            spellModal.style.display = 'none';
        });
    
        document.getElementById('cancelSpellButton').addEventListener('click', function () {
            openSpellModal(codexData, hero, monster, consumablesData); 
        });
    }
    

    function analyzeEffectFunction(effectFunction, effectCost, user, cible, nextChapterWin, nextChapterLose, nextChapterRun, consumablesData) {
        if ((user.mana - effectCost) >= 0){
            console.log("2eme : "+effectFunction)
            user.mana -= effectCost
            document.getElementById("heroMana").textContent = user.mana
            const effects = effectFunction.split(';').map(effect => effect.trim());
            effects.forEach(effect => {
                const match = effect.match(/(\w+)\(([^)]+)\)/);
                if (!match) return;
                const effectName = match[1];
                console.log("3eme : "+effectName);
                const params = match[2].split(',').map(param => parseInt(param.trim()));
                switch (effectName) {
                    case 'burst':
                        cible.activeDebuff.push({ type: "burst", duration: parseInt(params[0]) });
                        displayCombatMessage(`${cible.name} subit un effet de brûlure pendant ${params[0]} tours.`);
                        break;
                    case 'reduce_attack':
                        cible.activeDebuff.push({ type: "attack", value: params[0], duration: params[1]});
                        displayCombatMessage(`${cible.name} voit sont attaque réduit de ${params[0]} pour ${params[1]} tours.`);
                        break;
                    case 'reduce_perception':
                        cible.activeDebuff.push({ type: "perception", value : params[0], duration: params[1]});
                        displayCombatMessage(`${cible.name} voit sont initiative réduit de ${params[0]} pour ${params[1]} tours.`);
                        break;
                    case 'reduce_morale':
                        cible.activeDebuff.push({ type: "attack", value: params[0], duration: params[1]});
                        cible.activeDebuff.push({ type: "perception", value : params[0], duration: params[1]});
                        displayCombatMessage(`${cible.name} est démoraliser pour ${params[1]}`);
                        break;
                    case 'reduce_resistance':
                        cible.activeDebuff.push({ type: "resistance", value : params[0], duration: params[1]});
                        displayCombatMessage(`${cible.name} voit sa résistance réduite de ${params[0]} pendant ${params[1]}`);
                        break;
                    case 'paralyze':
                        cible.activeDebuff.push({ type: "paralyze", duration: parseInt(params[0]) });
                        displayCombatMessage(`${cible.name} est paralysé pour ${params[0]} tour(s).`);
                        break;
                    case 'gain_mana':
                        user.mana = Math.min(user.mana + parseInt(params[0]), user.manaMax);
                        if (user.type == "hero"){
                            document.getElementById('heroMana').textContent = user.mana;
                        }
                        displayCombatMessage(`${user.name} regagne ${params[0]} points de mana.`);
                        break;
                    case 'heal_user':
                        user.pv = Math.min(user.pv + parseInt(params[0]), user.pvMax);
                        if (user.type == "hero"){
                            document.getElementById('heroPv').textContent = user.pv;
                        }
                        displayCombatMessage(`${user.name} se soigne de ${params[0]} points.`);
                        break;
                    case 'heal_user_per_turn':
                        user.activeBonuses.push({ type: "heal_user_turn", value: parseInt(params[0]), duration : parseInt(params[1])})
                        displayCombatMessage(`${user.name} se soigne de ${params[0]} points pendant ${params[1]}.`);
                        break;
                    case 'poison_effect':
                        cible.activeDebuff.push({ type: "poison", damagePerTurn: parseInt(params[0]), duration: parseInt(params[1]) });
                        displayCombatMessage(`${cible.name} est empoisonné et subira ${params[0]} dégâts par tour pendant ${params[1]} tours.`);
                        break;
                    case 'mana_shield':
                        user.activeBonus.push({ type: "mana_shield", value: parseInt(params[0]), duration: parseInt(params[1]) });
                        displayCombatMessage(`${user.name} active un bouclier de mana qui absorbera ${params[0]} dégâts pendant ${params[1]} tours.`);
                        break;
                    case 'restore_mana':
                        user.mana = Math.min(user.mana + parseInt(params[0]), user.manaMax);
                        if (user.type == 'hero'){
                            document.getElementById('heroMana').textContent = user.mana;
                        }
                        displayCombatMessage(`${user.name} restaure ${params[0]} points de mana.`);
                        break;
                    case 'slow_target':
                        cible.activeDebuff.push({ type: "slow", value: parseInt(params[0]), duration: parseInt(params[1]) });
                        displayCombatMessage(`${cible.name} voit sa vitesse réduite de ${params[0]} pour ${params[1]} tours.`);
                        break;
                    case 'shield_target':
                        user.activeBonuses.push({ type: "shield", value: parseInt(params[0]), duration: parseInt(params[1]) });
                        displayCombatMessage(`${user.name} est protégé par un bouclier qui absorbe ${params[0]} dégâts pendant ${params[1]} tours.`);
                        break;
                    case 'drain_health':
                        cible.activeDebuff.push({ type: "drain_health", damagePerTurn: parseInt(params[0]), duration: parseInt(params[1]) });
                        displayCombatMessage(`${cible.name} se fait drainer ${params[0]} de vie pendant ${params[1]} tours.`);
                        break;
                    case 'sacrifice_health':
                        if (user.pv - parseInt(params[0]) < 1) {
                            displayCombatMessage(`${user.name} ne peut pas utiliser le sort car il n'a pas assez de PV !`);
                        } else {
                            user.pv -= parseInt(params[0]);
                            displayCombatMessage(`${user.name} sacrifie ${params[0]} de vie.`);
                        }
                        document.getElementById('heroPv').textContent = user.pv;
                        break;
                    case 'increase_attack':
                        user.activeBonuses.push({ type: 'attack', value: parseInt(params[0]), remainingTurns: parseInt(params[1]) });
                        displayCombatMessage(`${user.name} reçoit un buff de dégât pendant ${params[1]} tours.`);
                        break;
                    case 'bind_target':
                        cible.activeDebuff.push({ type: 'bind', duration: parseInt(params[0]) });
                        displayCombatMessage(`${cible.name} est enchaîné pendant ${params[0]} tours mais peut se libérer !`);
                        break;
                    case 'immobilize':
                        cible.activeDebuff.push({ type: "immobilize", duration: parseInt(params[0]) });
                        displayCombatMessage(`${cible.name} est immobilisé pendant ${params[0]} tours.`);
                        break;
                    case 'soul_recovery':
                        user.activeBonuses.push({ type: "magick_attack", multiply: 2, duration: 1 });
                        displayCombatMessage(`La prochaine attaque magique de ${user.name} fera le double de ses dégâts.`);
                        break;
                    case 'flame_protection':
                        cible.activeDebuff.push({ type: "burst", duration: parseInt(params[0]) });
                        displayCombatMessage(`${user.name} se protège avec un voile de feu.`);
                        break;
                    case 'increase_speed':
                        user.activeBonuses.push({ type: "speed", value: parseInt(params[0]), duration: parseInt(params[1]) });
                        displayCombatMessage(`${user.name} augmente sa vitesse de ${params[0]} pendant ${params[1]} tours.`);
                        break;
                    case 'knock_back':
                        displayCombatMessage(`${cible.name} est repoussé par la force du sort.`);
                        break;
                    case 'pull_enemies':
                        displayCombatMessage(`${cible.name} est attiré vers le centre de la zone de gravité.`);
                        break;
                    case 'increase_mana':
                        user.manaMax += parseInt(params[0]);
                        user.valIncrease.push({ type : "mana", val : params[0], duration: params[1]});
                        document.getElementById('heroManaMax').textContent = user.manaMax;
                        displayCombatMessage(`${user.name} augmente sa capacité de mana de ${params[0]} pendant ${params[1]} tours.`);
                        break;
                    case 'blind_target':
                        cible.activeDebuff.push({ type: "blind", duration: parseInt(params[0]) });
                        displayCombatMessage(`${cible.name} est aveuglé pendant ${params[0]} tours.`);
                        break;
                        case 'damage':
                            const dieRoll = rollDie();
                            const rawDamage = dieRoll + parseInt(params[0]);
                            const defense = calculateDefense(cible);
                        
                            let finalDamage = Math.max(0, rawDamage - defense);
                            const soulRecoveryIndex = user.activeBonuses.findIndex(bonus => bonus.type === "magick_attack" && bonus.multiply === 2);
                            if (soulRecoveryIndex !== -1) {
                                finalDamage *= user.activeBonuses[soulRecoveryIndex].multiply;
                                displayCombatMessage(`<strong>Effet Soul Recovery activé : Dégâts multipliés par ${user.activeBonuses[soulRecoveryIndex].multiply} !</strong>`);
                                user.activeBonuses[soulRecoveryIndex].duration -= 1;
                                if (user.activeBonuses[soulRecoveryIndex].duration <= 0) {
                                    user.activeBonuses.splice(soulRecoveryIndex, 1);
                                }
                            }
                        
                            displayCombatMessage(
                                `${user.name} utilise un sort ! Lancer de dé : ${dieRoll}, ` +
                                `<br \>dégâts initiaux : ${rawDamage}, défense de ${cible.name} : ${defense}.<br \> ` +
                                `<br \><strong>Dégâts finaux : ${finalDamage}</strong>.`
                            );
                        
                            cible.pv -= finalDamage;
                            document.getElementById('monsterPv').textContent = Math.max(0, cible.pv);
                        
                            if (cible.pv <= 0) {
                                displayCombatMessage(`${cible.name} a été vaincu par le sort !`);
                                endFight(user, cible, nextChapterWin, consumablesData);
                            } else {
                                performMonsterAttack(user, cible, nextChapterWin, nextChapterLose, nextChapterRun);
                            }
                            break;                        
                    default:
                        console.log(`Effet inconnu : ${effectName} avec paramètres ${params.join(', ')}.`);
                }
                console.log(user.activeBonuses, cible.activeDebuff);
            });
        } else {
            displayCombatMessage(`${user.name} ne dispose pas assez de mana pour lancer le sort !`);
        }    
    }
    
    

    function openConsumableModal(consumablesData, hero) {
        const consumableModal = document.getElementById('consumableModal');
        const consumablesList = document.getElementById('consumablesList');

        consumableModal.style.display = 'flex';
        consumablesList.innerHTML = '';

        if (consumablesData.length === 0) {
            consumablesList.innerHTML = '<li>Aucun consommable dans l\'inventaire.</li>';
        } else {
            consumablesData.forEach((item, index) => {
                const listItem = document.createElement('button');
                listItem.className = "ConsButton";
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

    
    function Debuff(character, hero, monster, nextChapterWin, consumablesData) {
        if (!Array.isArray(character.activeDebuff)) {
            character.activeDebuff = [];
        }
    
        const debuffMessages = [];
    
        character.activeDebuff.forEach(debuff => {
            switch (debuff.type) {
                case "burst":
                    character.pv -= 2;
                    debuffMessages.push(`${character.name} a pris <span style="color:red;">-2</span> de vie dû au brûlure.`);
                    if(character.pv <= 0){
                        if(character == hero){

                        }else{
                            endFight(hero, monster);
                            const continueButton = document.createElement('button');
                            continueButton.textContent = "Continuer l'aventure";
                            continueButton.id = "continueButton";
                            continueButton.addEventListener('click', function () {
                                window.location.href = `/DungeonXplorer/chapter/view/${nextChapterWin}`;
                            });
                            document.getElementById('combatActions').appendChild(continueButton);
                        }
                    }
                    break;
                case 'poison':
                    character.pv -= debuff.damagePerTurn;
                    debuffMessages.push(`${character.name} a pris <span style="color:red;">-${debuff.damagePerTurn}</span> de vie dû au poisons.`);
                    debuff.damagePerTurn++;   
                    break; 
                case "paralyze" :
                    character.isParalyzed = Boolean(true);
                    debuffMessages.push(`${character.name} est paralysée, il ne peut pas attaquer`);
                    break;
                case 'bind' :
                    const baseRoll = rollDie() 
                    const InitiativeRoll = baseRoll + character.initiative; 
                    const bindSuccess = (InitiativeRoll / 2) > character.initiative; // Diviser le jet d'initiative par 2 et comparer avec l'initiative du personnage
                    displayCombatMessage(`Lancer d'initiative de ${character.name}: ${baseRoll}  <span style="color: #85c1e9;">+${character.initiative}</span> <span style="color: red;">/2</span> = ${(InitiativeRoll / 2)}`);
                    if (bindSuccess) {
                        debuffMessages.push(`${character.name} a échappé au lien grâce à son initiative !`);
                        character.activeDebuff = character.activeDebuff.filter(d => d !== debuff);
                    } else {
                        character.isBind = true;
                        debuffMessages.push(`${character.name} est lié et ne peut pas agir.`);
                    }
                    break;
                case 'immobilize':
                    character.isImmobelize = Boolean(true);
                    debuffMessages.push(`${character.name} est immobiliser, il ne peut pas attaquer`);
                    break;
                case "reduce_moral":
                    debuffMessages.push(`${character.name} subit une réduction de moral : <span style="color:red;">-${debuff.value}</span>.`);
                    break;
                }
            debuff.duration --;
        });

        character.activeDebuff = character.activeDebuff.filter(debuff => debuff.duration > 0);
        console.log(character.activeDebuff);

        debuffMessages.forEach(message => displayCombatMessage(message));
        if(character == hero){
            document.getElementById('heroPv').textContent = character.pv = Math.max(0, character.pv);
        }else{
            document.getElementById('monsterPv').textContent = character.pv = Math.max(0, character.pv);
        }
    }    

    function calculateAttack(character) {
        if (!Array.isArray(character.activeBonuses)) {
            character.activeBonuses = []; 
        }
    
        const dieRoll = rollDie();
        let baseAttack = dieRoll + character.strength;
    
        const bonusAttack = character.activeBonuses
            .filter(bonus => bonus.type === 'attack')
            .reduce((total, bonus) => total + bonus.value, 0);
    
        const debuffAttack = character.activeDebuff
            .filter(debuff => debuff.type === 'attack')
            .reduce((total, debuff) => total + debuff.value, 0);
    
        baseAttack += bonusAttack - debuffAttack;
    
        displayCombatMessage(
            `Lancer d'attaque: ${dieRoll} <span style="color: #85c1e9;">+${character.strength}</span>` +
            (bonusAttack > 0 ? ` <span style="color:green;">+${bonusAttack}</span>` : '') +
            (debuffAttack > 0 ? ` <span style="color:red;">-${debuffAttack}</span>` : '') +
            ` = Total: <strong>${baseAttack}</strong>`
        );
    
        return Math.max(0, baseAttack);
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
        let baseDefense = character.isThief
            ? dieRoll + Math.floor(character.initiative / 2)
            : dieRoll + Math.floor(character.strength / 2);
    
        const bonusDefense = character.activeBonuses
            .filter(bonus => bonus.type === 'defense')
            .reduce((total, bonus) => total + bonus.value, 0);
    
        const debuffDefense = character.activeDebuff
            .filter(debuff => debuff.type === 'resistance')
            .reduce((total, debuff) => total + debuff.value, 0);
    
        baseDefense += bonusDefense - debuffDefense;
    
        displayCombatMessage(
            `Lancer de défense: ${dieRoll} ` +
            `<span style="color: #85c1e9;">+${character.isThief ? Math.floor(character.initiative / 2) : Math.floor(character.strength / 2)}</span>` +
            (bonusDefense > 0 ? ` <span style="color:green;">+${bonusDefense}</span>` : '') +
            (debuffDefense > 0 ? ` <span style="color:red;">-${debuffDefense}</span>` : '') +
            ` <span style="color: #85c1e9;">+${character.totalDefenseBonus || 0}</span>` +
            ` = Total: <strong>${baseDefense + (character.totalDefenseBonus || 0)}</strong>`
        );
    
        return Math.max(0, baseDefense + (character.totalDefenseBonus || 0));
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
        fetch('/DungeonXplorer/inventory/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(consumablesData)
        });
    }

    function handleValIncrease(hero) {
        for (let i = 0; i < hero.valIncrease.length; i++) {
            let effect = hero.valIncrease[i];
            effect.duration -= 1; 
    
            if (effect.duration <= 0) {
                removeValIncreaseEffect(hero, effect);
                hero.valIncrease.splice(i, 1);
                i--; 
            }
        }
    }
    
    function removeValIncreaseEffect(hero, effect) {
        if (effect.type === "mana") {
            hero.manaMax -= parseInt(effect.val);
            document.getElementById('heroManaMax').textContent = hero.manaMax;
            if (hero.mana > hero.manaMax) {
                hero.mana = hero.manaMax;
                document.getElementById('heroMana').textContent = hero.mana;
            }
            displayCombatMessage(`${hero.name} perd ${effect.val} de mana max après la durée de l'effet.`);
        }
    }
    
    function clearValIncrease(hero) {
        for (let i = 0; i < hero.valIncrease.length; i++) {
            removeValIncreaseEffect(hero, hero.valIncrease[i]);
        }
        hero.valIncrease = []; 
    }

    function performHeroAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun, consumablesData) {
        clearCombatMessages();
        handleValIncrease(hero);

        console.log(hero.valIncrease);
        Debuff(hero, hero, monster, nextChapterWin, consumablesData);
        if (hero.isParalyzed == Boolean(true)) {
            hero.isParalyzed = Boolean(false);
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun);
            return;
        }

        if(hero.isBind == Boolean(true)){
            hero.isBind = Boolean(false);
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun);
            return;
        }

        if(hero.isImmobelize == Boolean(true)){
            hero.isImmobelize = Boolean(false);
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun);
            return;
        }
        const weaponChoice = document.getElementById('weaponChoice').value;
        const weaponBonus = getWeaponBonus(hero, weaponChoice);

        const attack = calculateAttack(hero) + weaponBonus.damageBonus
        
        const defense = calculateDefense(monster);
        const damage = Math.max(0, attack - defense);

        displayCombatMessage(`${hero.name} attaque avec ${weaponBonus.weaponName} (<span style="color:green;">+${weaponBonus.damageBonus}</span>)  et inflige ${damage} dégâts.`);
        monster.pv -= damage;
        if(monster.isImmobelize == true && damage > 0){
            monster.isImmobelize = Boolean(false)
            monster.activeDebuff.filter(name => debuff.name !== 'debuff => debuff.duration > 0');
            displayCombatMessage(`${monster.name} n'est plus immobilisé !`);
        }
        document.getElementById('monsterPv').textContent = Math.max(0, monster.pv);


        if (monster.pv <= 0) {
            displayCombatMessage(`${monster.name} a était tuée`);
            endFight(hero, monster, nextChapterWin, consumablesData);

            document.getElementById('ActionButton').style.display = 'none';


            const continueButton = document.createElement('button');
            continueButton.textContent = "Continuer l'aventure";
            continueButton.id = "continueButton";
            continueButton.addEventListener('click', function () {
                window.location.href = `/DungeonXplorer/chapter/view/${nextChapterWin}`;
            });
            document.getElementById('combatActions').appendChild(continueButton);
        } else {
            
            const bonusesHealPerTurn = hero.activeBonuses.find(bonus => bonus.type === 'heal_user_turn');
            if (bonusesHealPerTurn){
                hero.pv = Math.min(hero.pv + bonusesHealPerTurn.value, hero.pvMax);
                bonusesHealPerTurn.duration--;
                hero.activeBonuses.filter(bonus => bonus.duration > 0);
                displayCombatMessage(`${hero.name} se soigne de ${bonusesHealPerTurn.value}`);
            }

            const debufDrainedHeal = monster.activeDebuff.find(debuff => debuff.type === 'drain_health');
            if (debufDrainedHeal){
                monster.pv = Math.max(monster.pv - debufDrainedHeal.damagePerTurn, 1);
                debufDrainedHeal.duration --
                monster.activeDebuff.filter(debuff => debuff.duration > 0);
                displayCombatMessage(`${monster.name} perd ${debufDrainedHeal.damagePerTurn}`)
            }
            updateBonuses(hero);
            performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun);
        }
    }

    function performMonsterAttack(hero, monster, nextChapterWin, nextChapterLose, nextChapterRun) {
        Debuff(monster,  hero, monster, nextChapterWin);
        if (monster.isParalyzed) {
            monster.isParalyzed = false;
            return;
        }

        if (monster.isBind) {
            monster.isBind = false;
            return;
        }

        if(monster.isImmobelize){
            monster.isImmobelize = false;
            return;
        }

        if (monster.pv <= 0){
            return;
        }
        const attack = calculateAttack(monster);
        const defense = calculateDefense(hero);
        const damage = Math.max(0, attack - defense);

        displayCombatMessage(`${monster.name} attaque ${hero.name} et inflige ${damage} dégâts.`);
        hero.pv -= damage;
        document.getElementById('heroPv').textContent = Math.max(0, hero.pv);

        
        const bonusesHealPerTurn = hero.activeBonuses.find(bonus => bonus.type === 'heal_user_turn');
        if (bonusesHealPerTurn){
            hero.pv = Math.min(hero.pv + bonusesHealPerTurn.value, hero.pvMax);
            bonusesHealPerTurn.duration--;
            hero.activeBonuses.filter(bonus => bonus.duration > 0);
            displayCombatMessage(`${hero.name} se soigne de ${bonusesHealPerTurn.value}`);
        }

        const debufDrainedHeal = monster.activeDebuff.find(debuff => debuff.type === 'drain_health');
        if (debufDrainedHeal){
            monster.pv = Math.max(monster.pv - debufDrainedHeal.damagePerTurn, 1);
            debufDrainedHeal.duration --
            monster.activeDebuff.filter(debuff => debuff.duration > 0);
        }

        if (hero.pv <= 0) {
            displayCombatMessage(`${hero.name} a été vaincu !`);
            setTimeout(() => window.location.href = `/DungeonXplorer/chapter/view/${nextChapterLose}`, 1500);
        }
    }

    function attemptEscape(hero, monster, nextChapterRun, NextChapterWin, consumablesData) {
        clearCombatMessages();

        Debuff(hero, hero, monster, NextChapterWin, consumablesData);
        Debuff(monster, hero, monster, NextChapterWin, consumablesData);
       
        let escapeRoll = 0;
        if (hero.isParalyzed == false && hero.isBind == false){
            escapeRoll = rollDie() + hero.initiative;
            const debuff = hero.activeDebuff.find(debuff => debuff.type === 'perception');
            if (debuff){
                console.log("héro réduit")
                escapeRoll = Math.min(escapeRoll - debuff.values, 0);
            }
        }

        let monsterReactionRoll = 0;
        if (monster.isParalyzed == false && monster.isBind == false){
            monsterReactionRoll  = rollDie() + monster.initiative;
            const debuff = monster.activeDebuff.find(debuff => debuff.type === 'perception');
            if (debuff){
                console.log("monstre réduit")
                monsterReactionRoll = Math.min(monsterReactionRoll - debuff.values, 0);
            }
        }

        displayCombatMessage(`${hero.name} tente de fuir avec un jet de ${escapeRoll}`);
        displayCombatMessage(`${monster.name} réagit avec un jet de ${monsterReactionRoll}`);

        if (escapeRoll > monsterReactionRoll) {
            displayCombatMessage(`${hero.name} parvient à s'échapper !`);

            const data = {
                pv: hero.pv,
                mana: hero.mana,
                xp : hero.xp
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

    function endFight(hero, monster, nextChapterWin, consumablesData) {
        displayCombatMessage(`${monster.name} a été vaincu !`);
        
        const xpGained = monster.xp;
        hero.xp += xpGained;
        displayCombatMessage(`${hero.name} gagne <span style="color:gold;">${xpGained} xp</span> !`);
        console.log(monster.loot);
        handleLoot(monster.loot);
    
        const data = {
            pv: hero.pv,
            mana: hero.mana,
            xp: parseInt(hero.xp, 10),
        };
        console.log( JSON.stringify(data));

    
        fetch('/DungeonXplorer/hero/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())  
        .then(data => {
            console.log('Réponse JSON parsée :', data);
            if (data.success) {
                if (data.modalContent) {
                    const levelModal = document.getElementById('levelUpModal');

                    levelModal.style.display="flex";

                    const modalContent = data.modalContent;

                    document.getElementById("level").textContent=modalContent.newLevel

                    document.getElementById("newPVBonus").textContent=modalContent.pvBonus
                    document.getElementById("newManaBonus").textContent=modalContent.manaBonus
                    document.getElementById("newStrenghtBonus").textContent=modalContent.strengthBonus
                    document.getElementById("newInitiativeBonus").textContent=modalContent.initiativeBonus


                    document.getElementById("continueButtonNewLevel").addEventListener('click',  function() {
                        levelModal.style.display = "none";
                        window.location.href = `/DungeonXplorer/chapter/view/${nextChapterWin}`;
                    });
                }
            } else {
                console.error('Erreur:', data.message);
            }
        })
        .catch(error => {
            console.error('Erreur de communication avec le serveur:', error);
        });
        
    
        saveConsumablesState(consumablesData);

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