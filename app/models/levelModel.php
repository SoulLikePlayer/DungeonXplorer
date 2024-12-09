<?php
class LevelModel extends Model{
    public function getAllLevel(){
        $db = $this->getDatabaseConnection();

        $levelQuery='SELECT * FROM Level';

        $stmtLevel = $db->prepare($levelQuery);
        $stmtLevel->execute();

        return $stmtLevel->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getNextLevelById($id, $classId) {
        $db = $this->getDatabaseConnection();

        $levelQuery = 'SELECT l.*
                        FROM Level l JOIN Hero h ON h.class_id = l.class_id
                        WHERE l.class_id = :classId
                        AND h.id = :id
                        AND l.level = h.current_level+1';
        $stmtLevel = $db->prepare($levelQuery);
        $stmtLevel -> bindParam(':classId', $classId);
        $stmtLevel -> bindParam(':id', $id);
        $stmtLevel -> execute();

        $level = $stmtLevel->fetch(PDO::FETCH_ASSOC);
        if (!$level) {
            error_log('No level found for class_id: ' . $classId . ' and hero_id: ' . $id);
        }

        return $level;
    }


    public function getListLevelByClassId($classId){
        $db = $this->getDatabaseConnection();

        $levelClassQuery = 'SELECT * FROM Level WHERE class_id =:classId';

        $stmtLevel = $db->prepare($levelClassQuery);
        $stmtLevel -> bindParam(':classId', $classId);
        $stmtLevel -> execute();

        return $stmtLevel->fetchAll(PDO::FETCH_ASSOC);
    }
}