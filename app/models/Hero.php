<?php

class Hero extends Model {

    public function createHero($lastname, $firstname, $classId, $raceId, $biography, $pv, $mana, $strength, $initiative) {
        $db = $this->getDatabaseConnection();
        $idt = $_SESSION['user']['id'];
        $query = 'INSERT INTO Hero (id, lastname, firstname, class_id, race_id, biography, pv_max, mana_max, strength, initiative)
                  VALUES (:idt, :lastname, :firstname, :classId, :raceId, :biography, :pv_max, :mana_max, :strength, :initiative)';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':idt', $idt);
        $stmt->bindParam(':lastname', $lastname);
        $stmt->bindParam(':firstname', $firstname);
        $stmt->bindParam(':classId', $classId);
        $stmt->bindParam(':raceId', $raceId);
        $stmt->bindParam(':biography', $biography);
        $stmt->bindParam(':pv_max', $pv);
        $stmt->bindParam(':mana_max', $mana);
        $stmt->bindParam(':strength', $strength);
        $stmt->bindParam(':initiative', $initiative);
        return $stmt->execute();
    }

    public function deleteHero($id){
        $db = $this->getDatabaseConnection();
        $query = 'DELETE FROM Hero WHERE id = :heroId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':heroId', $id);
        return $stmt->execute();
    }

    public function createHeroStory($heroId, $pvMax, $manaMax) {
        $db = $this->getDatabaseConnection();
        $query = 'INSERT INTO Hero_Story (hero_id, pv, mana, chapter) VALUES (:hero_id, :pv_max, :mana_max, :chapter)';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':hero_id', $heroId);
        $chap = 1;
        $stmt->bindParam(':chapter', $chap);
        $stmt->bindParam(':pv_max', $pvMax);
        $stmt->bindParam(':mana_max', $manaMax);
        return $stmt->execute();
    }

    public function updateHeroStoryChapter($heroId, $chapter) {
        $db = $this->getDatabaseConnection();
        $query = 'UPDATE Hero_Story SET chapter = :chapter WHERE hero_id = :hero_id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':hero_id', $heroId);
        $stmt->bindParam(':chapter', $chapter);
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
            h.biography,
            h.class_id,
            c.name AS class_name,
            h.race_id,
            r.name AS race_name,
            h.pv_max,
            h.mana_max,
            h.strength,
            h.initiative,
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
            (COALESCE(primary_weapon_weapon.damage_bonus, 0) + COALESCE(secondary_weapon_weapon.damage_bonus, 0)) AS total_damage_bonus,
            (COALESCE(primary_weapon_weapon.defense_bonus, 0) + COALESCE(secondary_weapon_weapon.defense_bonus, 0) 
            + COALESCE(helmet_armor.defense, 0) + COALESCE(body_armor.defense, 0) + COALESCE(greaves_armor.defense, 0) + COALESCE(gloves_armor.defense, 0)) AS total_defense_bonus,
            ha.helmet_id,
            ha.armor_id,
            ha.greaves_id,
            ha.gloves_id,
            helmet.name AS helmet_name,
            armor.name AS armor_name,
            greaves.name AS greaves_name,
            gloves.name AS gloves_name,
            hs.pv AS current_pv,
            hs.mana AS current_mana,
            h.gold
        FROM 
            Hero h
        LEFT JOIN
            Class c ON c.id = h.class_id
        LEFT JOIN
            Race r ON r.id = h.race_id
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
        	Items gloves ON ha.gloves_id = gloves.id
        LEFT JOIN 
            Armor gloves_armor ON gloves.id = gloves_armor.item_id
        LEFT JOIN 
            Hero_Story hs ON h.id = hs.hero_id
        WHERE
            h.id = :userId;';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function updateHeroStats($heroId, $pv, $mana, $xp) {
        $db = $this->getDatabaseConnection();
        $query = 'UPDATE Hero_Story 
                  SET pv = :pv, mana = :mana 
                  WHERE hero_id = :heroId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':heroId', $heroId);
        $stmt->bindParam(':pv', $pv);
        $stmt->bindParam(':mana', $mana);
        $result = $stmt->execute();

        $queryXp = 'UPDATE Hero
                    SET xp = xp + :xp
                    WHERE id = :heroId';
        
        $stmtXp = $db->prepare($queryXp);
        $stmtXp->bindParam(":xp", $xp);
        $stmtXp->bindParam(":heroId", $heroId);

        $result2 = $stmtXp->execute();
        return $result && $result2;
    }

    public function updateHeroStatsAndLevel($heroId, $pvMax, $manaMax, $strength, $initiative, $xp, $newLevel) {
        $db = $this->getDatabaseConnection();
    
        $query = 'UPDATE Hero_Story 
                  SET pv = :pv, mana = :mana 
                  WHERE hero_id = :heroId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':heroId', $heroId);
        $stmt->bindParam(':pv', $pvMax);
        $stmt->bindParam(':mana', $manaMax);
        $result1 = $stmt->execute();
    
        $query2 = 'UPDATE Hero
                   SET xp = :xp, current_level = :current_level
                   WHERE id = :heroId';
        $stmt2 = $db->prepare($query2);
        $stmt2->bindParam(":xp", $xp);
        $stmt2->bindParam(":current_level", $newLevel);
        $stmt2->bindParam(":heroId", $heroId);
        $result2 = $stmt2->execute();
    
        $query3 = 'UPDATE Hero
                   SET pv_max = :pv_max, mana_max = :mana_max, strength = :strength, initiative = :initiative
                   WHERE id = :heroId';
        $stmt3 = $db->prepare($query3);
        $stmt3->bindParam(":pv_max", $pvMax);
        $stmt3->bindParam(":mana_max", $manaMax);
        $stmt3->bindParam(":strength", $strength);
        $stmt3->bindParam(":initiative", $initiative);
        $stmt3->bindParam(":heroId", $heroId);
        $result3 = $stmt3->execute();
    
        return $result1 && $result2 && $result3;
    }

    public function updateHeroGold($heroId, $gold) {
        $db = $this->getDatabaseConnection();
        $query = 'UPDATE Hero SET gold = :gold WHERE id = :heroId';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':gold', $gold, PDO::PARAM_INT);
        $stmt->bindParam(':heroId', $heroId, PDO::PARAM_INT);
        return $stmt->execute();
    }
    
    

    public function getChapterByHeroId($heroId) {
        $db = $this->getDatabaseConnection();
        $stmt = $db->prepare("SELECT * FROM Hero_Story WHERE hero_id = :hero_id");
        $stmt->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>
