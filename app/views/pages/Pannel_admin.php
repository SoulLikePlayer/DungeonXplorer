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
            <button>Supprimer</button>
            <button>Details</button>
        <?php endforeach;?>
    </ul>
</main>