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
        WHERE Inventory.hero_id = :hero_id AND Inventory.isDeleted = FALSE)';
        $inventoryConsStmt = $db->prepare($inventoryConsQuery);
        $inventoryConsStmt->bindParam(':hero_id', $_SESSION['user']['id']);
        $inventoryConsStmt->execute();

        return $inventoryConsStmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function addItemToInventory($heroId, $itemId, $quantity) {
        $db = $this->getDatabaseConnection();
        
        $queryCheck = 'SELECT id, quantity FROM Inventory WHERE hero_id = :hero_id AND item_id = :item_id AND isDeleted = FALSE';
        $stmtCheck = $db->prepare($queryCheck);
        $stmtCheck->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
        $stmtCheck->bindParam(':item_id', $itemId, PDO::PARAM_INT);
        $stmtCheck->execute();
        
        $existingItem = $stmtCheck->fetch(PDO::FETCH_ASSOC);

        if ($existingItem) {
            $queryUpdate = 'UPDATE Inventory SET quantity = quantity + :quantity WHERE id = :id';
            $stmtUpdate = $db->prepare($queryUpdate);
            $stmtUpdate->bindParam(':quantity', $quantity, PDO::PARAM_INT);
            $stmtUpdate->bindParam(':id', $existingItem['id'], PDO::PARAM_INT);
            $stmtUpdate->execute();
        } else {
            $queryInsert = 'INSERT INTO Inventory (hero_id, item_id, quantity) VALUES (:hero_id, :item_id, :quantity)';
            $stmtInsert = $db->prepare($queryInsert);
            $stmtInsert->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
            $stmtInsert->bindParam(':item_id', $itemId, PDO::PARAM_INT);
            $stmtInsert->bindParam(':quantity', $quantity, PDO::PARAM_INT);
            $stmtInsert->execute();
        }
    }

    public function removeItemFromInventory($heroId, $itemId, $quantity) {
        $db = $this->getDatabaseConnection();

        $queryCheck = 'SELECT id, quantity, isDeleted FROM Inventory WHERE hero_id = :hero_id AND item_id = :item_id';
        $stmtCheck = $db->prepare($queryCheck);
        $stmtCheck->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
        $stmtCheck->bindParam(':item_id', $itemId, PDO::PARAM_INT);
        $stmtCheck->execute();

        $existingItem = $stmtCheck->fetch(PDO::FETCH_ASSOC);

        if ($existingItem && !$existingItem['isDeleted']) {
            if ($existingItem['quantity'] > $quantity) {
                $queryUpdate = 'UPDATE Inventory SET quantity = quantity - :quantity WHERE id = :id';
                $stmtUpdate = $db->prepare($queryUpdate);
                $stmtUpdate->bindParam(':quantity', $quantity, PDO::PARAM_INT);
                $stmtUpdate->bindParam(':id', $existingItem['id'], PDO::PARAM_INT);
                $stmtUpdate->execute();
            } else {
                $queryDelete = 'DELETE FROM Inventory WHERE id = :id';
                $stmtDelete = $db->prepare($queryDelete);
                $stmtDelete->bindParam(':id', $existingItem['id'], PDO::PARAM_INT);
                $stmtDelete->execute();
            }
        }
    }
}
