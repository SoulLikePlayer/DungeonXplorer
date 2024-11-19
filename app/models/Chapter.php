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
                END AS chapter_type
            FROM Chapter c
            LEFT JOIN Event e ON c.id = e.chapter_id
            WHERE c.id = :id
        ");
        $stmt->bindParam(':id', $chapterId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
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
}
?>

