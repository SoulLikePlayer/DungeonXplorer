<?php

class talentModel extends Model{
    public function getAllTalent(){
        $db  = $this->getDatabaseConnection();

        $query = 'SELECT t.*, tr.race_id FROM Talent_Race tr JOIN Talent t ON tr.talent_id = t.id';

        $stmt = $db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getTalentByRaceId($raceId) {
        $db = $this->getDatabaseConnection();
    
        $query = 'SELECT t.*, tr.race_id FROM Talent_Race tr JOIN Talent t ON tr.talent_id = t.id WHERE tr.race_id = :race_id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':race_id', $raceId, PDO::PARAM_INT);
        $stmt->execute();
    
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getRandomTalentForRace($raceId) {
        $talents = $this->getTalentByRaceId($raceId);

        if(rand(1, 2) === 1){
            if (!empty($talents)) {
                return $talents[array_rand($talents)];
            }
        }
        
        return null; 
    }
    
}