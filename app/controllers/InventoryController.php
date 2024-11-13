<?php
class InventoryController extends Controller {
    public function test(){
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        $email = $_POST['email'] ?? '';

        $test = new Inventory();
        $inventory = $test->getInventory($username, $password, $email);

        // Stocker l'inventaire récupéré en session
        $_SESSION['inventaire'] = $inventory;

        $this->view('users/inventorytest');
    }
}

