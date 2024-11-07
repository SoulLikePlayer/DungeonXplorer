<?php

class Chapter extends Model {
    public function getChapterById($chapterId) {
        $db = $this->getDatabaseConnection();
        
        $stmt = $db->prepare("SELECT * FROM Chapter WHERE id = :id");
        $stmt->bindParam(':id', $chapterId, PDO::PARAM_INT);
        $stmt->execute();
        
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getAllChapters() {
        $db = $this->getDatabaseConnection();
        $stmt = $db->query("SELECT * FROM Chapter ORDER BY id ASC");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
