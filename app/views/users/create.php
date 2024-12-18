<h2 id='title-creation' class="form-title">Créer un compte</h2>

<?php if (isset($error)): ?>
    <div class="profil-message error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="profil-message success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <div class="profil-container form-creation-container">
        <p><small>* Champs obligatoires</small></p> 
        <form action="/DungeonXplorer/user/store" method="POST" class="form-creation">
            <div class="form-row">
                <div class="form-group half-width">
                    <label for="firstname" class="form-label">Prénom</label>
                    <input type="text" name="firstname" id="firstname" class="form-input">
                </div>
                <div class="form-group half-width">
                    <label for="lastname" class="form-label">Nom</label>
                    <input type="text" name="lastname" id="lastname" class="form-input">
                </div>
            </div>

            <div class="form-group">
                <label for="username" class="form-label">Nom d'utilisateur *</label>
                <input type="text" name="username" id="username" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="password" class="form-label">Mot de passe *</label>
                <input type="password" name="password" id="password" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="email" class="form-label">Email *</label>
                <input type="email" name="email" id="email" class="form-input" required>
            </div>
            <div class="form-group">
                <button type="submit" class="hero-select-button">Créer le compte</button>
            </div>
        </form>
    </div>
</main>
