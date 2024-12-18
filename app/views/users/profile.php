<h2>Profil de l'utilisateur</h2>

<?php if (isset($error)): ?>
    <div class="profil-message error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="profil-message success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<div class="profil-container">
    <div class="profil-header">
        <h3>Profil de <?= htmlspecialchars($_SESSION['user']['first_name'] . ' ' . $_SESSION['user']['last_name']) ?></h3>
    </div>

    <div class="profil-info">
        <p>Nom d'utilisateur : <?= htmlspecialchars($_SESSION['user']['username']) ?></p>
        <p>Email : <?= htmlspecialchars($_SESSION['user']['email']) ?></p>
    </div>

    <div class="profil-select-hero">
    <h4>Choisissez votre héros actuel :</h4>
    <?php if (!empty($heroes)): ?>
        <form action="/DungeonXplorer/user/selectHero" method="POST">
            <div class="hero-select-container">
                <label for="hero_id" class="hero-select-label">Sélectionnez un héros :</label>
                    <div class="hero-dropdown">
                        <select name="hero_id" id="hero_id" class="hero-select">
                            <?php foreach ($heroes as $hero): ?>
                                <option value="<?= $hero['hero_id'] ?>" <?= ($hero['hero_id'] == $_SESSION['user']['hero']['hero_id']) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($hero['hero_firstname'] . ' ' . $hero['hero_lastname']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
                <button type="submit" class="hero-select-button">Sélectionner ce héros</button>
            </form>
        <?php else: ?>
            <p>Vous n'avez pas de héros associé à votre compte.</p>
        <?php endif; ?>
    </div>


    <div class="profil-buttons">
        <a href="/DungeonXplorer/user/edit">
            <button>Modifier le profil</button>
        </a>

        <form class="profil-delete" action="/DungeonXplorer/user/delete" method="POST">
            <button type="submit" onclick="return confirm('Êtes-vous sûr de vouloir supprimer votre compte ?')">Supprimer le compte</button>
        </form>
    </div>
</div>
