<?php

class ChapterController extends Controller {
    public function viewChapter($chapterId) {
        $chapterModel = new Chapter(); 
        $chapter = $chapterModel->getChapterById($chapterId); 
        
        if ($chapter) {
            $this->view('pages/Chapter', ['chapter' => $chapter]);
        } else {
            echo "Chapitre non trouvé";
        }
    }
}
