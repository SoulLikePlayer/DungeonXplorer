<h2>Créer un personnage</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <form action="/DungeonXplorer/hero/store" method="POST">
        <div>
            <label for="lastname">Nom du personnage</label>
            <input type="text" name="lastname" id="lastname" required>
        </div>
        <div>
            <label for="firstname">Prénom du personnage</label>
            <input type="text" name="firstname" id="firstname" required>
        </div>
        <div>
            <label for="class">Classe du personnage</label>
            <select name="class" id="class" required>
                <?php foreach ($classes as $class): ?>
                    <option value="<?= htmlspecialchars($class['name']) ?>"><?= htmlspecialchars($class['name']) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div>
            <label for="bio">Biographie/Histoire du personnage</label>
            <input type="text" name="bio" id="bio">
        </div>
        <div>
            <button type="submit">Créer le personnage</button>
        </div>
    </form>
</main>

