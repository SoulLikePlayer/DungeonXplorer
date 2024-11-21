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
                m.attack,
                m.xp
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
                m.attack,
                m.xp
            FROM Monster m
            ORDER BY m.id ASC
        ");

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    // obtenir les loots des monstre selon l'id

    public function getLootById($id){
        $db = $this->getDatabaseConnection();

        $query = 'SELECT i.name AS name, l.quantity AS quantity, l.probability AS proba
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

    // Crée un nouveau monstre dans la base de données
    public function createMonster($name, $pv, $mana, $initiative, $strength, $attack, $xp) {
        $db = $this->getDatabaseConnection();

        $query = 'INSERT INTO Monster (name, pv, mana, initiative, strength, attack, xp)
                  VALUES (:name, :pv, :mana, :initiative, :strength, :attack, :xp)';
        $stmt = $db->prepare($query);

        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':pv', $pv);
        $stmt->bindParam(':mana', $mana);
        $stmt->bindParam(':initiative', $initiative);
        $stmt->bindParam(':strength', $strength);
        $stmt->bindParam(':attack', $attack);
        $stmt->bindParam(':xp', $xp);

        return $stmt->execute();
    }

    // Vérifie si un monstre existe déjà par son nom
    public function monsterExists($name) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare('SELECT id FROM Monster WHERE name = :name');
        $stmt->bindParam(':name', $name);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>
