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

