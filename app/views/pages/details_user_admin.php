<h1>Informations détaillées</h1>
<main class="container-admin">
        <div class="container-detail-admin">
            <h2> Informations Utilisateur </h2>
            <p> <?=htmlspecialchars($_SESSION['admin']['userSelect']['username']) ?> : <?=htmlspecialchars($_SESSION['admin']['userSelect']['email']) ?></p> 
        </div>
        <div class ="container-detail-admin">
            <h2>Informations sur les héros</h2>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Prénom</th>
                        <th>Nom</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($_SESSION['admin']['userHeros'])) : ?>
                        <?php foreach ($_SESSION['admin']['userHeros'] as $index => $hero) : ?>
                            <tr>
                                <td><?= $index + 1 ?></td>
                                <td><?= htmlspecialchars($hero['firstname']) ?></td>
                                <td><?= htmlspecialchars($hero['lastname']) ?></td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else : ?>
                        <tr>
                            <td colspan="3">Aucun héros trouvé.</td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div> 
        <div class="container-detail-admin">
            <h2> Statistiques de l'utilisateur </h2>

            <?php if (isset($_SESSION['admin']['userStat'])): ?>
                <?php $stats = $_SESSION['admin']['userStat']; ?>

                <div class="stats-card">
                    <h3>Statistiques générales</h3>
                    <ul>
                        <li><strong>Temps total passé en jeu :</strong> <?= isset($stats['sessions']['total']) ? gmdate("H:i:s", $stats['sessions']['total']) : 'Non disponible' ?></li>
                    </ul>
                </div>

                <div class="stats-card">
                    <h3>Sessions de jeu</h3>
                    <?php if (!empty($stats['sessions'])): ?>
                        <ul>
                            <?php foreach ($stats['sessions'] as $key => $session): ?>
                                <?php if ($key === 'total') continue; // Ignorer le total ?>
                                <li>
                                    <strong>Début :</strong> <?= htmlspecialchars($session['session_start']) ?> - 
                                    <strong>Fin :</strong> <?= $session['session_end'] !== null ? htmlspecialchars($session['session_end']) : "En Cours" ?>
                                </li>
                            <?php endforeach; ?>
                        </ul>
                    <?php else: ?>
                        <p>Aucune session enregistrée.</p>
                    <?php endif; ?>
                </div>

            <?php else: ?>
                <p>Aucune statistique disponible pour cet utilisateur.</p>
            <?php endif; ?>
        </div>
</main>