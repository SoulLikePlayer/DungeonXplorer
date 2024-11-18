<?php
class InventoryController extends Controller {
    public function loadInventory(){
         // Récupérer l'inventaire du héros depuis la base de données 
         $inventoryModel = new Inventory(); 
         $inventory = $inventoryModel->getInventory($_SESSION['user']['username'], $_SESSION['user']['password'], $_SESSION['user']['email']); 
         if (!empty($inventory)) { 
            $_SESSION['user']['inventory'] = $inventory;; 
        } // Stocker l'inventaire dans la session 
         header("Location: /DungeonXplorer"); 
         exit;
    }
}

