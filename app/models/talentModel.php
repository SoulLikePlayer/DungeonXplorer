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

    public function getNoTalent(){
        $db = $this->getDatabaseConnection();
    
        $query = 'SELECT t.* FROM Talent t WHERE t.id = 0';
        $stmt = $db->prepare($query);
        $stmt->execute();
    
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getCurse(){
        $db = $this->getDatabaseConnection();
    
        $query = "SELECT * FROM Talent WHERE type = 'curse'";
        $stmt = $db->prepare($query);
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

        $talents = $this->getCurse();
        if(rand(1, 2) === 1){
            return $talents[array_rand($talents)];
        }

        $talents = $this->getNoTalent();
        
        return $talents; 
    }

    public function evolveCurse($currentTalentId, $heroId) {
        $db = $this->getDatabaseConnection();
        
        $query = 'SELECT * FROM Talent WHERE id = :current_talent_id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':current_talent_id', $currentTalentId, PDO::PARAM_INT);
        $stmt->execute();
        $currentTalent = $stmt->fetch(PDO::FETCH_ASSOC);

        $query = 'SELECT * FROM Talent WHERE curse_id = :current_talent_id';
        $stmt = $db->prepare($query);
        $stmt->bindParam(':current_talent_id', $currentTalentId, PDO::PARAM_INT);
        $stmt->execute();
    
        $evolvedTalent = $stmt->fetch(PDO::FETCH_ASSOC);
    
        if ($evolvedTalent) {

            $updateQuery = 'UPDATE Hero SET talent_id = :new_talent_id WHERE id = :hero_id';
            $updateStmt = $db->prepare($updateQuery);
            $updateStmt->bindParam(':new_talent_id', $evolvedTalent['id'], PDO::PARAM_INT);
            $updateStmt->bindParam(':hero_id', $heroId, PDO::PARAM_INT);
            $updateStmt->execute();

            $_SESSION['user']['hero']['talent_id'] = $evolvedTalent['id'];
            $_SESSION['user']['hero']['talent_name'] = $evolvedTalent['name'];
    
            return [
                'old_name' => $currentTalent['name'],
                'new_name' => $evolvedTalent['name'],
                'new_description' => $evolvedTalent['description']
            ];
         } else {
            return null; 
        }
    }
    
    
}