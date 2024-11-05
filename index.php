<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DungeonXplorer</title>
    <link rel="stylesheet" href="/public/assets/css/style.css">
</head>
<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require 'app/autoload.php';


require 'app/core/Router.php';
require 'app/controllers/HomeController.php';
/*require 'controllers/AdventureController.php';*/

// Instanciation du routeur
$router = new Router('DungeonXplorer');

// Ajout des routes
$router->addRoute('', 'HomeController@index');            // Page d'accueil
$router->addRoute('user/create', 'UserController@create');
$router->addRoute('user/store', 'UserController@store');

// Appel de la méthode route
$router->route(trim($_SERVER['REQUEST_URI'], '/'));
?>
</html>