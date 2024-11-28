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

    public function getHeroByUserId($userId) {
        $heroModel = new Hero();       
        return $heroModel->getHeroByUserId($userId);
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

    public function deleteUser($id) {
        $db = $this->getDatabaseConnection();
    
        // Désactivation des contraintes de clés étrangères pour éviter les erreurs lors de la suppression
        $db->exec("SET foreign_key_checks = 0");
    
        try {
            // Supprimer les données liées au héros dans Hero_Armor, Hero_Weapons, et Inventory
            $query = 'DELETE FROM Inventory WHERE hero_id = (SELECT id FROM Hero WHERE id = :heroId)';
            $stmt = $db->prepare($query);
            $stmt->bindParam(':heroId', $id);
            $stmt->execute();
    
            $query = 'DELETE FROM Hero_Weapons WHERE hero_id = :heroId';
            $stmt = $db->prepare($query);
            $stmt->bindParam(':heroId', $id);
            $stmt->execute();
    
            $query = 'DELETE FROM Hero_Armor WHERE hero_id = :heroId';
            $stmt = $db->prepare($query);
            $stmt->bindParam(':heroId', $id);
            $stmt->execute();
    
            // Supprimer le héros lui-même
            $query = 'DELETE FROM Hero WHERE id = :heroId';
            $stmt = $db->prepare($query);
            $stmt->bindParam(':heroId', $id);
            $stmt->execute();
    
            // Supprimer l'utilisateur dans la table Account
            $query = 'DELETE FROM Account WHERE id = :id';
            $stmt = $db->prepare($query);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
    
            // Commit des changements
            $db->commit();
    
            // Réactiver les contraintes de clés étrangères
            $db->exec("SET foreign_key_checks = 1");
    
            return true;
        } catch (Exception $e) {   
            $db->exec("SET foreign_key_checks = 1");
            error_log($e->getMessage());
            return false;
        }
    } 
    
    public function getAllUser(){
        $db = $this->getDatabaseConnection();    
        
        $query = 'SELECT * FROM Account WHERE is_admin = 0';
        $stmt = $db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
