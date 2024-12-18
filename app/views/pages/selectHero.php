<h2>Sélectionnez votre héros</h2>

<?php if (!empty($heroes)) : ?>
    <form action="/DungeonXplorer/user/setSelectedHero" method="POST">
        <ul>
            <?php foreach ($heroes as $hero) : ?>
                <li>
                    <input type="radio" name="hero_id" value="<?= $hero['id'] ?>" required>
                    <?= htmlspecialchars($hero['firstname'] . ' ' . $hero['lastname']) ?> 
                </li>
            <?php endforeach; ?>
        </ul>
        <button type="submit">Valider</button>
    </form>
<?php else : ?>
    <p>Aucun héros disponible.</p>
<?php endif; ?>
