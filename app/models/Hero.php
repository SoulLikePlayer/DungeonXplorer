<?php

class Hero extends Model {

    public function createHero($lastname, $firstname, $classId, $biography, $pv, $mana, $strength, $initiative) {
        $db = $this->getDatabaseConnection();
        $idt = $_SESSION['user']['id'];
        $query = 'INSERT INTO Hero (id, lastname, firstname, class_id, biography, pv, mana, strength, initiative)
                  VALUES (:idt, :lastname, :firstname, :classId, :biography, :pv, :mana, :strength, :initiative)';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':idt', $idt);
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':classId', $classId);
        $stmt->bindParam(':biography', $biography);
        $stmt->bindParam(':pv', $pv);
        $stmt->bindParam(':mana', $mana);
        $stmt->bindParam(':strength', $strength);
        $stmt->bindParam(':initiative', $initiative);
        return $stmt->execute();
    }

    public function heroExists() {
        $db = $this->getDatabaseConnection();
        $idt = $_SESSION['user']['id'];
        $query = 'SELECT id FROM Hero WHERE id = :idt';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':idt', $idt);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getHeroIdByUserId($userId) {
        $db = $this->getDatabaseConnection();
        $query = 'SELECT hero_id FROM Account WHERE id = :userId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        return $stmt->fetchColumn();
    }

    public function getHeroByUserId($userId) {
        $db = $this->getDatabaseConnection();
        $query = 'SELECT h.*, c.name AS classe_name FROM Hero h LEFT JOIN Class c ON h.class_id = c.id WHERE h.id = :userId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}

