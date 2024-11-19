<?php
    $_SESSION["Chapitre"] = $chapter['id']
?>
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
                <div class="combat-container">
                    <h3>Préparez-vous au combat !</h3>
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
</main>
