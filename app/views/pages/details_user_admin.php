<h1>Informations détaillées</h1>
<main class="container-admin">
    <div class="container-detail-admin">
        <h2> Informations Utilisateur </h2>
        <p> <?=htmlspecialchars($_SESSION['admin']['userSelect']['username']) ?> : <?=htmlspecialchars($_SESSION['admin']['userSelect']['email']) ?></p> 
    </div>
    <div class ="container-detail-admin">
        <h2> Informations Héros </h2>
        <?php if ($_SESSION['admin']['userHeros']) :?>
            <?php $hero = $_SESSION['admin']['userHeros']; ?> 
                <h2>Personnage: <?= htmlspecialchars($hero['hero_firstname']) . " " . htmlspecialchars($hero['hero_lastname']) ?></h2>

                <p><strong>Classe:</strong> <?= htmlspecialchars($hero['class_name']) ?></p>
                <p><strong>Race:</strong> <?= htmlspecialchars($hero['race_name']) ?></p>

                <p><strong>Biographie:</strong> <?= htmlspecialchars($hero['biography'] ?? 'Non renseignée') ?></p>
                <div class="hero-card">
                    <h3>Statistiques</h3>
                    <ul>
                        <li><strong>Points de vie (PV) de base:</strong> <?= htmlspecialchars($hero['pv_max']) ?></li>
                        <li><strong>Mana de base:</strong> <?= htmlspecialchars($hero['mana_max']) ?></li>

                        <li><strong>Force:</strong> <?= htmlspecialchars($hero['strength']) ?></li>
                        <li><strong>Initiative:</strong> <?= htmlspecialchars($hero['initiative']) ?></li>
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
                            <li><strong>Poids maximal:</strong> <?= htmlspecialchars($hero['poids_max']) ?> kg</li>
                            <li><strong>Nombre d'objets max:</strong> <?= htmlspecialchars($hero['nb_items_max']) ?></li>
                            <li><strong>Bonus de défense :</strong> <?= htmlspecialchars($hero['total_defense_bonus']) ?></li>
                        </ul>
                    </div>
                </div>    
            <?php else : ?>
                <p>Aucun héros créé.</p>
            <?php endif; ?> 
            </div>
            </div>
    </div> 
    <div class="container-detail-admin">
        <h2> Statistiques de l'utilisateur </h2>

        <?php if (isset($_SESSION['admin']['userStat'])): ?>
            <?php $stats = $_SESSION['admin']['userStat']; ?>

            <div class="stats-card">
                <h3>Statistiques générales</h3>
                <ul>
                    <li><strong>Total de morts :</strong> <?= htmlspecialchars($stats['stats']['total_deaths'] ?? 'Non disponible') ?></li>
                    <li><strong>Chapitre maximal atteint :</strong> <?= htmlspecialchars($stats['stats']['max_chapter'] ?? 'Non disponible') ?></li>
                    <li><strong>Temps total passé en jeu :</strong> <?= isset($stats['sessions']['total']) ? gmdate("H:i:s", $stats['sessions']['total']) : 'Non disponible' ?></li>
                </ul>
            </div>

            <div class="stats-card">
                <h3>Historique des morts</h3>
                <?php if (!empty($stats['deaths'])): ?>
                    <ul>
                        <?php foreach ($stats['deaths'] as $death): ?>
                            <li>
                                <strong>Chapitre :</strong> <?= htmlspecialchars($death['chapter_id']) ?> - 
                                <strong>Morts :</strong> <?= htmlspecialchars($death['death_count']) ?>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                <?php else: ?>
                    <p>Aucun historique de morts.</p>
                <?php endif; ?>
            </div>

            <div class="stats-card">
                <h3>Historique des kills</h3>
                <?php if (!empty($stats['kills'])): ?>
                    <ul>
                        <?php foreach ($stats['kills'] as $kill): ?>
                            <li>
                                <strong>Monstre :</strong> <?= htmlspecialchars($kill['monster_id']) ?> - 
                                <strong>Nombre de kills :</strong> <?= htmlspecialchars($kill['kill_count']) ?>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                <?php else: ?>
                    <p>Aucun historique de kills.</p>
                <?php endif; ?>
            </div>

            <div class="stats-card">
                <h3>Sessions de jeu</h3>
                <?php if (!empty($stats['sessions'])): ?>
                    <ul>
                        <?php foreach ($stats['sessions'] as $key => $session): ?>
                            <?php if ($key === 'total') continue; // Ignorer le total ?>
                            <li>
                                <strong>Début :</strong> <?= htmlspecialchars($session['session_start']) ?> - 
                                <strong>Fin :</strong> <?= htmlspecialchars($session['session_end']) ?>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                <?php else: ?>
                    <p>Aucune session enregistrée.</p>
                <?php endif; ?>
            </div>

        <?php else: ?>
            <p>Aucune statistique disponible pour cet utilisateur.</p>
        <?php endif; ?>
    </div>

</main>