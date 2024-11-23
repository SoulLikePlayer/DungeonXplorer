<?php
class Inventory extends Model {
    public function getInventory() {
        $db = $this->getDatabaseConnection();

        $inventoryQuery = '
            SELECT *
            FROM Inventory
            JOIN Items ON Inventory.item_id = Items.id
            WHERE Inventory.hero_id = :hero_id
        ';
        $inventoryStmt = $db->prepare($inventoryQuery);
        $inventoryStmt->bindParam(':hero_id', $_SESSION['user']['id']);
        $inventoryStmt->execute();

        return $inventoryStmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getInventoryConsumable() {
        $db = $this->getDatabaseConnection();

        $inventoryConsQuery = '
        SELECT i.name, i.description, c.effect_type, c.heal_amount, c.mana_amount, c.attack_buff, c.defense_buff, c.duration
        FROM Consumable c JOIN Items i ON c.item_id = i.id
        WHERE c.item_id IN
        (SELECT item_id
        FROM Inventory
        JOIN Items ON Inventory.item_id = Items.id
        WHERE Inventory.hero_id = :hero_id)';
        $inventoryConsStmt = $db->prepare($inventoryConsQuery);
        $inventoryConsStmt->bindParam(':hero_id', $_SESSION['user']['id']);
        $inventoryConsStmt->execute();

        return $inventoryConsStmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function addItemToInventory($heroId, $itemId, $quantity) {
        $db = $this->getDatabaseConnection();
        
        $queryInsert = 'INSERT INTO Inventory (hero_id, item_id) VALUES (:hero_id, :item_id)';
        $stmtInsert = $db->prepare($queryInsert);
    
        for ($i = 0; $i < $quantity; $i++) {
            $stmtInsert->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
            $stmtInsert->bindParam(':item_id', $itemId, PDO::PARAM_INT); 
            $stmtInsert->execute();
        }
    }
    
    
    
}

