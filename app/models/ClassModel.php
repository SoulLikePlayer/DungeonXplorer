<?php

class ClassModel extends Model {

    public function getAllClasses() {
        $db = $this->getDatabaseConnection();
        $query = 'SELECT * FROM Class';
        $stmt = $db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getClassStats($className) {
        $db = $this->getDatabaseConnection();
        $query = 'SELECT * FROM Class WHERE name = :className';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':className', $className);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}

