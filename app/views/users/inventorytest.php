<main>
    <h2>Inventaire</h2>
    <?php if (!empty($_SESSION['inventaire'])): ?>
        <ul>
            <?php foreach ($_SESSION['inventaire'] as $item): ?>
                <li>
                    <strong>Nom :</strong> <?= htmlspecialchars($item['name']) ?><br>
                    <strong>Description :</strong> <?= htmlspecialchars($item['description']) ?>
                </li>
            <?php endforeach; ?>
        </ul>
    <?php else: ?>
        <p>Aucun item trouvé dans l'inventaire.</p>
    <?php endif; ?>
</main>

