<h2>Modifier le profil</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<main>
    <form action="/DungeonXplorer/user/update/<?= $user['id'] ?>" method="POST">
        <div>
            <label for="username">Nom d'utilisateur</label>
            <input type="text" name="username" id="username" value="<?= htmlspecialchars($user['username']) ?>" required>
        </div>
        <div>
            <label for="email">Email</label>
            <input type="email" name="email" id="email" value="<?= htmlspecialchars($user['email']) ?>" required>
        </div>
        <div>
            <button type="submit">Mettre à jour</button>
        </div>
    </form>
</main>
