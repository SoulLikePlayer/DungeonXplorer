<?php

class Hero extends Model {

    // Ajouter un personnage à la base de données
    public function createHero($lastname, $firstname, $class, $bio) {
        $db = $this->getDatabaseConnection();
        
        // Requête SQL pour insérer un nouveau personnage
        $idt = $_SESSION['user']['id'];
        $query = 'INSERT INTO Hero (id, lastname, firstname, class_id, biography) VALUES (:idt, :lastname, :firstname, (select class_id from Class where name = :class), :bio)';
        $stmt = $db->prepare($query);

        // Liaison des paramètres et exécution
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':class', $class);

        return $stmt->execute();
    }

    // Vérifier si un personnage existe déjà
    public function heroExists() {
        $db = $this->getDatabaseConnection();
        
        $idt = $_SESSION['user']['id'];
        $query = 'SELECT id FROM Hero WHERE id = :idt';
        $stmt = $db->prepare($query);

        // Liaison des paramètres et exécution
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':class', $class);
        
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Récupérer un personnage
    public function getHero($id) {
        $db = $this->getDatabaseConnection();

        $query = 'SELECT * FROM Hero WHERE id = :id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Supprimer un utilisateur par ID
    public function deleteUser($id) {
        $db = $this->getDatabaseConnection();

        $query = 'DELETE FROM Hero WHERE id = :id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id);

        return $stmt->execute();
    }
}
