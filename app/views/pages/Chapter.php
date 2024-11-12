<?php
    $_SESSION["Chapitre"] = $chapter['id']
?>
<main>
    <div class="story-container">
        <h2 id="ChapterTitle">Chapitre <?= htmlspecialchars($chapter['id'] ?? 'Inconnu') ?></h2>
        <div class="chapter-content">
            <p><?= nl2br(htmlspecialchars($chapter['content'] ?? 'Aucun contenu disponible')) ?></p> 
        </div>

        <?php if ($chapter['image']): ?>
            <div class="chapter-image">
                <img src="<?= htmlspecialchars($chapter['image']) ?>" alt="Image du chapitre" class="img-fluid">
            </div>
        <?php endif; ?>

        <div class="links">
            <?php foreach ($links as $link): ?>
                <div class="link">
                    <a href="/DungeonXplorer/chapter/view/<?= htmlspecialchars($link['next_chapter_id'] ?? '#') ?>">
                        <button><?= nl2br(htmlspecialchars($link['description'] ?? 'Pas de description')) ?></button>
                    </a>
                </div>
            <?php endforeach; ?>
        </div>

        <div class="navigation">
            <a href="/DungeonXplorer">Retour à l'accueil</a> 
        </div>
    </div>
</main>
