<?php

class Treasure extends Model {

    // Récupère les informations d'un trésor par son ID
    public function getTreasureById($treasureId) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare("
            SELECT 
                ct.id AS treasure_id,
                ct.item_id,
                ct.condition,
                ct.quantity,
                i.name AS item_name,
                i.description AS item_description,
                i.item_type,
                i.gold_value,
                i.imageName
            FROM Chapter_Treasure ct
            JOIN Items i ON ct.item_id = i.id
            WHERE ct.id = :treasureId
        ");
        $stmt->bindParam(':treasureId', $treasureId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Récupère tous les trésors
    public function getAllTreasures() {
        $db = $this->getDatabaseConnection();

        $stmt = $db->query("
            SELECT 
                ct.id AS treasure_id,
                ct.item_id,
                ct.condition,
                i.name AS item_name,
                i.description AS item_description,
                i.unite_inv,
                i.poids,
                i.item_type,
                i.gold_value,
                i.imageName
            FROM Chapter_Treasure ct
            JOIN Items i ON ct.item_id = i.id
            ORDER BY ct.id ASC
        ");

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Vérifie si un trésor existe déjà par son ID
    public function treasureExists($treasureId) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare('SELECT id FROM Chapter_Treasure WHERE id = :treasureId');
        $stmt->bindParam(':treasureId', $treasureId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Récupère les trésors en fonction d'une condition spécifique
    public function getTreasuresByCondition($condition) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare("\n            SELECT 
                ct.id AS treasure_id,
                ct.item_id,
                ct.condition,
                i.name AS item_name,
                i.description AS item_description,
                i.unite_inv,
                i.poids,
                i.item_type,
                i.gold_value,
                i.imageName
            FROM Chapter_Treasure ct
            JOIN Items i ON ct.item_id = i.id
            WHERE ct.condition = :condition
        ");
        $stmt->bindParam(':condition', $condition, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}

?>
