<?php
ob_start();
session_start();
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="DungeonXplorer : Explorez des donjons, combattez des monstres et créez votre propre héros dans un monde épique. Rejoignez l'aventure dès maintenant !">
    <meta name="keywords" content="DungeonXplorer, jeu de rôle, donjons, aventure, exploration, héros, RPG, combat, créateur de héros">
    <meta name="robots" content="index, follow">

    <!-- Open Graph (OG) pour les réseaux sociaux -->
    <meta property="og:title" content="DungeonXplorer - Explorez, Combattez, et Créez Votre Héros">
    <meta property="og:description" content="DungeonXplorer : Explorez des donjons, combattez des monstres et créez votre propre héros dans un monde épique. Rejoignez l'aventure dès maintenant !">
    <meta property="og:image" content="URL_DE_L_IMAGE_LIEN_IMAGE">
    <meta property="og:url" content="https://dev-lazare231.users.info.unicaen.fr/DungeonXplorer/">

    <link rel="canonical" href="https://dev-lazare231.users.info.unicaen.fr/DungeonXplorer/">

    <title>DungeonXplorer - Explorez, Combattez, et Créez Votre Héros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Pirata One' rel='stylesheet'>
    <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
    
    <!-- fichiers CSS -->
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/Style.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/Combat.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/NPC.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/exploration.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/merchant.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/admin.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/Profil.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/CreateHero.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/treasure.css">

    <link rel="icon" href="../../../../DungeonXplorer/public/assets/image/Logo.png" type="image/x-icon">
</head>
<body>
        <?php require_once 'app/views/layout/header.php'; ?>

        <?php
            ini_set('display_errors', 1);
            ini_set('display_startup_errors', 1);
            error_reporting(E_ALL);

            require 'app/autoload.php';

            require 'app/core/Router.php';
            require 'app/controllers/HomeController.php';
            require 'app/controllers/UserController.php';
            require 'app/controllers/ChapterController.php';
            require 'app/controllers/InventoryController.php';
            require 'app/controllers/HeroController.php';
            require 'app/controllers/AboutController.php';
            require 'app/controllers/MonsterController.php';

            $router = Router::getInstance('DungeonXplorer');

            /* Route de la page principale */
            $router->addRoute('', 'HomeController@index');

            /* Routes liées au compte utilisateur */
            $router->addRoute('user/create', 'UserController@create');
            $router->addRoute('user/store', 'UserController@store');
            $router->addRoute('user/login', 'UserController@login');
            $router->addRoute('user/handleLogin', 'UserController@handleLogin');
            $router->addRoute('user/logout', 'UserController@logout');
            $router->addRoute('user/profile', 'UserController@profile');
            $router->addRoute('user/edit', 'UserController@edit');
            $router->addRoute('user/update/{id}', 'UserController@update');
            $router->addRoute('user/delete', 'UserController@delete');
            $router->addRoute('user/selectHero','UserController@selectHero');
            $router->addRoute('user/deleteHero', 'UserController@deleteHero');

            if (isset($_SESSION['user'])){             

                /* Routes liées à l'inventaire */
                $router->addRoute('inventory/loadInventory','InventoryController@loadInventory');
                $router->addRoute('inventory/saveLoot', 'InventoryController@saveLoot');
                $router->addRoute('inventory/update', "InventoryController@updateConsumables");
                $router->addRoute('inventory/sellLoot', "InventoryController@sellLoot");
                $router->addRoute('inventory/getUpdateInventory', 'InventoryController@getUpdatedInventory');

                /* Routes liées au héros */
                $router->addRoute('hero/store', 'HeroController@store');
                $router->addRoute('hero/create', 'HeroController@create');
                $router->addRoute('hero/update', 'HeroController@updateStats');
                $router->addRoute('hero/updateGold', 'heroController@updateGold');
                $router->addRoute('hero/reset', 'HeroController@reset');
                $router->addRoute('hero/updateWeaponSet','HeroController@equipWeapon');
                $router->addRoute('hero/updateArmorSet', 'HeroController@equipArmor');

                if (isset($_SESSION['user']['hero'])){
                    /* Routes liées à l'histoire */
                    $router->addRoute('chapter/view/{chapterId}', 'ChapterController@viewChapter', true); 
                    $router->addRoute('chapter/reset', 'ChapterController@resetChapter');

                    if($_SESSION['user']['hero']['talent_id'] === 23){
                        $router->addRoute('chapter/previewFuture/{id}', 'ChapterController@previewFuture');
                    }
                }

                if ($_SESSION['user']['is_admin']===1){
                    /* Routes Admin */
                    $router->addRoute('admin/pannel', 'UserController@pannelAdmin');
                    $router->addRoute('admin/delete/{id}', 'UserController@deleteUserAdmin');
                    $router->addRoute('admin/details/{id}', 'UserController@details_user_admin');

                    $router->addRoute('chapter/getChapter/{chapterId}', 'ChapterController@getChapter');
                    $router->addRoute('chapter/updateChapter', 'ChapterController@updateChapter');
                    $router->addRoute('admin/chapterList', 'UserController@chaptersListAdmin');

                    $router->addRoute('admin/monsterList', 'UserController@monstersListAdmin');
                    
                    /* Routes liées aux monstres */
                    $router->addRoute('monster/getMonster/{monsterId}', 'MonsterController@getMonster');
                    $router->addRoute('monster/updateMonster', 'MonsterController@updateMonster');
                }
            }

            $router->addRoute('about', 'AboutController@index');

            $router->route(trim($_SERVER['REQUEST_URI'], '/'));
        ?>
        <?php require_once 'app/views/layout/footer.php'; ?>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" defer></script>
</body>
</html>
