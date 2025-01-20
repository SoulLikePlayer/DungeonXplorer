<main>
    <div class="container">
        <div class="container-items">
            <?php if (isset($_SESSION['user']['hero'])): ?>
                <?php $hero = $_SESSION['user']['hero']; ?> 
                <h2>Personnage: <?= htmlspecialchars($hero['hero_firstname']) . " " . htmlspecialchars($hero['hero_lastname']) ?></h2>

                <p><strong>Classe:</strong> <?= htmlspecialchars($hero['class_name']) ?></p>
                <p><strong>Race:</strong> <?= htmlspecialchars($hero['race_name']) ?></p>
                <p><strong>Talent:</strong> <?= htmlspecialchars($hero['talent_name'] ?? 'aucun talent')?></p>

                <p><strong>Biographie:</strong> <?= htmlspecialchars($hero['biography'] ?? 'Non renseignée') ?></p>
                <div class="hero-card">
                    <h3>Statistiques</h3>
                    <ul>
                        <li><strong>Points de vie (PV) de base:</strong> <?= htmlspecialchars($hero['pv_max']) ?></li>
                        <li><strong>Mana de base:</strong> <?= htmlspecialchars($hero['mana_max']) ?></li>

                        <?php if (isset($_SESSION['Chapitre'])): ?>
                            <!-- Si l'utilisateur a commencé l'histoire, afficher les PV et Mana restants -->
                            <li><strong>Points de vie (PV) restants:</strong> <?= htmlspecialchars($hero['current_pv']) ?></li>
                            <li><strong>Mana restant:</strong> <?= htmlspecialchars($hero['current_mana']) ?></li>
                        <?php endif; ?>

                        <li><strong>Force:</strong> <?= htmlspecialchars($hero['strength']) ?></li>
                        <li><strong>Dexterité:</strong> <?= htmlspecialchars($hero['dexterity']) ?></li>
                        <li><strong>Connaissance Interdite:</strong> <?= htmlspecialchars($hero['forbidden_knowledge'])?></li>
                        <li><strong>Initiative:</strong> <?= htmlspecialchars($hero['initiative']) ?></li>
                        <li><strong>Domination:</strong> <?=htmlspecialchars($hero['domination']) ?></li>
                        <li><strong>Folie: </strong> <?=htmlspecialchars($hero['madness'])?></li>
                    </ul>
                </div>
                <div class="hero-container">
                    <div class="hero-card">
                        <h3>Équipement</h3>
                        <ul>
                            <li><strong>Arme principale:</strong> <?= $hero['primary_weapon_name'] ? htmlspecialchars($hero['primary_weapon_name']) : 'Aucune' ?>
                            <ul>
                                <li><strong>Bonus de dégâts:</strong> <?= $hero['primary_weapon_damage_bonus'] ?></li>
                                <li><strong>Bonus de défense:</strong> <?= $hero['primary_weapon_defense_bonus'] ?></li></li>
                            </ul>
                            </li>
                            <li><strong>Arme secondaire:</strong> <?= $hero['secondary_weapon_name'] ? htmlspecialchars($hero['secondary_weapon_name']) : 'Aucune' ?>
                            <ul>
                                <li><strong>Bonus de dégâts:</strong> <?= $hero['secondary_weapon_damage_bonus'] ?></li>
                                <li><strong>Bonus de défense:</strong> <?= $hero['secondary_weapon_defense_bonus'] ?></li></li>
                            </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="hero-card">
                        <h3>Armure</h3>
                        <ul>
                            <li><strong>Casque:</strong> <?= $hero['helmet_name'] ? htmlspecialchars($hero['helmet_name']) : 'Aucun' ?></li>
                            <li><strong>Plastron:</strong> <?= $hero['armor_name'] ? htmlspecialchars($hero['armor_name']) : 'Aucun' ?></li>
                            <li><strong>Grèves:</strong> <?= $hero['greaves_name'] ? htmlspecialchars($hero['greaves_name']) : 'Aucune' ?></li>
                            <li><strong>Gants:</strong> <?= $hero['gloves_name'] ? htmlspecialchars($hero['gloves_name']) : 'Aucune' ?></li>
                        </ul>
                    </div>
                    <div class="hero-card">
                        <h3>Autres détails</h3>
                        <ul>
                            <li><strong>Niveau actuel:</strong> <?= htmlspecialchars($hero['current_level']) ?></li>
                            <li><strong>XP:</strong> <?= htmlspecialchars($hero['xp']) ?></li>
                            <li><strong>Nombre d'objets max:</strong> <?= htmlspecialchars($hero['nb_items_max']) ?></li>
                            <li><strong>Bonus de défense :</strong> <?= htmlspecialchars($hero['total_defense_bonus']) ?></li>
                        </ul>
                    </div>
                    <div class="button-container">
                    <a href="/DungeonXplorer/hero/create" id='hero-button'>
                        <button> Créer un nouveau personnage </button>
                    </a>
                </div>
                </div>    
            <?php elseif ((!isset($_SESSION['user']['hero'])) && (isset($_SESSION['user']))): ?>
                <p>Aucun héros créé. Veuillez créer un personnage pour commencer votre aventure.</p>
                <div class="button-container">
                    <a href="/DungeonXplorer/hero/create" id='hero-button'>
                        <button> Créer un personnage </button>
                    </a>
                </div>
            <?php else : ?>
                <p>Aucun héros créé. Veuillez créer un personnage pour commencer votre aventure.</p>
            <?php endif; ?> 
        </div> 
        
        <!-- Conteneur pour l'histoire et la navigation -->
        <div class="container-items">
            <h2 id="HistoireTitre">"Les Ombres du Val Perdu"</h2>
            <p>Dans le village du Val Perdu, des jeunes filles disparaissent dans la forêt maudite. Le bourgmestre vous supplie de retrouver sa fille disparue. Au cœur des ombres se dresse un château en ruines, où un sorcier redouté tisse son intrigue. Oserez-vous choisir votre chemin à travers des créatures terrifiantes et des énigmes anciennes ? Plongez dans "Au Val Perdu" et découvrez si vous avez le courage de percer les mystères des ténèbres !</p>
            <div class="button-container">
                <?php if(isset($_SESSION['user'])): ?>
                    <a href="/DungeonXplorer/chapter/view/<?=$_SESSION['Chapitre'] ?? '1'?>">
                        <button>Allez à l'histoire</button>
                    </a>
                <?php else: ?>
                    <a href="/DungeonXplorer/user/login">
                        <button>Se connecter</button>
                    </a>
                <?php endif ?>
            </div>
        </div>
        
        <div class="container-items">
            <h2>Inventaire : </h2>
            <?php if (isset($_SESSION['user']['inventory'])): ?>
                <div class="inventory-grid">
                    <?php foreach($_SESSION['user']['inventory'] as $item): ?>
                        <div class="inventory-item">
                            <?php 
                                if ($item['imageName']):
                            ?>
                                <img class="pixelInventory" src="<?= htmlspecialchars("../DungeonXplorer/public/assets/PixelArt/" . $item['imageName']) ?>" alt="<?= htmlspecialchars($item['name']) ?>" class="inventory-image">
                            <?php else: ?>
                                <h4><?= htmlspecialchars($item['name']) ?></h4>
                            <?php endif; ?>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <p>Inventaire vide.</p>
            <?php endif; ?> 
        </div>

    </div>
</main>
