<?php

class User extends Model {

    // Ajouter un utilisateur à la base de données
    public function createAccount($username, $password, $email, $firstName, $lastName) {
        $db = $this->getDatabaseConnection();
    
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
    
        $query = 'INSERT INTO Account (username, password, email, first_name, last_name) 
                  VALUES (:username, :password, :email, :first_name, :last_name)';
        $stmt = $db->prepare($query);
    
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':first_name', $firstName);
        $stmt->bindParam(':last_name', $lastName);
    
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
    
    public function getUserByUsernameOrEmail($usernameOrEmail) {
        $db = $this->getDatabaseConnection();
    
        $query = 'SELECT * FROM Account WHERE username = :usernameOrEmail OR email = :usernameOrEmail';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':usernameOrEmail', $usernameOrEmail);
        $stmt->execute();
    
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
    

    public function getHeroByUserId($userId) {
        $db = $this->getDatabaseConnection();
        $query = 'SELECT hero_id 
                  FROM Account_Hero 
                  WHERE account_id = :userId';
        
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        
        $heroIds = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if (empty($heroIds)) {
            return null; 
        }
    
        $heroModel = new Hero();
        $heroes = [];
        
        foreach ($heroIds as $heroId) {
            $heroes[] = $heroModel->getHeroById($heroId['hero_id']);
        }
    
        $_SESSION['user']['allHero'] = $heroes;
        
        return $heroes[0]; 
    }

    public function getAllHeroByUserId($userId) {
        $db = $this->getDatabaseConnection();
        
        $query = 'SELECT * FROM Hero 
                  WHERE id IN (SELECT hero_id FROM Account_Hero WHERE account_id = :userId)';
        
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
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

    public function getUserDetails($userId) {
        $db = $this->getDatabaseConnection();
        
        $details = [];
    
        $query = 'SELECT total_deaths, max_chapter FROM PlayerStats WHERE player_id = :userId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        $details['stats'] = $stmt->fetch(PDO::FETCH_ASSOC);
    
        $query = 'SELECT chapter_id, death_count FROM PlayerDeaths WHERE player_id = :userId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        $details['deaths'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        $query = 'SELECT monster_id, kill_count FROM PlayerKills WHERE player_id = :userId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        $details['kills'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        $query = 'SELECT session_start, session_end FROM PlayerSessions WHERE player_id = :userId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        $details['sessions'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $query = 'SELECT SUM(TIMESTAMPDIFF(SECOND, session_start, session_end)) AS total_time_spent 
                    FROM PlayerSessions WHERE player_id = :userId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        $details['sessions']['total'] = $stmt->fetch(PDO::FETCH_ASSOC)['total_time_spent'];    
    
        return $details;
    }
    
    public function startSession($playerId) {
        $db = $this->getDatabaseConnection();

        $verifQuery = 'SELECT * FROM PlayerSessions WHERE player_id = :player_id AND session_end IS NULL';
        $verifStmt = $db->prepare($verifQuery);
        $verifStmt->bindParam(':player_id', $playerId);
        $verifStmt->execute();

        $existing = $verifStmt->fetch(PDO::FETCH_ASSOC);

        if ($existing){
            return $existing['id'];
        }
    
        $insertQuery = 'INSERT INTO PlayerSessions (player_id, session_start) VALUES (:player_id, NOW())';
        $insertStmt = $db->prepare($insertQuery);
        $insertStmt->bindParam(':player_id', $playerId, PDO::PARAM_INT);
        $insertStmt->execute();
        
        return $db->lastInsertId();
    }
    
    
    public function endSession($sessionId) {
        $db = $this->getDatabaseConnection();
    
        $query = 'UPDATE PlayerSessions SET session_end = NOW() WHERE id = :session_id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':session_id', $sessionId, PDO::PARAM_INT);
        return $stmt->execute();
    }
}
