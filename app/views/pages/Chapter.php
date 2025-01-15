<main 
    data-chapter-type="<?= htmlspecialchars($chapter['chapter_type']) ?>" 
    data-ost-normal="<?= htmlspecialchars($_SESSION['ost']['normal']) ?>" 
    data-ost-combat="<?= htmlspecialchars($_SESSION['ost']['combat']) ?>"
>
    <div class="story-container">
        <!-- Bouton pour afficher l'inventaire général -->
        <button id="showInventoryButton" data-inventory='<?= json_encode($_SESSION['user']['inventory'] ?? []) ?>'>Afficher l'inventaire</button>
        
        <div id="inventoryModal" class="modal">
            <div class="modal-content">
                <span class="close-button" id="closeModalButton">&times;</span>
                <div class="inventory-container">
                    <ul id="inventoryList" class="inventory-list"></ul>
                    <div id="itemDetails" class="item-details">
                        <div class="item-header">
                            <img id="itemImage" src="" alt="Image">
                            <div class="text-container">
                                <p><strong>Nom :</strong> <span id="itemName">-</span></p>
                                <p><strong>Type :</strong> <span id="itemType">-</span></p>
                            </div>
                        </div>
                        <p><strong>Description :</strong> <span id="itemDescription">-</span></p>
                        <p><strong>Poids :</strong> <span id="itemWeight">-</span></p>
                        <p><strong>Valeur en or :</strong> <span id="itemGoldValue">-</span></p>
                        <p><strong>Quantité :</strong> <span id="itemQuantity">-</span></p>

                        <div id="itemActionButtons"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--modal du changement de malédiction -->
        <div id="curseModal" class="modal" 
            data-curse-modif="<?= htmlspecialchars($new_talent['new_name'] ?? "aucun") ?>">
            <div class="modal-content">
                <span class="close-button" id="closeModalButton">&times;</span>
                <h2> Votre malédiction passe de <span class="curse"> <?= htmlspecialchars($new_talent['old_name'] ?? "N/A") ?> </span> à <span class="final-curse"><?= htmlspecialchars($new_talent['new_name'] ?? "N/A") ?></span></h2>
                <p><?= htmlspecialchars($new_talent['new_description'] ?? "N/A") ?></p>
            </div>
        </div>

        <?php if($_SESSION['user']['hero']['talent_id'] === 23) : ?>
                <div id="future-modal" class="modal" style="display: none;">
                    <div class="modal-content">
                        <span class="close-modal">&times;</span>
                        <h3>Vision de l'avenir</h3>
                        <p id="future-vision-content">...</p>
                    </div>
                </div>
        <?php endif;?>

        <!--Modal de passage a niveaux-->

        <div id="levelUpModal" class="modal">
            <div class="modal-content">
                <h3>Félicitations, vous avez atteint un nouveau niveau !</h3>
                <p>Vous êtes maintenant au niveau <strong><span id="level"></span></strong>.</p>
                <p>Voici vos nouveaux bonus :</p>
                <ul>
                <li>PV maximum : <strong>+<span id="newPVBonus"></<span></strong></li>
                <li>Mana maximum : <strong>+<span id="newManaBonus"></<span></strong></li>
                <li>Force : <strong>+<span id="newStrenghtBonus"></<span></strong></li>
                <li>Initiative : <strong>+<span id="newInitiativeBonus"></<span></strong></li>
                <li>Domination : <strong>+<span id="newDominationBonus"></span></strong></li>
                </ul>
                <button id="continueButtonNewLevel">Continuer l'aventure</button>
            </div>
        </div>


        <!-- Modale pour utiliser un consommable en combat -->
        <div id="consumableModal" class="modal">
            <div class="modal-content">
                <span class="close-button" id="closeConsumableModalButton">&times;</span>
                <h3>Utiliser un consommable</h3>
                <ul id="consumablesList"></ul>
            </div>
        </div>

        <!-- Modal pour utiliser un spell en combat -->
        <div id="spellModal" class="modal">
            <div class="modal-content">
                <span class="close-button" id="closeCodexModalButton">&times;</span>
                <ul id="spellList"></ul>
            </div>
        </div>

        <!-- Modal de négociation -->
        <div id="negotiationModal" class="modal">
            <div class="modal-content">
            <span class="close-button">&times;</span>
            <h2>Négocier avec le marchand</h2>
                <div id="diceRollResult">
                    <p><strong>Marchand :</strong> <span id="merchantRoll">0</span></p>
                    <p><strong>Vous :</strong> <span id="playerRoll">0</span></p>
                </div>
                <button id="rollDiceButton">Lancer le dé</button>
                <p id="attemptMessage">Tentatives réussies : <span id="successCount">0</span>/3</p>
                <p id="negotiationMessage"></p>
                <p><strong>Réduction obtenue : </strong><span id="discount"></span></p>
            </div>
        </div>

        <?php if($chapter['chapter_type'] !== 'death'): ?>
            <h2 id="ChapterTitle"><?= htmlspecialchars($chapter['titre'] ?? 'Inconnu') ?></h2>
        <?php else: ?>
            <?php if($_SESSION['user']['hero']['talent_id'] === 21) : ?>
                <h2 id="ChapterTitleReturnDeath"><?= htmlspecialchars($chapter['titre'] ?? 'Inconnu') ?></h2>
            <?php else: ?>
                <h2 id="ChapterTitleDeath"><?= htmlspecialchars($chapter['titre'] ?? 'Inconnu') ?></h2>
            <?php endif; ?>
        <?php endif ?>

        <div class="chapter-content">
            <p><?= nl2br(htmlspecialchars($chapter['content'] ?? 'Aucun contenu disponible')) ?></p> 
        </div>

        <?php if ($chapter['chapter_type'] === 'combat'): ?>
            <div class="combat-container" id="combatContainer">
                <h3 id="combatMessage">Un combat commence contre <?= htmlspecialchars($_SESSION['monster']['name']) ?></h3>
                <button id="startCombatButton" 
                    data-hero-name="<?= htmlspecialchars($_SESSION['user']['hero']['hero_firstname'] . ' ' . $_SESSION['user']['hero']['hero_lastname']) ?>"
                    data-hero-talent="<?=htmlspecialchars($_SESSION['user']['hero']['talent_name'] ?? "Aucun talent") ?>"
                    data-hero-level="<?= htmlspecialchars($_SESSION['user']['hero']['current_level'])?>"
                    data-hero-pv="<?= htmlspecialchars($_SESSION['user']['hero']['current_pv']) ?>"
                    data-hero-pv-max="<?= htmlspecialchars($_SESSION['user']['hero']['pv_max']) ?>"
                    data-hero-mana="<?= htmlspecialchars($_SESSION['user']['hero']['current_mana']) ?>"
                    data-hero-mana-max="<?= htmlspecialchars($_SESSION['user']['hero']['mana_max']) ?>"
                    data-hero-strength="<?= htmlspecialchars($_SESSION['user']['hero']['strength']) ?>"
                    data-hero-initiative="<?= htmlspecialchars($_SESSION['user']['hero']['initiative']) ?>"
                    data-hero-is-thief="<?= htmlspecialchars($_SESSION['user']['hero']['class_id'] == 3 ? 'true' : 'false') ?>"
                    data-hero-primary-weapon-name="<?= htmlspecialchars($_SESSION['user']['hero']['primary_weapon_name']) ?>"
                    data-hero-primary-weapon-damage-bonus="<?= htmlspecialchars($_SESSION['user']['hero']['primary_weapon_damage_bonus']) ?>"
                    data-hero-primary-weapon-defense-bonus="<?= htmlspecialchars($_SESSION['user']['hero']['primary_weapon_defense_bonus']) ?>"
                    data-hero-primary-weapon-effect="<?= htmlspecialchars($_SESSION['user']['hero']['primary_weapon_effect'] ?? 'Aucune') ?>"
                    data-hero-secondary-weapon-name="<?= htmlspecialchars($_SESSION['user']['hero']['secondary_weapon_name']) ?>"
                    data-hero-secondary-weapon-damage-bonus="<?= htmlspecialchars($_SESSION['user']['hero']['secondary_weapon_damage_bonus']) ?>"
                    data-hero-secondary-weapon-defense-bonus="<?= htmlspecialchars($_SESSION['user']['hero']['secondary_weapon_defense_bonus']) ?>"
                    data-hero-secondary-weapon-effect="<?=htmlspecialchars($_SESSION['user']['hero']['secondary_weapon_effect'] ?? 'Aucune')?>"
                    data-hero-total-defense-bonus="<?= htmlspecialchars($_SESSION['user']['hero']['total_defense_bonus']) ?>"
                    data-monster-name="<?= htmlspecialchars($_SESSION['monster']['name']) ?>"
                    data-monster-pv="<?= htmlspecialchars($_SESSION['monster']['pv']) ?>"
                    data-monster-mana="<?= htmlspecialchars($_SESSION['monster']['mana']) ?>"
                    data-monster-strength="<?= htmlspecialchars($_SESSION['monster']['strength']) ?>"
                    data-monster-initiative="<?= htmlspecialchars($_SESSION['monster']['initiative']) ?>"
                    data-monster-xp="<?= htmlspecialchars($_SESSION['monster']['xp']) ?>"
                    data-monster-ost="<?=$_SESSION['monster']['ost'] === null ? null : htmlspecialchars($_SESSION['monster']['ost']) ?>"
                    data-next-chapter-win="<?= htmlspecialchars($links[0]['next_chapter_id']) ?? '#' ?>"
                    data-next-chapter-lose="<?= htmlspecialchars($links[1]['next_chapter_id']) ?? '#' ?>"
                    data-next-chapter-run="<?= htmlspecialchars($links[2]['next_chapter_id']) ?>"
                    data-monster-loot='<?= json_encode($_SESSION['monster']['loot']) ?>'
                    data-monster-attack='<?= json_encode($_SESSION['monster']['attack']) ?>'
                >
                    Commencer le combat
                </button>

                <div class="combat-actions" id="combatActions" style="display: none;">
                    <div id="combatInfo">
                    </div>
                    <div id="combatInfoContainer">
                        <div id="heroDies-container">
                            <p><span id="heroName"><?=htmlspecialchars($_SESSION['user']['hero']['hero_firstname'] . ' ' . $_SESSION['user']['hero']['hero_lastname'])?></span><br />
                            <img src="../../public/assets/PixelArt/Coeur.png" width="42" height="42" /> : <progress id="heroPvBar" max="100" value="" data-label="<?= $_SESSION['user']['hero']['current_pv'] ?>/<?= $_SESSION['user']['hero']['pv_max'] ?>"></progress><br /> 
                             <img src="../../public/assets/PixelArt/Mana.png" width="42" height="42" /> : <progress id="heroManaBar" max="100" value="" data-label="<?= $_SESSION['user']['hero']['current_mana'] ?>/<?= $_SESSION['user']['hero']['mana_max'] ?>"></progress><br />
                            Résultat <span id="heroDice"></p>
                        </div>
                        <div id="combatMessages" class="combat-messages"></div>
                        <div id="monsterDies-container">
                            <p><span id="monsterName"><?= htmlspecialchars($_SESSION['monster']['name'])?></span><br />
                            <progress id="monsterPvBar" max="100" value="" data-label="<?= $_SESSION['monster']['pv'] ?>/<?= $_SESSION['monster']['pv_max'] ?>"></progress> : <img src="../../public/assets/PixelArt/Coeur.png" width="42" height="42" /> <br />
                            <progress id="monsterManaBar" max="100" value="" data-label="<?= $_SESSION['monster']['mana'] ?>/<?= $_SESSION['monster']['mana_max'] ?>"></progress> : <img src="../../public/assets/PixelArt/Mana.png" width="42" height="42" /> <br /> 
                            Résultat <span id="monsterDice"></p>
                        </div>
                    </div>    
                    <div class="combat-buttons">
                        <select id="weaponChoice">
                            <option value="primary">Arme principale : <?= htmlspecialchars($_SESSION['user']['hero']['primary_weapon_name']) ?></option>
                            <option value="secondary">Arme secondaire : <?= htmlspecialchars($_SESSION['user']['hero']['secondary_weapon_name']) ?></option>
                        </select>
                        <div id="ActionButton">
                            <button id="attackButton"><img src="../../public/assets/PixelArt/Arme.png" width="42" height="42" /></button>
                            <button id="useSpellButton" data-spells='<?= json_encode($_SESSION['user']['inventoryCodex'] ?? []) ?>'><img src="../../public/assets/PixelArt/Sort.png" width="42" height="42" /></button>
                            <button id="useItemButton" data-inventory='<?= json_encode($_SESSION['user']['inventoryCons'])?>'><img src="../../public/assets/PixelArt/Consomable.png" width="42" height="42" /></button>
                            <button id="runButton"><img src="../../public/assets/PixelArt/Fuite.png" width="42" height="42" /></button>
                        </div>
                    </div>
                </div>

                <div id="lootContainer" style="display: none; margin-top: 20px;">
                    <h3>Loot obtenu :</h3>
                    <div id="lootList"></div>
                </div>
                <div id="xpContainer" style="display: none; margin-top: 20px;">
                    <h3>XP obtenue : </h3>
                    <div id="xpTexte"></div>
                </div>
            </div> 
            <script src="../../public/assets/js/lootSystem.js"></script>
            <script src="../../public/assets/js/CombatSysteme.js"></script>
        <?php elseif($chapter['chapter_type'] === 'npc_interaction' || $chapter['chapter_type'] === 'merchent'): ?>
            <div class="npc-container" id="npcContainer"
                data-dialogues='<?= json_encode($_SESSION['npc']['dialogues'] ?? []) ?>'
                data-first-sentence="<?= htmlspecialchars($_SESSION['npc']['INTRO_SENTENCE']) ?>"
                data-next-chapter-id="<?= htmlspecialchars($links[0]['next_chapter_id'] ?? '#') ?>"
                data-chapter-id="<?= htmlspecialchars($chapter['id']) ?>"
                data-next-chapter-description="<?= htmlspecialchars($links[0]['description'] ?? '') ?>"
                data-ost="<?=$_SESSION['npc']['OST'] === null ?  null : htmlspecialchars($_SESSION['npc']['OST']) ?>">
                <h3><?= htmlspecialchars($_SESSION['npc']['name']) ?></h3>
                <h2 class="npc-dialogue"></h2>
                <?php if ($chapter['chapter_type'] === 'merchent'): ?>
                    <div id="npcActionButtons"
                            data-merchant-tricky-level="<?=htmlspecialchars($_SESSION['npc']['merchent']['trickery_level'])?>"
                            data-hero-domination-level="<?=htmlspecialchars($_SESSION['user']['hero']['domination'])?>">
                        <?php if(isset($_SESSION['npc']['merchent']['refus_vente_achat'])): ?>
                            <?php if($_SESSION['npc']['merchent']['refus_vente_achat'] === false): ?>
                                <button id="buyButtonTab">Acheter</button>
                                <button id="sellButtonTab">Vendre</button>
                            <?php endif?>
                                <button id="continueAdventureButton">Continuer l'aventure</button>
                        <?php else: ?>
                            <button id="buyButtonTab">Acheter</button>
                            <button id="sellButtonTab">Vendre</button>
                            <button id="continueAdventureButton">Continuer l'aventure</button>
                        <?php endif; ?>
                    </div>
                    <div class="sell-container" id="sellContainer">
                        <h3>Vendre des objets</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Nom de l'objet</th>
                                    <th>Quantité disponible</th>
                                    <th>Prix unitaire (par objet)</th>
                                    <th>Quantité à vendre</th>
                                    <th>Prix unitaire</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($_SESSION['user']['inventory'] as $item): ?>
                                    <?php 
                                        $itemName = htmlspecialchars($item['name']);
                                        $itemStock = $item['quantity']; // Quantité dans l'inventaire
                                        $itemPrice = $item['gold_value']; // Prix unitaire
                                    ?>
                                    <tr>
                                        <td><?= $itemName ?></td>
                                        <td><?= $itemStock ?></td>
                                        <td><?= $itemPrice ?> pièces d'or</td>
                                        <td>
                                            <input 
                                                type="number" 
                                                class="quantity-input-sell" 
                                                data-item-id="<?= htmlspecialchars($item['item_id']) ?>" 
                                                name="quantity_<?= $itemName ?>" 
                                                min="0" 
                                                max="<?= $itemStock ?>" 
                                                value="0"
                                            >
                                        </td>
                                        <td>
                                            <input 
                                                type="number" 
                                                class="price-input" 
                                                data-item-id="<?= htmlspecialchars($item['item_id']) ?>" 
                                                name="price_<?= $itemName ?>" 
                                                min="0" 
                                                value="<?= $itemPrice ?>" 
                                                step="1" 
                                            >
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                        <div class="total-sale">
                            <p>Total de la vente : <span id="totalSalePrice">0</span> pièces d'or</p>
                            <button id="sellButton">Vendre</button>
                        </div>
                    </div>
                    <div class="merchent-container" id="merchantContainer">
                        <p>Pièce du marchand : <?=htmlspecialchars($_SESSION['npc']['merchent']['gold'])?></p>
                        <table>
                            <thead>
                                <tr>
                                    <th>Nom de l'objet</th>
                                    <th>Quantité disponible</th>
                                    <th>Prix (par unité)</th>
                                    <th>Quantité à acheter</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($_SESSION['npc']['merchent']['stock'] as $item): ?>
                                    <?php 
                                        $priceInitial = htmlspecialchars($item['price']); 
                                        $multiplicator = $_SESSION['npc']['merchent']['multiplicateur'] ?? 1;
                                        $priceFinal = round($priceInitial * $multiplicator, 2); 
                                    ?>
                                    <tr>
                                        <td><?= htmlspecialchars($item['name']) ?></td>
                                        <td><?= htmlspecialchars($item['stock']) ?></td>
                                        <td>
                                            <?php if ($multiplicator != 1): ?>
                                                <span style="text-decoration: line-through; color: red;">
                                                    <?= $priceInitial ?> pièces d'or
                                                </span>
                                                <span style="font-weight: bold; color: green;">
                                                    <?= $priceFinal ?> pièces d'or
                                                </span>
                                            <?php else: ?>
                                                <?= $priceInitial ?> pièces d'or
                                            <?php endif; ?>
                                        </td>
                                        <td>
                                            <?php if ($item['stock'] > 0): ?>
                                                <input 
                                                    type="number" 
                                                    class="quantity-input" 
                                                    data-price="<?= $priceFinal ?>" 
                                                    data-item-id="<?=htmlspecialchars($item['id'])?>"
                                                    name="quantity_<?= htmlspecialchars($item['name']) ?>" 
                                                    min="0" 
                                                    max="<?= htmlspecialchars($item['stock']) ?>" 
                                                    value="0">
                                            <?php else: ?>
                                                <span>Rupture de stock</span>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>

                        </table>
                        <button id="negotiateButton">Négocier</button>
                        <div id="negotiationResult" style="display: none;">
                            <p id="negotiationMessage"></p>
                            <p><strong>Réduction obtenue : </strong><span id="discount"></span></p>
                        </div>

                        <div class="total-purchase">
                            <p>Total : <span id="totalPrice">0</span> pièces d'or</p>
                            <button id="buyButton">Acheter</button>
                        </div>
                     </div>
                    <script src="../../public/assets/js/MerchantSystem.js"></script>
                <?php endif ?>
                <div class="npc-choices"></div>
            </div>
            <script src="../../public/assets/js/dialogueSystem.js"></script>
        <?php elseif ($chapter['chapter_type'] === 'exploration'): ?>
            <div class="exploration-links">
                <h3>Explorer</h3>
                <p><?= nl2br(htmlspecialchars($chapter['description'] ?? 'Aucune description d\'exploration disponible.')) ?></p>
                    <div class="links">
                    <?php foreach ($links as $link): ?>
                        <div class="link">
                            <a href="/DungeonXplorer/chapter/view/<?= htmlspecialchars($link['next_chapter_id'] ?? '#') ?>">
                                <button><?= nl2br(htmlspecialchars($link['description'] ?? 'Pas de description')) ?></button>
                            </a>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>            
            <?php else: ?>
                <?php if($chapter['chapter_type'] == "treasure") : ?>
                    <div class="treasure-container" id="treasureContainer">
                        <p>Un trésor pas loin ! Faites au minimum <span id="treasure-condition"><?= htmlspecialchars($_SESSION['treasure']['condition'] ?? 0) ?></span> pour le trouver !</p>
                        <button id="roll-dice" data-condition="<?= htmlspecialchars($_SESSION['treasure']['condition'] ?? 0) ?>" 
                                data-item-name="<?= htmlspecialchars($_SESSION['treasure']['item_name'] ?? 'Un objet mystère') ?>"
                                data-item-id="<?= htmlspecialchars($_SESSION['treasure']['item_id'] ?? 0) ?>"
                                data-item-quantity="<?= htmlspecialchars($_SESSION['treasure']['quantity'] ?? 0)?>">
                                Lancer le dé
                        </button>
                        <p id="treasure-result"></p>
                    </div>
                    <script src="../../public/assets/js/treasure.js"></script>
                <?php endif; ?>
                <div class="links" id="chapter-links">
                    <?php foreach ($links as $link): ?>
                        <div class="link">
                            <?php if ($chapter['chapter_type'] !== 'death'): ?>
                                <a href="/DungeonXplorer/chapter/view/<?= htmlspecialchars($link['next_chapter_id'] ?? '#') ?>">
                                    <button><?= nl2br(htmlspecialchars($link['description'] ?? 'Pas de description')) ?></button>
                                </a>
                            <?php else: ?>
                                <a href="/DungeonXplorer/chapter/reset">
                                    <button><?= nl2br(htmlspecialchars($link['description'] ?? 'Pas de description')) ?></button>
                                </a>
                            <?php endif; ?>

                            <?php if ($_SESSION['user']['hero']['talent_id'] === 23 && $chapter['chapter_type'] !== "death"): ?>
                                <!-- Bouton Voir l'avenir -->
                                <button class="view-future-btn" data-chapter-id="<?= htmlspecialchars($link['next_chapter_id'] ?? '#') ?>">
                                    Voir l'avenir
                                </button>
                            <?php endif; ?>
                        </div>
                    <?php endforeach; ?>
                </div>
                <?php if ($_SESSION['user']['hero']['talent_id'] === 23): ?> 
                    <script src="../../public/assets/js/FuturChapterSystem.js"></script>         
                <?php endif; ?>     
            <?php endif; ?>

    <div class="navigation">
        <a href="/DungeonXplorer">Retour à l'accueil</a> 
    </div>
</main>
<script src="../../public/assets/js/typewritingSystem.js"></script>
<script src="../../public/assets/js/inventoryModal.js"></script>
<script src="../../public/assets/js/curseModal.js"></script>
<script src="../../public/assets/js/songSystem.js"></script>