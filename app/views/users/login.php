<h2 id='title-creation'>Connexion</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <div class='form-creation'>
        <form action="/DungeonXplorer/user/handleLogin" method="POST">
        <div class="row">
                <div class='col-25'>
                    <label for="username">Nom d'utilisateur ou Email</label>
                </div>
                <div class="col-75">
                    <input type="text" name="username" id="username" required>
                </div>
            </div>
            <div class="row">
                <div class='col-25'>
                    <label for="password">Mot de passe</label>
                </div>
                <div class="col-75">
                    <input type="password" name="password" id="password" required>
                </div>
            </div>
            <div>
                <button type="submit">Se connecter</button>
            </div>
        </form>
    </div>
</main>

<p id='missing-account'>Pas encore de compte ? <a href="/DungeonXplorer/user/create">Créer un compte</a></p>
