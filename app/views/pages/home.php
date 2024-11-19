<main>
    <div class="container">
    <div class="container-items">
         <?php if (isset($_SESSION['user']['hero'])): ?>
            <?php $hero = $_SESSION['user']['hero']; ?> 
            <h2>Personnage: <?= htmlspecialchars($hero['firstname']) . " " . htmlspecialchars($hero['lastname']) ?>
            </h2> <p><strong>Classe:</strong> <?= htmlspecialchars($hero['classe_name']) ?></p>
            <p><strong>Biographie:</strong> <?= htmlspecialchars($hero['biography']) ?>
            </p> <h3>Statistiques</h3> <ul>
                 <li><strong>Points de vie (PV):</strong> <?= htmlspecialchars($hero['pv']) ?></li> 
                 <li><strong>Mana:</strong> <?= htmlspecialchars($hero['mana']) ?></li>
                 <li><strong>Force:</strong> <?= htmlspecialchars($hero['strength']) ?></li>
                 <li><strong>Initiative:</strong> <?= htmlspecialchars($hero['initiative']) ?></li>
                 <li><strong>Armure:</strong> <?= $hero['armor'] ? htmlspecialchars($hero['armor']) : 'Aucune' ?></li>
            </ul>
            
            <h3>Équipement</h3> <ul> 
                <li><strong>Arme principale:</strong> <?= $hero['primary_weapon_id'] ? htmlspecialchars($hero['primary_weapon']) : 'Aucune' ?></li> 
                <li><strong>Arme secondaire:</strong> <?= $hero['secondary_weapon_id'] ? htmlspecialchars($hero['secondary_weapon']) : 'Aucune' ?></li> 
            </ul> 
            
            <h3>Autres détails</h3> <ul> 
                <li><strong>Niveau actuel:</strong> <?= htmlspecialchars($hero['current_level']) ?></li>
                 <li><strong>XP:</strong> <?= htmlspecialchars($hero['xp']) ?></li> 
                 <li><strong>Poids maximal:</strong> <?= htmlspecialchars($hero['poids_max']) ?> kg</li> 
                 <li><strong>Nombre d'objets max:</strong> <?= htmlspecialchars($hero['nb_items_max']) ?></li> 
            </ul> 
        <?php else: ?>
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
            <?php if (isset($_SESSION['user']['inventory'])): ?>
                <h2>Inventaire</h2>
                <?php foreach($_SESSION['user']['inventory'] as $item):?>
                    <p><?=htmlspecialchars($item['name']) ?> : </p><ul>
                        <li>Description : <?=htmlspecialchars($item['description']) ?></li>
                        <li>Poids : <?=htmlspecialchars($item['poids']) ?></li>
                        <li>Place dans l'inventaire: <?=htmlspecialchars($item['unite_inv']) ?></li>
                    </ul>
                <?php endforeach; ?>    
            <?php else: ?>
                <p>Inventaire vide.</p>
            <?php endif; ?> 
    </div>    
</main>

