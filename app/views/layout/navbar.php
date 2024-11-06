<!-- app/views/layout/navbar.php -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="/DungeonXplorer">DungeonXplorer</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/DungeonXplorer">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/DungeonXplorer/adventure">Aventures</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/DungeonXplorer/about">À propos</a>
                </li>

                <?php if (isset($_SESSION['user'])): ?>
                    <!-- Si l'utilisateur est connecté -->
                    <li class="nav-item">
                        <a class="nav-link" href="/DungeonXplorer/user/profile"><?= htmlspecialchars($_SESSION['user']['username']) ?></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/DungeonXplorer/user/logout">Se déconnecter</a>
                    </li>
                <?php else: ?>
                    <!-- Si l'utilisateur n'est pas connecté -->
                    <li class="nav-item">
                        <a class="nav-link" href="/DungeonXplorer/user/login">Se connecter</a>
                    </li>
                <?php endif; ?>
            </ul>
        </div>
    </div>
</nav>

