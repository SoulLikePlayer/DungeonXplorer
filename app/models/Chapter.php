<?php

class Chapter extends Model {
    public function getChapterById($chapterId) {
        $db = $this->getDatabaseConnection();
    
        $stmt = $db->prepare("
            SELECT
                c.*,
                CASE
                    WHEN e.id IS NULL THEN 'normal'
                    ELSE e.event_type
                END AS chapter_type,
                e.related_monster_id,
                e.related_npc_id,
                e.related_treasure_id
            FROM Chapter c
            LEFT JOIN Event e ON c.id = e.chapter_id
            WHERE c.id = :id
        ");
        $stmt->bindParam(':id', $chapterId, PDO::PARAM_INT);
        $stmt->execute();
    
        $events = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!empty($events)) {
            $chapter = $events[0];
        }
        unset($_SESSION['npc']);
    
        foreach ($events as $event) {
            switch ($event['chapter_type']) {
                case 'combat':
                    if (isset($chapter['related_monster_id'])) {
                        $monsterModel = new Monster();
                        $monster = $monsterModel->getMonsterById($chapter['related_monster_id']);
    
                        if ($monster) {
                            $_SESSION['monster'] = $monster;
                            $_SESSION['monster']['loot'] = $monsterModel->getLootById($chapter['related_monster_id']);
                            $_SESSION['monster']['attack'] = $monsterModel->getAttacksByMonsterId($chapter['related_monster_id']);
                        }
                    }
                    break;
    
                case 'npc_interaction':
                    if (isset($chapter['related_npc_id'])) {
                        $npcModel = new NPC();
                        $npc = $npcModel->getNPCById($chapter['related_npc_id'], $chapterId);
                    }
                    break;
                case 'merchent':
                    if (isset($chapter['related_npc_id'])) {
                        $npcModel = new NPC();
                        $npc = $npcModel->getNPCById($chapter['related_npc_id'], $chapterId);
                    }
                    break;
    
                case 'treasure':
                    if (isset($chapter['related_treasure_id'])) {
                        $treasureModel = new Treasure();
                        $treasure = $treasureModel->getTreasureById($chapter['related_treasure_id']);
    
                        if ($treasure) {
                            $_SESSION['treasure'] = $treasure;
                        }
                    }
                    break;
    
                case 'healing':
                    $_SESSION['user']['hero']['current_pv'] = $_SESSION['user']['hero']['pv_max'];
                    $_SESSION['user']['hero']['current_mana'] = $_SESSION['user']['hero']['mana_max'];
                    break;
    
            }
        }
    
        return $chapter;
    }
    
    
    

    public function getLinkById($chapterId) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare("
            SELECT *
            FROM Links
            WHERE chapter_id = :id
        ");
        $stmt->bindParam(':id', $chapterId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getAllChapters() {
        $db = $this->getDatabaseConnection();

        $stmt = $db->query("
            SELECT
                c.*,
                CASE
                    WHEN e.id IS NULL THEN 'normal'
                    ELSE e.event_type
                END AS chapter_type
            FROM Chapter c
            LEFT JOIN Event e ON c.id = e.chapter_id
            ORDER BY c.id ASC
        ");

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function deleteHeroStory($hero_id){

        $db = $this->getDatabaseConnection();
        $stmt = $db->prepare('DELETE FROM Hero_Story WHERE hero_id=  :hero_id');
        $stmt->bindParam(':hero_id', $hero_id, PDO::PARAM_INT);
        $stmt->execute();
    }
    
}
?>

