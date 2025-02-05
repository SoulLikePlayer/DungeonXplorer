<h2>Pannel Admin</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <ul>
        <?php foreach ($_SESSION['admin']['allUser'] as $key => $eachUser):?>
            <p> <?=htmlspecialchars($key+1) ?> <?=htmlspecialchars($eachUser['username']) ?> : <?=htmlspecialchars($eachUser['email']) ?></p> 
            <a href="/DungeonXplorer/admin/delete/<?= htmlspecialchars($eachUser['id'] ?? '#') ?>">
                <button>Supprimer</button>
            </a>
            <a href="/DungeonXplorer/admin/details/<?= htmlspecialchars($eachUser['id'] ?? '#') ?>">
            <button>Details</button>
            </a>
        <?php endforeach;?>
    </ul>
</main>