<?php

require_once './app/config/config.php';

class HomeController
{
    public function index()
    {
        $pdo = getDatabaseConnection();

        if ($pdo){
            echo "connexion";
        } else {
            echo "non connexion";
        }

        require 'app/views/pages/home.php';
    }
}

