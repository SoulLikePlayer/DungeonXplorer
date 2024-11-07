<main>
    <div class="story-container">
        <h2>Chapitre <?= htmlspecialchars($chapter['id']) ?></h2>
        <div class="chapter-content">
            <p><?= nl2br(htmlspecialchars($chapter['content'])) ?></p> 
        </div>

        <?php if ($chapter['image']): ?>
            <div class="chapter-image">
                <img src="<?= htmlspecialchars($chapter['image']) ?>" alt="Image du chapitre" class="img-fluid">
            </div>
        <?php endif; ?>

        <div class="navigation">
            <a href="/DungeonXplorer">Retour à l'accueil</a> 
        </div>
    </div>
</main>
