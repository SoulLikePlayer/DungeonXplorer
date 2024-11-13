<?php

class InventoryController extends Controller {

    public function test(){
        $this->view('users/inventory');

        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        $email = $_POST['email'] ?? '';

        $test = new Inventory();
        $test->getInventory($username, $password, $email);
        $_SESSION['inventaire'] = $test;

        $this->view('users/inventorytest');
    }

}
?>