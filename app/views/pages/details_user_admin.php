<h1>Informations détaillées</h1>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <div class="admin-detail">
    <h2> Informations Utilisateur </h2>
        <p> <?=htmlspecialchars($_SESSION['admin']['userSelect']['username']) ?> : <?=htmlspecialchars($_SESSION['admin']['userSelect']['email']) ?></p> 
    <h2> Informations Héros </h2>
    <div class ="container-detail-admin">
        <?php if (isset($_SESSION['admin']['userHeros'])) :?>
                    <?php $hero = $_SESSION['admin']['userHeros']; ?> 

                    <h3>Personnage: <?= htmlspecialchars($hero['hero_firstname']) . " " . htmlspecialchars($hero['hero_lastname']) ?></h3>

                    <p><strong>Classe:</strong> <?= htmlspecialchars($hero['class_id']) ?></p>

                    <p><strong>Biographie:</strong> <?= htmlspecialchars($hero['biography'] ?? 'Non renseignée') ?></p>

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
                        <li><strong>Initiative:</strong> <?= htmlspecialchars($hero['initiative']) ?></li>
                        <li><strong>Armure:</strong> <?= $hero['armor_name'] ? htmlspecialchars($hero['armor_name']) : 'Aucune' ?></li>
                    </ul>

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

                    <h3>Armure</h3>
                    <ul>
                        <li><strong>Casque:</strong> <?= $hero['helmet_name'] ? htmlspecialchars($hero['helmet_name']) : 'Aucun' ?></li>
                        <li><strong>Plastron:</strong> <?= $hero['armor_name'] ? htmlspecialchars($hero['armor_name']) : 'Aucun' ?></li>
                        <li><strong>Grèves:</strong> <?= $hero['greaves_name'] ? htmlspecialchars($hero['greaves_name']) : 'Aucune' ?></li>
                    </ul>

                    <h3>Autres détails</h3>
                    <ul>
                        <li><strong>Niveau actuel:</strong> <?= htmlspecialchars($hero['current_level']) ?></li>
                        <li><strong>XP:</strong> <?= htmlspecialchars($hero['xp']) ?></li>
                        <li><strong>Poids maximal:</strong> <?= htmlspecialchars($hero['poids_max']) ?> kg</li>
                        <li><strong>Nombre d'objets max:</strong> <?= htmlspecialchars($hero['nb_items_max']) ?></li>
                        <li><strong>Bonus de défense :</strong> <?= htmlspecialchars($hero['total_defense_bonus']) ?></li>
                    </ul>
    
                <?php else: ?>
                    <p>Aucun héros créé. Veuillez créer un personnage pour commencer votre aventure.</p>
                <?php endif; ?> 
    </div>
    </div> 
</main>