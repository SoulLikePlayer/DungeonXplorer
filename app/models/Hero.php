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
    COALESCE(primary_weapon_weapon.damage_bonus, 0) AS primary_weapon_damage_bonus,
    COALESCE(primary_weapon_weapon.defense_bonus, 0) AS primary_weapon_defense_bonus,
    secondary_weapon.name AS secondary_weapon_name,
    COALESCE(secondary_weapon_weapon.damage_bonus, 0) AS secondary_weapon_damage_bonus,
    COALESCE(secondary_weapon_weapon.defense_bonus, 0) AS secondary_weapon_defense_bonus,
    
    -- Calcul des totaux
    (COALESCE(primary_weapon_weapon.damage_bonus, 0) + COALESCE(secondary_weapon_weapon.damage_bonus, 0)) AS total_damage_bonus,
    (COALESCE(primary_weapon_weapon.defense_bonus, 0) + COALESCE(secondary_weapon_weapon.defense_bonus, 0) 
    + COALESCE(helmet_armor.defense, 0) + COALESCE(body_armor.defense, 0) + COALESCE(greaves_armor.defense, 0)) AS total_defense_bonus,

    ha.helmet_id,
    ha.armor_id,
    ha.greaves_id,
    helmet.name AS helmet_name,
    armor.name AS armor_name,
    greaves.name AS greaves_name,
    
    -- Calcul des PV et mana maximum
    c.base_pv AS pv_max,
    c.base_mana AS mana_max

FROM 
    Hero h
LEFT JOIN 
    Hero_Weapons hw ON h.id = hw.hero_id
LEFT JOIN 
    Items primary_weapon ON hw.primary_weapon_id = primary_weapon.id
LEFT JOIN 
    Weapon primary_weapon_weapon ON primary_weapon.id = primary_weapon_weapon.item_id
LEFT JOIN 
    Items secondary_weapon ON hw.secondary_weapon_id = secondary_weapon.id
LEFT JOIN 
    Weapon secondary_weapon_weapon ON secondary_weapon.id = secondary_weapon_weapon.item_id
LEFT JOIN 
    Hero_Armor ha ON h.id = ha.hero_id
LEFT JOIN 
    Items helmet ON ha.helmet_id = helmet.id
LEFT JOIN 
    Armor helmet_armor ON helmet.id = helmet_armor.item_id
LEFT JOIN 
    Items armor ON ha.armor_id = armor.id
LEFT JOIN 
    Armor body_armor ON armor.id = body_armor.item_id
LEFT JOIN 
    Items greaves ON ha.greaves_id = greaves.id
LEFT JOIN 
    Armor greaves_armor ON greaves.id = greaves_armor.item_id
LEFT JOIN 
    Class c ON h.class_id = c.id -- Ajout de la table des classes pour récupérer les valeurs de base

WHERE 
    h.id = :userId;


        ';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function updateHeroStats($heroId, $pv, $mana, $xp, $level) {
        $db = $this->getDatabaseConnection();
        $query = 'UPDATE Hero 
                  SET pv = :pv, mana = :mana, xp = :xp, current_level = :level 
                  WHERE id = :heroId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':heroId', $heroId);
        $stmt->bindParam(':pv', $pv);
        $stmt->bindParam(':mana', $mana);
        $stmt->bindParam(':xp', $xp);
        $stmt->bindParam(':level', $level);
        return $stmt->execute();
    }
    
}
