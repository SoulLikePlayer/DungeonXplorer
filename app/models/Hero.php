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

    public function getHeroByUserId($userId) {
        $db = $this->getDatabaseConnection();
        $query = '
        SELECT 
        h.id AS hero_id,
        h.lastname AS hero_lastname,
        h.firstname AS hero_firstname,
        h.class_id,
        h.pv,
        h.mana,
        h.strength,
        h.initiative,
        h.armor,
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
        h.id = :userId;
        ';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
