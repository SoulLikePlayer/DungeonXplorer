<?php

class ChapterController extends Controller {
    public function viewChapter($chapterId) {
        if (!isset($_SESSION['Chapitre'])) {
            $_SESSION['Chapitre'] = 1;
            $_SESSION['Visited_Chapter'] = [1];

            $heroId = $_SESSION['user']['hero']['hero_id'];
            $pvMax = $_SESSION['user']['hero']['pv_max'];
            $manaMax = $_SESSION['user']['hero']['mana_max'];
            $heroModel = new Hero();
            $heroModel->createHeroStory($heroId, $pvMax, $manaMax);
            $_SESSION['user']['hero']['current_pv'] = $pvMax;
            $_SESSION['user']['hero']['current_mana'] = $manaMax;
        } else {
            if(!isset( $_SESSION['Visited_Chapter'])){
                $_SESSION['Visited_Chapter'] = [(int)$chapterId];
            }
            $chapterModel = new Chapter();
            $chapter = $chapterModel->getChapterById($chapterId);

            if ($chapter['chapter_type'] === 'death') {
                $_SESSION['ChapitrePevious'] = $_SESSION['Chapitre'];
            }

            $_SESSION['Chapitre'] = $chapterId;

            if ($chapterId !== 10 && !in_array($chapterId, $_SESSION['Visited_Chapter'])) {
                $_SESSION['Visited_Chapter'][] =(int)$chapterId;
            }

            $heroId = $_SESSION['user']['hero']['hero_id'];
            $heroModel = new Hero();
            $heroModel->updateHeroStoryChapter($heroId, $_SESSION['Chapitre']);
        }

        $chapterModel = new Chapter();
        $chapter = $chapterModel->getChapterById($chapterId);
        $link = $chapterModel->getLinkById($chapterId);

        if ($chapter && $chapter['chapter_type'] === 'death' && $_SESSION['user']['hero']['talent_id'] === 21) {
            $_SESSION['user']['hero']['current_pv'] = $_SESSION['user']['hero']['pv_max'];
            $_SESSION['user']['hero']['current_mana'] = $_SESSION['user']['hero']['mana_max'];
              
            $heroModel = new Hero();
            $heroModel->updateHeroMadness(5, $_SESSION['user']['hero']['hero_id']);


            $titles = [
                "Encore mort... hehe...",
                "Haha, encore une fois...",
                "Un autre retour du trépas ?",
                "C'est marrant, non ? Encore mort...",
                "Ah, c'est pas vrai... Tu crèves encore ?",
                "Un autre échec... Quelle surprise.",
                "Mort ? Encore ? T'es un vrai pro dans ce domaine.",
                "Tu viens de gagner le prix du retour à la vie... encore une fois.",
                "Sérieusement, t'as déjà assez de morts à ton actif ?",
                "C'est bien, tu me fais bien rire. Encore une mort ?",
                "T'es une légende… une légende de la mort.",
                "On dirait que la mort t'aime bien... elle revient toujours te chercher.",
                "Ah, tu pensais vraiment que ça allait marcher cette fois ?",
                "Retourne à l'école de survie, t'es encore loin du compte.",
            ];
            $contents = [
                "Allez, réveille-toi minable... Tu crois vraiment que la mort va t'arrêter ?",
                "Tu pensais vraiment que la mort allait t'échapper ? T'es une blague.",
                "Encore une fois, tu te relèves comme un idiot... vraiment pathétique.",
                "Ah, encore toi. Ça devient presque ennuyeux à force.",
                "T'es encore mort, comme un idiot... Tu crois qu'on va encore te ramener à la vie comme ça ?",
                "C'est comique, vraiment. T'as échoué encore une fois. Bien joué !",
                "Ah, quelle surprise, tu t'es encore fait tuer. Ça va devenir une habitude, ça.",
                "Tu peux pas arrêter de mourir ? C'est épuisant à force.",
                "Vraiment, t'es trop marrant. Encore une mort, encore une chance pour toi de rater tout ce que tu touches.",
                "C'est presque impressionnant. La quantité de fois où tu meurs... faut être un pro pour ça.",
                "Tu pourrais donner des cours sur la manière de mourir sans trop d'efforts. Bravo pour ton expertise !",
                "T'as pris des cours de survie ? Parce qu'il faudrait sérieusement les recommencer.",
                "Tu crois vraiment que la mort te laisse tranquille ? Réveille-toi, idiot.",
                "Encore une fois, tu te relèves comme si la mort te portait une attention particulière. T'es un vrai comique.",
            ];
            $randomTitle = $titles[array_rand($titles)];
            $randomContent = $contents[array_rand($contents)];

            $chapter['titre'] = $randomTitle;
            $chapter['content'] = $randomContent;
        }elseif($_SESSION['user']['hero']['talent_id'] === 24){
            $words = explode(' ', $chapter['content']); 
            $flou = [];
            $totalWords = count($words);

            for ($i = 0; $i < $totalWords; $i++) {
                if (rand(0, 3) === 0) { 
                    $flou[] = $words[$i];
                } else { 
                    $flou[] = '...';
                }
            }
            $chapter['content'] = implode(' ',$flou);
        }

        if ($chapter) {
            if(isset($_SESSION['talent_change'])){
                $talent_change = $_SESSION['talent_change'];
                unset($_SESSION['talent_change']);
                $this->view('pages/Chapter', ['chapter' => $chapter, 'links' => $link, "new_talent" => $talent_change]);
            }else{
                $this->view('pages/Chapter', ['chapter' => $chapter, 'links' => $link]);
            }

        } else {
            echo "Chapitre non trouvé";
        }
    }

    public function previewFuture($chapterId) {
        header('Content-Type: application/json');
    
        $chapterModel = new Chapter();
        $chapter = $chapterModel->getChapterById($chapterId);

        $heroModel = new Hero();
        $heroModel->updateHeroMadness(5, $_SESSION['user']['hero']['hero_id']);
        $this->determineMadness();
    
        if ($chapter) {
            $words = explode(' ', $chapter['content']); 
            $flou = [];
            $totalWords = count($words);

            for ($i = 0; $i < $totalWords; $i++) {
                if (rand(0, 3) === 0) { 
                    $flou[] = $words[$i];
                } elseif (end($flou) !== '...') { 
                    $flou[] = '...';
                }
            }
            ob_clean();
            echo json_encode(['words' => $flou]);

            exit;
        } else {
            ob_clean();
            echo json_encode(['words' => ['...', 'avenir', 'flou', 'incertain', '...']]);
            exit;
        }
    }
    

    public function resetChapter() {
        $chapterModel = new Chapter();

        if ($_SESSION['user']['hero']['talent_id'] === 21) {
            $savePoint = $this->determineSavePoint();

            if ($savePoint) {
                $_SESSION['Chapitre'] = $savePoint['id'];

                $_SESSION['Visited_Chapter'] = array_filter(
                    $_SESSION['Visited_Chapter'],
                    fn($chapterId) => $chapterId <= $savePoint['id']
                );
                $this->determineMadness();
                header('Location: /DungeonXplorer/chapter/view/' . $savePoint['id']);
                exit;
            }
        }

        $chapterModel->deleteHeroStory($_SESSION['user']['hero']['hero_id']);
        unset($_SESSION['Chapitre']);
        unset($_SESSION['Visited_Chapter']);

        header('Location: /DungeonXplorer/hero/reset');
        exit;
    }

    private function determineSavePoint() {
        $chapterModel = new Chapter();

        if (!empty($_SESSION['Visited_Chapter'])) {
            $eligibleChapters = array_filter(
                $_SESSION['Visited_Chapter'],
                function ($chapterId) use ($chapterModel) {
                    $chapter = $chapterModel->getChapterById($chapterId);
                    return $chapter['id'] < $_SESSION['ChapitrePevious'] && $chapter['chapter_type'] !== 'combat';
                }
            );

            if (!empty($eligibleChapters)) {
                $savePointId = $eligibleChapters[array_rand($eligibleChapters)];
                return $chapterModel->getChapterById($savePointId);
            }
        }

        return null;
    }

    public function determineMadness() {
        if ($_SESSION['user']['hero']['madness'] >= 50) {
            $talentModel = new talentModel();
            $talentChange = $talentModel->evolveCurse($_SESSION['user']['hero']['talent_id'], $_SESSION['user']['hero']['hero_id']);
    
            if ($talentChange) {
                $_SESSION['talent_change'] = $talentChange;
            }
        }
    }

    public function getChapter($chapterId) {
        header('Content-Type: application/json');
    
        $chapterModel = new Chapter();
        $chapter = $chapterModel->getInformationById($chapterId)[0];
    
        if ($chapter) {
            $data = [
                'success' => true,
                'chapter' => [
                    'title' => htmlspecialchars($chapter['titre']),
                    'content' => htmlspecialchars($chapter['content']),
                    'events' => htmlspecialchars($chapter['chapter_type'])
                ]
            ];
        } else {
            $data = ['success' => false];
        }
        ob_clean();
        echo json_encode($data);
        exit;
    }
    
    public function updateChapter() {
        ob_clean();
        header('Content-Type: application/json');
        $data = json_decode(file_get_contents('php://input'), true);        
        
        if (isset($data['title']) || isset($data['content'])) {
            if (isset($data['title'])) {
                $newTitle = htmlspecialchars($data['title']);
            } else {
                $newTitle = null;
            }
    
            if (isset($data['content'])) {
                $newContent = htmlspecialchars($data['content']);
            } else {
                $newContent = null;
            }

            $chapterId=$data['chapterId'];
    
            $chapterModel = new Chapter();
            $updateSuccess = $chapterModel->updateChapter($chapterId, $newTitle, $newContent);
            
            if ($updateSuccess) {
                echo json_encode(['success' => true, 'message' => 'Chapitre mis à jour avec succès.']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour du chapitre.']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Aucune donnée valide reçue.']);
        }
    
        exit;
    }
    
}
