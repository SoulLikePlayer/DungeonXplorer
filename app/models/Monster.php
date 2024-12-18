<?php

class Monster extends Model {

    // Récupère les informations d'un monstre par son ID
    public function getMonsterById($monsterId) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare("
            SELECT 
                m.id,
                m.name,
                m.pv,
                m.mana,
                m.initiative,
                m.strength,
                m.xp,
                m.mana
            FROM Monster m
            WHERE m.id = :monsterId
        ");
        $stmt->bindParam(':monsterId', $monsterId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Récupère tous les monstres
    public function getAllMonsters() {
        $db = $this->getDatabaseConnection();

        $stmt = $db->query("
            SELECT 
                m.id,
                m.name,
                m.pv,
                m.mana,
                m.initiative,
                m.strength,
                m.xp
            FROM Monster m
            ORDER BY m.id ASC
        ");

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    // obtenir les loots des monstre selon l'id

    public function getLootById($id){
        $db = $this->getDatabaseConnection();

        $query = 'SELECT l.item_id as id, i.name AS name, l.quantity AS quantity, l.probability AS proba
                  FROM Monster m 
                  JOIN Loot l ON m.id = l.id_monster
                  JOIN Items i ON l.item_id = i.id
                  WHERE m.id = :monster_id
                ';
        
        $stmt = $db->prepare($query);

        $stmt->bindParam(':monster_id', $id);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Vérifie si un monstre existe déjà par son nom
    public function monsterExists($name) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare('SELECT id FROM Monster WHERE name = :name');
        $stmt->bindParam(':name', $name);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getAttacksByMonsterId($monsterId) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare('
            SELECT 
                ma.id,
                ma.name,
                ma.effect,
                ma.effect_function,
                ma.mana_cost,
                ma.is_physical
            FROM Monster_Attack ma
            WHERE ma.monster_id = :monsterId
        ');
        $stmt->bindParam(':monsterId', $monsterId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
