<h2 id='title-creation'>Créer un personnage</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <div class='form-creation'>
        <form action="/DungeonXplorer/hero/store" method="POST">
            <div class="row">
                <div class='col-25'>
                    <label for="lastname">Nom du personnage</label>
                </div>
                <div class="col-75">
                    <input type="text" name="lastname" id="lastname" required>
                </div>
            </div>
            <div class="row">
                <div class='col-25'>
                <label for="firstname">Prénom du personnage</label>
                </div>
                <div class="col-75">
                <input type="text" name="firstname" id="firstname" required>
                </div>
            </div>
            <div class="row">
                <div class='col-25'>
                <label for="class">Classe du personnage</label>
                </div>
                <div class="col-75">
                <select name="class" id="class" required>
                    <?php foreach ($classes as $class): ?>
                        <option value="<?= htmlspecialchars($class['name']) ?>"><?= htmlspecialchars($class['name']) ?></option>
                    <?php endforeach; ?>
                </select>
                </div>
            </div>
            <div class="row">
                <div class='col-25'>
                <label for="bio">Biographie/Histoire du personnage</label>
                </div>
                <div class="col-75">
                <textarea id="bio" name="bio" placeholder="Write something.."></textarea>
                </div>
            </div>
            <div>
                <button type="submit">Créer le personnage</button>
            </div>
        </form>
    </div>
</main>

