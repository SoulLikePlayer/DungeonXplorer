<?php

class ChapterController extends Controller {
    public function viewChapter($chapterId) {
        $chapterModel = new Chapter(); 
        $chapter = $chapterModel->getChapterById($chapterId); 
        $link = $chapterModel->getLinkById($chapterId);
        
        if ($chapter) {
            $this->view('pages/Chapter', ['chapter' => $chapter, 'links' => $link]);
        } else {
            echo "Chapitre non trouvé";
        }
    }
}
