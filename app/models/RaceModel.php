<?php

class RaceModel extends Model{
    public function getAllRace(){
        $db = $this->getDatabaseConnection();
        $query = 'SELECT * FROM Race';
        $stmt = $db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getRaceName($raceName){
        $db = $this->getDatabaseConnection();
        $query = 'SELECT * FROM Race WHERE name= :raceName';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':raceName', $raceName);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}