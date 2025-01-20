<?php

class ClassModel extends Model {

    public function getAllInitialClasses() {
        $db = $this->getDatabaseConnection();
        $query = 'SELECT * FROM Class
                  WHERE id IN (SELECT class_id 
                               FROM Master_Class)';
        $stmt = $db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getAllSubclassesById($classId){
        $db = $this->getDatabaseConnection();
        $query = 'SELECT * FROM Class 
                  WHERE id IN (SELECT Class_ID
                               FROM Subclass
                               WHERE Parent_Class_ID = :classId)';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':classId', $classId);
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

