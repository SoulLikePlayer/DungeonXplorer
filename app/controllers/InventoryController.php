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

    public function saveLoot() {
        $data = json_decode(file_get_contents('php://input'), true);
    
        if (isset($data['itemId']) && isset($data['quantity']) && isset($_SESSION['user']['id'])) {
            $heroId = $_SESSION['user']['id'];
            $itemId = $data['itemId'];
            $quantity = $data['quantity'];
    
            $inventoryModel = new Inventory();
            $inventoryModel->addItemToInventory($heroId, $itemId, $quantity);
    
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Données invalides']);
        }
    }
    
    
}

