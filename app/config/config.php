<?php

function getDatabaseConnection(){
    $envFile = __DIR__ . '/.env';

    if (!file_exists($envFile)) {
        die("Le fichier .env n'existe pas.");
    }

    $env = parse_ini_file($envFile);

    $dbHost = $env['DB_HOST'];
    $dbName = $env['DB_NAME'];
    $dbUser = $env['DB_USER'];
    $dbPassword = $env['DB_PASSWORD'];
    try {
        $db = new PDO("mysql:host=$dbHost;dbname=$dbName;charset=utf8", $dbUser, $dbPassword);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $db;
    } catch (PDOException $e) {
        echo "Erreur de connexion à la base de données : " . $e->getMessage();
        exit;
    }
}