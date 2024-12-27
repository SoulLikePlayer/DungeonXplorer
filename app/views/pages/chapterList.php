<main>
    <div class="chapters-list">
        <?php foreach ($chapters as $chapter): ?>
            <button class="chapter-button" data-chapter-id="<?= htmlspecialchars($chapter['id']) ?>">
                Chapitre <?= htmlspecialchars($chapter['id']) ?> : <?= htmlspecialchars($chapter['titre']) ?>
            </button>
        <?php endforeach; ?>
    </div>

    <div id="chapter-content" class="modal">
        <div class="modal-content">
            <h3 id="chapter-title"></h3>
            <div id="chapter-description"></div>
            <div id="chapter-events"></div>
            
            <button id="edit-chapter">Modifier</button>

            <div id="edit-section" style="display: none;">
                <h4>Modifier le Chapitre</h4>
                <label for="edit-title">Titre:</label>
                <textarea id="edit-title"></textarea>
                <label for="edit-content">Contenu:</label>
                <textarea id="edit-content"></textarea>
                <button id="save-changes">Valider</button>
            </div>

            <button id="close-modal">Fermer</button>
        </div>
    </div>
</main>

<script src="../../../../DungeonXplorer/public/assets/js/ChapterList.js"></script>
