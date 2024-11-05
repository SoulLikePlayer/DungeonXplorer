<?php

class User extends Model {

    // Ajouter un utilisateur à la base de données
    public function createAccount($username, $password, $email) {
        $db = $this->getDatabaseConnection();

        // Hashage du mot de passe avant de le stocker
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // Requête SQL pour insérer un nouvel utilisateur
        $query = 'INSERT INTO Account (username, password, email) VALUES (:username, :password, :email)';
        $stmt = $db->prepare($query);

        // Liaison des paramètres et exécution
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->bindParam(':email', $email);

        return $stmt->execute();
    }

    // Vérifier si l'utilisateur existe déjà par son nom d'utilisateur ou email
    public function userExists($username, $email) {
        $db = $this->getDatabaseConnection();

        $query = 'SELECT id FROM Account WHERE username = :username OR email = :email';
        $stmt = $db->prepare($query);

        // Liaison des paramètres et exécution
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':email', $email);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Récupérer un utilisateur par son nom d'utilisateur
    public function getUserByUsername($username) {
        $db = $this->getDatabaseConnection();

        $query = 'SELECT * FROM Account WHERE username = :username';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':username', $username);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
