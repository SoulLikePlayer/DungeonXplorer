<h2>Profil de l'utilisateur</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<p>Nom d'utilisateur : <?= htmlspecialchars($_SESSION['user']['username']) ?></p>
<p>Email : <?= htmlspecialchars($_SESSION['user']['email']) ?></p>

<a href="/DungeonXplorer/user/edit">
    <button>Modifier le profil</button>
</a>

<form action="/DungeonXplorer/user/delete" method="POST">
    <button type="submit" onclick="return confirm('Êtes-vous sûr de vouloir supprimer votre compte ?')">Supprimer le compte</button>
</form>
