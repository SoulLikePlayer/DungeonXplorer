<?php
class InventoryController extends Controller {
    public function loadInventory() {
        $inventoryModel = new Inventory(); 
        $inventory = $inventoryModel->getInventory(); 
        $inventoryCons = $inventoryModel->getInventoryConsumable(); 
        $inventoryWeapon = $inventoryModel->getInventoryWeapons();
        $inventoryArmor = $inventoryModel->getInventoryArmors();
        $inventoryMis = $inventoryModel->getInventoryMiscellaneous();
        $inventoryCodex = $inventoryModel->getInventoryCodex();


        if (!empty($inventory)) { 
            $_SESSION['user']['inventory'] = $inventory;
            $_SESSION['user']['inventoryCons'] = $inventoryCons;
            $_SESSION['user']['inventoryWeapon'] = $inventoryWeapon;
            $_SESSION['user']['inventoryArmor'] = $inventoryArmor;
            $_SESSION['user']['inventoryMis'] = $inventoryMis;
            $_SESSION['user']['inventoryCodex'] = $inventoryCodex;
        }

        header("Location: /DungeonXplorer"); 
        exit;
    }

    public function sellLoot() {
        ob_clean();
        header('Content-Type: application/json');
        $data = json_decode(file_get_contents('php://input'), true);
    
        if (isset($data['itemId']) && isset($data['quantity']) && isset($_SESSION['user']['id'])) {
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $itemId = $data['itemId'];
            $quantity = $data['quantity'];
    
            $inventoryModel = new Inventory();
            $inventoryModel->removeItemFromInventory($heroId, $itemId, $quantity);

    
            $inventory = $inventoryModel->getInventory(); 
            $inventoryCons = $inventoryModel->getInventoryConsumable(); 
            $_SESSION['user']['inventory'] = $inventory;
            $_SESSION['user']['inventoryCons'] = $inventoryCons;
    
            echo json_encode(['success' => true]);
            exit;
        } else {
            echo json_encode(['success' => false, 'message' => 'Données invalides']);
            exit;
        }
    }
    

    public function saveLoot() {
        ob_clean();
        header('Content-Type: application/json');
        $data = json_decode(file_get_contents('php://input'), true);
    
        if (isset($data['itemId']) && isset($data['quantity']) && isset($_SESSION['user']['id'])) {
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $itemId = $data['itemId'];
            $quantity = $data['quantity'];
    
            $inventoryModel = new Inventory();
            $result = $inventoryModel->addItemToInventory($heroId, $itemId, $quantity);

            $inventory = $inventoryModel->getInventory(); 
            $inventoryCons = $inventoryModel->getInventoryConsumable(); 

            if (!empty($inventory)) { 
                $_SESSION['user']['inventory'] = $inventory;
                $_SESSION['user']['inventoryCons'] = $inventoryCons;
                $inventoryModel->getInventoryCodex();
            }
            
            ob_clean();
            if ($result){
                echo json_encode(['success' => true]);
            }else {
                echo json_encode(['success' => false]);
            }
            exit;
        } else {
            echo json_encode(['success' => false, 'message' => 'Données invalides']);
            exit;
        }
    }

    public function updateConsumables() {
        ob_clean();
        $data = json_decode(file_get_contents('php://input'), true);
        
        $heroId = $_SESSION['user']['hero']['hero_id'];
        $inventory = new Inventory();
        $inventory->updateConsumableQuantities($heroId, $data);

        $_SESSION['user']['inventoryCons'] = $inventory->getInventoryConsumable();
        $_SESSION['user']['inventory'] = $inventory->getInventory();

    }

    public function getUpdatedInventory() {
        header('Content-Type: application/json');
        ob_clean();
        if (isset($_SESSION['user'])) {
            $inventory = $_SESSION['user']['inventory'] ?? [];
            $inventoryCons = $_SESSION['user']['inventoryCons'] ?? [];

            echo json_encode([
                'inventory' => $inventory,
                'inventoryCons' => $inventoryCons
            ]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Utilisateur non connecté']);
        }

        exit;
    }

}

