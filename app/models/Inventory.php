<?php
class Inventory extends Model {
    public function getInventory() {
        $db = $this->getDatabaseConnection();

        // Récupérer l'inventaire pour le hero_id
        $inventoryQuery = '
            SELECT Items.id, Items.name, Items.description, Items.poids, Items.unite_inv
            FROM Inventory
            JOIN Items ON Inventory.item_id = Items.id
            WHERE Inventory.hero_id = :hero_id
        ';
        $inventoryStmt = $db->prepare($inventoryQuery);
        $inventoryStmt->bindParam(':hero_id', $_SESSION['user']['id']);
        $inventoryStmt->execute();

        return $inventoryStmt->fetchAll(PDO::FETCH_ASSOC);
    }
}

