<?php

class InventoryController extends Controller {

    public function test(){
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        $email = $_POST['email'] ?? '';

        $test = new Inventory();
        $test->getInventory($username, $password, $email);
        echo($test);
    }

}
