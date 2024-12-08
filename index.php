<?php
ob_start();
session_start();
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DungeonXplorer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Pirata One' rel='stylesheet'>
    <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/StyleGeneraux.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/Combat.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/NPC.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/exploration.css">
    <link rel="stylesheet" href="../../../../DungeonXplorer/public/assets/css/merchant.css">
    <link rel="icon" href="../../../../DungeonXplorer/public/assets/image/favicon.ico" type="image/x-icon">
</head>
<body>
    <?php
        require_once 'app/views/layout/header.php';

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

        $router = new Router('DungeonXplorer');

        /*Route de la page principal*/
        $router->addRoute('', 'HomeController@index');

        /*Route lié au compte*/
        $router->addRoute('user/create', 'UserController@create');
        $router->addRoute('user/store', 'UserController@store');
        $router->addRoute('user/login', 'UserController@login');
        $router->addRoute('user/handleLogin', 'UserController@handleLogin');
        $router->addRoute('user/logout', 'UserController@logout');
        $router->addRoute('user/profile', 'UserController@profile');
        $router->addRoute('user/edit/{id}', 'UserController@edit');         // Route pour éditer un utilisateur
        $router->addRoute('user/update/{id}', 'UserController@update');     // Route pour mettre à jour un utilisateur
        $router->addRoute('user/delete', 'UserController@delete');     // Route pour supprimer un utilisateur

        /*Route lié pour l'histoire*/ 
        $router->addRoute('chapter/view/{chapterId}', 'ChapterController@viewChapter'); 
        $router->addRoute('chapter/reset', 'ChapterController@resetChapter');


        /* Route lié à l'inventaire */
        $router->addRoute('inventory/loadInventory','InventoryController@loadInventory');
        $router->addRoute('inventory/saveLoot', 'InventoryController@saveLoot');
        $router->addRoute('inventory/update', "InventoryController@updateConsumables");


        /*Route lié au hero*/
        $router->addRoute('hero/store', 'HeroController@store');
        $router->addRoute('hero/create', 'HeroController@create');
        $router->addRoute('hero/update', 'HeroController@updateStats');

        /* Route Admin*/
        $router->addRoute('admin/pannel', 'UserController@pannelAdmin');
        $router->addRoute('admin/delete/{id}', 'UserController@deleteUserAdmin');
        $router->addRoute('admin/details/{id}', 'UserController@details_user_admin');
        
        /*Route */
        $router->addRoute('about', 'AboutController@index');


        // Traiter la route demandée
        $router->route(trim($_SERVER['REQUEST_URI'], '/'));

        
        
        require_once 'app/views/layout/footer.php';
    ?>
</body>
</html>
