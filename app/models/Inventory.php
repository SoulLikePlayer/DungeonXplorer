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
        SELECT c.item_id, i.name, i.description, inv.quantity, c.effect_type, c.heal_amount, c.mana_amount, c.attack_buff, c.defense_buff, c.duration
        FROM Consumable c JOIN Items i ON c.item_id = i.id JOIN Inventory inv ON inv.item_id = i.id
        WHERE c.item_id IN
        (SELECT item_id
        FROM Inventory
        JOIN Items ON Inventory.item_id = Items.id
        WHERE Inventory.hero_id = :hero_id)';
        $inventoryConsStmt = $db->prepare($inventoryConsQuery);
        $inventoryConsStmt->bindParam(':hero_id', $_SESSION['user']['hero']['hero_id']);
        $inventoryConsStmt->execute();

        return $inventoryConsStmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getInventoryCodex(){
        $db = $this->getDatabaseConnection();

        $inventoryCodexQuery = '
        SELECT c.item_id, i.name, inv.quantity
        FROM Codex c JOIN Items i ON c.item_id = i.id JOIN Inventory inv ON inv.item_id = i.id
        WHERE c.item_id IN
        (SELECT item_id
        FROM Inventory
        JOIN Items ON Inventory.item_id = Items.id
        WHERE Inventory.hero_id = :hero_id)';

        $inventoryCodexStmt = $db->prepare($inventoryCodexQuery);
        $inventoryCodexStmt->bindParam(':hero_id', $_SESSION['user']['hero']['hero_id']);
        $inventoryCodexStmt->execute();

        $resultCodex = $inventoryCodexStmt->fetchAll(PDO::FETCH_ASSOC);

        $_SESSION['user']['hero']['Codex'] = [];
        foreach($resultCodex as $codex){
            $spellQuery = "SELECT s.id, s.codex_id, s.name, s.mana_cost, s.level_required, s.effect_function
            FROM Spell s JOIN Codex c ON s.codex_id = c.item_id JOIN Items i ON c.item_id = i.id
            WHERE i.name = :codex_name;";

            $spellStmt = $db->prepare($spellQuery);
            $spellStmt->bindParam(':codex_name', $codex['name']);
            $spellStmt->execute();

            $spells = $spellStmt->fetchAll(PDO::FETCH_ASSOC);

            $codex['spell'] = $spells;
            $_SESSION['user']['hero']['Codex'][$codex['name']] = $codex;

        }
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

    public function updateConsumableQuantities($heroId, $consumables) {
        $db = $this->getDatabaseConnection();

        foreach ($consumables as $item) {
            if ($item['quantity'] > 0) {
                $queryUpdate = 'UPDATE Inventory SET quantity = :quantity WHERE hero_id = :hero_id AND item_id = :item_id';
                $stmtUpdate = $db->prepare($queryUpdate);
                $stmtUpdate->bindParam(':quantity', $item['quantity'], PDO::PARAM_INT);
                $stmtUpdate->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
                $stmtUpdate->bindParam(':item_id', $item['item_id'], PDO::PARAM_INT);
                $stmtUpdate->execute();
            } else {
                $queryDelete = 'DELETE FROM Inventory WHERE hero_id = :hero_id AND item_id = :item_id';
                $stmtDelete = $db->prepare($queryDelete);
                $stmtDelete->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
                $stmtDelete->bindParam(':item_id', $item['item_id'], PDO::PARAM_INT);
                $stmtDelete->execute();
            }
        }
    }
}
