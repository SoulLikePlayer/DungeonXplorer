<?php
class HomeController
{
    public function index()
    {
        if (isset($_SESSION['user']['hero'])){
            /*Gestion de héro*/
            $heroModel = new Hero();
            $_SESSION['user']['hero'] = $heroModel->getHeroByUserId($_SESSION['user']['id']);

            /*Gestion de l'inventaire */
            $inventoryModel = new Inventory(); 
            $_SESSION['user']['inventory'] = $inventoryModel->getInventory($_SESSION['user']['username'], $_SESSION['user']['password'], $_SESSION['user']['email']); 
            $_SESSION['user']['inventoryCons'] = $inventoryModel->getInventoryConsumable($_SESSION['user']['username'], $_SESSION['user']['password'], $_SESSION['user']['email']);
            $inventoryModel->getInventoryCodex(); 
        }
        require 'app/views/pages/home.php';
    }
}

