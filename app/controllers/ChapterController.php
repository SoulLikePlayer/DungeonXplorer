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
            $_SESSION['user']['hero']['current_pv'] = $pvMax;
            $_SESSION['user']['hero']['current_mana'] = $manaMax;
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

    public function resetChapter(){
        $chapterModel = new Chapter();
        $chapterModel->deleteHeroStory($_SESSION['user']['hero']['hero_id']);
        unset($_SESSION['Chapitre']);

        header('Location: /DungeonXplorer');
        exit;
    }
}
