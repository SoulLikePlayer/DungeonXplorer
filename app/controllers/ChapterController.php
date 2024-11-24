<?php

class ChapterController extends Controller {
    public function viewChapter($chapterId) {
        if (!isset($_SESSION['Chapitre'])) {
            $_SESSION['Chapitre'] = 1;
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $pvMax = $_SESSION['user']['hero']['pv_max'];
            $manaMax = $_SESSION['user']['hero']['mana_max'];
            $heroModel = new Hero();
            $heroModel->createHeroStory($heroId, $pvMax, $manaMax);
        } else {
            $_SESSION['Chapitre'] = $chapterId;
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $heroModel = new Hero();
            $heroModel->updateHeroStoryChapter($heroId, $_SESSION['Chapitre']);
        }
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
