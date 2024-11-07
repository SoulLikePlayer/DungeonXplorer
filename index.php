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

        /*Route lié pour l'histoire*/ 
        $router->addRoute('chapter/view/{chapterId}', 'ChapterController@viewChapter'); 


        $router->route(trim($_SERVER['REQUEST_URI'], '/'));
        
        require_once 'app/views/layout/footer.php';
    ?>

</html>