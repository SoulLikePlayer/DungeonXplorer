<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require 'app/core/Router.php';
require 'app/controllers/HomeController.php';
require 'app/controllers/AdventureController.php';

// Instanciation du routeur
$router = new Router('LivreHero');

// Ajout des routes
$router->addRoute('', 'HomeController@index');            // Page d'accueil
$router->addRoute('adventures', 'AdventureController@index'); // Liste des aventures
$router->addRoute('adventures/view', 'AdventureController@view'); // Vue d'une aventure spécifique
$router->addRoute('adventures/create', 'AdventureController@create'); // Création d'une aventure

// Appel de la méthode route
$router->route(trim($_SERVER['REQUEST_URI'], '/'));

