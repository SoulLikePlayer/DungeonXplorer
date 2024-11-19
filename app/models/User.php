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
        $db = $this->getDatabaseConnection();
        $query = 'SELECT 
        h.id AS hero_id,
        h.lastname AS hero_lastname,
        h.firstname AS hero_firstname,
        h.class_id,
        h.pv,
        h.mana,
        h.strength,
        h.initiative,
        h.armor,
        h.spell_list,
        h.xp,
        h.current_level,
        h.poids_max,
        h.nb_items_max,
        hw.primary_weapon_id,
        hw.secondary_weapon_id,
        primary_weapon.name AS primary_weapon_name,
        secondary_weapon.name AS secondary_weapon_name,
        ha.helmet_id,
        ha.armor_id,
        ha.greaves_id,
        helmet.name AS helmet_name,
        armor.name AS armor_name,
        greaves.name AS greaves_name
        FROM 
            Hero h
        LEFT JOIN 
            Hero_Weapons hw ON h.id = hw.hero_id
        LEFT JOIN 
            Items primary_weapon ON hw.primary_weapon_id = primary_weapon.id
        LEFT JOIN 
            Items secondary_weapon ON hw.secondary_weapon_id = secondary_weapon.id
        LEFT JOIN 
            Hero_Armor ha ON h.id = ha.hero_id
        LEFT JOIN 
            Items helmet ON ha.helmet_id = helmet.id
        LEFT JOIN 
            Items armor ON ha.armor_id = armor.id
        LEFT JOIN 
            Items greaves ON ha.greaves_id = greaves.id
        WHERE 
        h.id = :userId;';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
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
