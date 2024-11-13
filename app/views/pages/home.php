<main>
    <div class="container">
        <div class="container-items">
            <?php if (isset($_SESSION['user']['hero_id'])): ?>
                <?php var_dump($_SESSION['user']['hero_id']) ?>
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
            <!-- Conteneur supplémentaire pour autres informations -->
        </div>
    </div>    
</main>

