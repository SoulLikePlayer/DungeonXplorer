<h2>Connexion</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <form action="/DungeonXplorer/user/handleLogin" method="POST">
        <div>
            <label for="username">Nom d'utilisateur</label>
            <input type="text" name="username" id="username" required>
        </div>
        <div>
            <label for="password">Mot de passe</label>
            <input type="password" name="password" id="password" required>
        </div>
        <div>
            <button type="submit">Se connecter</button>
        </div>
    </form>
</main>

<p>Pas encore de compte ? <a href="/DungeonXplorer/user/create">Créer un compte</a></p>
