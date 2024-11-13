<?php

class Hero extends Model {

    // Ajouter un personnage à la base de données
    public function createHero($lastname, $firstname, $class, $bio) {
        $db = $this->getDatabaseConnection();

        // Requête SQL pour insérer un nouveau personnage
        $query = 'INSERT INTO Hero (username, password, email) VALUES (:username, :password, :email)';
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

    // Récupérer un utilisateur par son ID
    public function getUserById($id) {
        $db = $this->getDatabaseConnection();

        $query = 'SELECT * FROM Account WHERE id = :id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Mettre à jour les informations d'un utilisateur
    public function updateUser($id, $username, $email) {
        $db = $this->getDatabaseConnection();

        $query = 'UPDATE Account SET username = :username, email = :email WHERE id = :id';
        $stmt = $db->prepare($query);

        // Liaison des paramètres et exécution
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':id', $id);

        return $stmt->execute();
    }

    // Supprimer un utilisateur par ID
    public function deleteUser($id) {
        $db = $this->getDatabaseConnection();

        $query = 'DELETE FROM Account WHERE id = :id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id);

        return $stmt->execute();
    }
}
