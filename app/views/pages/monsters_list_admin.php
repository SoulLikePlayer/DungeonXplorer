<main>
    <div class="monsters-list">
        <?php foreach ($monsters as $monster): ?>
            <button class="monster-button" data-monster-id="<?= htmlspecialchars($monster['id']) ?>">
                <?= htmlspecialchars($monster['name']) ?>
            </button>
        <?php endforeach; ?>
    </div>

    <div id="monster-content" class="modal">
        <div class="modal-content">
            <h3 id="monster-name"></h3>
            <div id="monster-stats"></div>
            <div id="monster-loots"></div>
            <div id="monster-attacks"></div>
            
            <button id="edit-monster">Modifier</button>

            <div id="edit-section" style="display: none;">
                <h4>Modifier le Monstre</h4>
                <label for="edit-name">Nom:</label>
                <textarea id="edit-name"></textarea>
                <label for="edit-stats">Stats (JSON):</label>
                <textarea id="edit-stats"></textarea>
                <label for="edit-xp">XP:</label>
                <input id="edit-xp" type="number">
                <button id="save-changes">Valider</button>
            </div>

            <button id="close-modal">Fermer</button>
        </div>
    </div>
</main>

<script src="../../../../DungeonXplorer/public/assets/js/MonsterListSystem.js"></script>
