<?php

class Inventory extends Model {

    public function getInventory($username, $password, $email) {
        $db = $this->getDatabaseConnection();

        $query = 'SELECT id FROM Items';
        /*'INSERT INTO Account (username, password, email) VALUES (:username, :password, :email)';*/
        $stmt = $db->prepare($query);

        // Liaison des paramètres et exécution
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->bindParam(':email', $email);

        return $stmt->execute();
    }



}
