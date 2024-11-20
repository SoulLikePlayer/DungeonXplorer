<main>
    <div class="story-container">
        <?php if($chapter['chapter_type'] === 'death'): ?>
            <h2 id="ChapterTitleDeath"><?= htmlspecialchars($chapter['titre'] ?? 'Inconnu') ?></h2>
        <?php else: ?>
            <h2 id="ChapterTitle"><?= htmlspecialchars($chapter['titre'] ?? 'Inconnu') ?></h2>
        <?php endif; ?>

        <div class="chapter-content">
            <p><?= nl2br(htmlspecialchars($chapter['content'] ?? 'Aucun contenu disponible')) ?></p> 
        </div>

        <?php if ($chapter['image']): ?>
            <div class="chapter-image">
                <img src="<?= htmlspecialchars($chapter['image']) ?>" alt="Image du chapitre" class="img-fluid">
            </div>
        <?php endif; ?>

        <div class="links">
            <?php if ($chapter['chapter_type'] === 'combat'): ?>
                <div class="combat-container" id="combatContainer">
                    <h3 id="combatMessage">Un combat commence contre <?= htmlspecialchars($_SESSION['monster']['name']) ?></h3>
                    <button id="startCombatButton" 
                        data-hero-name="<?= htmlspecialchars($_SESSION['user']['hero']['hero_firstname'] . ' ' . $_SESSION['user']['hero']['hero_lastname']) ?>"
                        data-hero-pv="<?= htmlspecialchars($_SESSION['user']['hero']['pv']) ?>"
                        data-hero-strength="<?= htmlspecialchars($_SESSION['user']['hero']['strength']) ?>"
                        data-hero-initiative="<?= htmlspecialchars($_SESSION['user']['hero']['initiative']) ?>"
                        data-hero-is-thief="<?= htmlspecialchars($_SESSION['user']['hero']['class_id'] == 3 ? 'true' : 'false') ?>"
                        data-monster-name="<?= htmlspecialchars($_SESSION['monster']['name']) ?>"
                        data-monster-pv="<?= htmlspecialchars($_SESSION['monster']['pv']) ?>"
                        data-monster-strength="<?= htmlspecialchars($_SESSION['monster']['strength']) ?>"
                        data-monster-initiative="<?= htmlspecialchars($_SESSION['monster']['initiative']) ?>"
                        data-next-chapter-win="<?= htmlspecialchars($links[0]['next_chapter_id']) ?>"
                        data-next-chapter-lose="<?= htmlspecialchars($links[1]['next_chapter_id']) ?>">
                    Commencer le combat
                </button>
                <div class="combat-actions" id="combatActions" style="display: none;">
                    <div id="combatInfo">
                        <p><strong>Héros : </strong><span id="heroName"></span> | PV : <span id="heroPv"></span></p>
                        <p><strong>Monstre : </strong><span id="monsterName"></span> | PV : <span id="monsterPv"></span></p>
                    </div>
                    <div id="combatMessages" class="combat-messages"></div> <!-- Zone des messages de combat -->
                    <div class="combat-buttons">
                        <button id="attackButton">Attaquer</button>
                        <button id="useItemButton">Utiliser un objet</button>
                        <button id="runButton">Fuir</button>
                    </div>
                </div>
            <?php else: ?>
                <?php foreach ($links as $link): ?>
                    <div class="link">
                        <a href="/DungeonXplorer/chapter/view/<?= htmlspecialchars($link['next_chapter_id'] ?? '#') ?>">
                            <button><?= nl2br(htmlspecialchars($link['description'] ?? 'Pas de description')) ?></button>
                        </a>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>

        <div class="navigation">
            <a href="/DungeonXplorer">Retour à l'accueil</a> 
        </div>
    </div>
    <script src="../../public/assets/js/combat.js"></script>
</main>
