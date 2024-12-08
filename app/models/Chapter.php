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
                e.related_npc_id
            FROM Chapter c
            LEFT JOIN Event e ON c.id = e.chapter_id
            WHERE c.id = :id
        ");
        $stmt->bindParam(':id', $chapterId, PDO::PARAM_INT);
        $stmt->execute();
    
        $chapter = $stmt->fetch(PDO::FETCH_ASSOC);
    
        // Si le chapitre est de type "combat", on charge les informations du monstre
        if ($chapter['chapter_type'] === 'combat' && isset($chapter['related_monster_id'])) {
            $monsterModel = new Monster();
            $monster = $monsterModel->getMonsterById($chapter['related_monster_id']);
            
            // Enregistrer les informations du monstre dans la session
            if ($monster) {
                $_SESSION['monster'] = $monster;
                $_SESSION['monster']['loot'] = $monsterModel->getLootById($chapter['related_monster_id']);
            }
        }

        if (($chapter['chapter_type'] === 'npc_interaction' || $chapter['chapter_type'] === 'merchent') && isset($chapter['related_npc_id'])) {
            $npcModel = new NPC();
            $npcModel->getNPCById($chapter['related_npc_id']);
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

