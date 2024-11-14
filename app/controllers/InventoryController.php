<?php
class InventoryController extends Controller {
    public function loadInventory(){
         // Récupérer l'inventaire du héros depuis la base de données 
         $inventoryModel = new Inventory(); 
         $inventory = $inventoryModel->getInventory($_SESSION['user']['username'], $_SESSION['user']['password'], $_SESSION['user']['email']); 
         // Si l'inventaire est vide ou qu'il n'y a pas d'objets, on définit un message 
         if (empty($inventory)) { 
            $inventory = 'Inventaire vide'; 
        } // Stocker l'inventaire dans la session 
         $_SESSION['user']['inventory'] = $inventory; // Rediriger l'utilisateur vers la page d'accueil 
         header("Location: /home"); 
         exit;
    }
}

