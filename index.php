<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DungeonXplorer</title>
    <link rel="stylesheet" href="public/assets/css/style.css">
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

        $router = new Router('DungeonXplorer');

        $router->addRoute('', 'HomeController@index');

        $router->route(trim($_SERVER['REQUEST_URI'], '/'));
        
        require_once 'app/views/layout/footer.php';
    ?>
</body>
</html>