<?php
class InventoryController extends Controller {
    public function loadInventory() {
        $inventoryModel = new Inventory(); 
        $inventory = $inventoryModel->getInventory(); 
        $inventoryCons = $inventoryModel->getInventoryConsumable(); 

        if (!empty($inventory)) { 
            $_SESSION['user']['inventory'] = $inventory;
            $_SESSION['user']['inventoryCons'] = $inventoryCons;
            $inventoryModel->getInventoryCodex();
        }

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

    public function updateConsumables() {
        $data = json_decode(file_get_contents('php://input'), true);
        
        $heroId = $_SESSION['user']['id'];
        $inventory = new Inventory();
        $inventory->updateConsumableQuantities($heroId, $data);

        $_SESSION['user']['inventoryCons'] = $inventory->getInventoryConsumable();

    }
}

