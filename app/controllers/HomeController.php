<?php
class HomeController
{
    public function index()
    {
        if (isset($_SESSION['user']['hero'])){
            $heroModel = new Hero();
            $_SESSION['user']['hero'] = $heroModel->getHeroById($_SESSION['user']['hero']['hero_id']);

            /*Gestion de l'inventaire */
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

            /*Gestion du level supérieur*/
            $levelModel = new levelModel();
            $level = $levelModel -> getNextLevelById($_SESSION['user']['hero']['hero_id'], $_SESSION['user']['hero']['class_id']);
            if ($level){
                $_SESSION['user']['hero']['nextLevel'] = $level;
            }
        }
        require 'app/views/pages/home.php';
    }
}

