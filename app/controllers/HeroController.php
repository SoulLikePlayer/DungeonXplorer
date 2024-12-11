<?php

class HeroController extends Controller {

    public function create() {
        $classModel = new ClassModel();
        $classes = $classModel->getAllClasses();

        $raceModel = new RaceModel();
        $race = $raceModel->getAllRace();
        $this->view('pages/create', ['classes' => $classes, 'races' => $race]);
    }

    public function store() {
        $lastname = $_POST['lastname'] ?? '';
        $firstname = $_POST['firstname'] ?? '';
        $className = $_POST['class'] ?? '';
        $raceName = $_POST['race'] ?? '';
        $biography = $_POST['bio'] ?? '';

        if (empty($lastname) || empty($firstname) || empty($className) || empty($raceName)) {
            $this->view('pages/create', ['error' => 'Nom, prénom, race et classe sont obligatoires.']);
            return;
        }

        $heroModel = new Hero();
        $classModel = new ClassModel();
        $classData = $classModel->getClassStats($className);

        $raceModel = new RaceModel();
        $raceData = $raceModel->getRaceName($raceName);
        var_dump($raceData);
        var_dump($classData);

        if ($heroModel->heroExists()) {
            $this->view('pages/create', ['error' => 'Un héros existe déjà pour cet utilisateur.']);
            return;
        }

        if ($classData) {
            $heroCreated = $heroModel->createHero(
                $lastname,
                $firstname,
                $classData['id'],
            $raceData['id'],
                $biography,
                $classData['base_pv'],
                $classData['base_mana'],
                $classData['strength'],
                $classData['initiative']
            );

            if ($heroCreated) {
                $_SESSION['user']['hero'] = $heroModel->getHeroByUserId($_SESSION['user']['id']);
                $levelModel = new levelModel();
                $level = $levelModel -> getNextLevelById($_SESSION['user']['hero']['hero_id'], $_SESSION['user']['hero']['class_id']);
                if ($level){
                    $_SESSION['user']['hero']['nextLevel'] = $level;
                }
                $chapter = $heroModel->getChapterByHeroId( $_SESSION['user']['hero']['hero_id']);
                if ($chapter) {
                    $_SESSION['Chapitre'] = $chapter["chapter"]; 
                }
                header("Location: /DungeonXplorer/");
                exit;
            } else {
                $this->view('pages/create', ['error' => 'Erreur lors de la création du personnage.']);
            }
        } else {
            $this->view('pages/create', ['error' => 'Classe non valide.']);
        }
    }    

    public function updateStats() {
        ob_clean();
        header('Content-Type: application/json');
        $data = json_decode(file_get_contents('php://input'), true);
    
        if (isset($_SESSION['user']['hero'])) {
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $pv = $data['pv'] ?? 0;
            $mana = $data['mana'] ?? 0;
            $xp = intval($data['xp']) ?? 0;
    
            $heroModel = new Hero();
            $levelModel = new levelModel();
    
            $currentLevel = $_SESSION['user']['hero']['current_level'];
            $classId = $_SESSION['user']['hero']['class_id'];
            $currentXp = $_SESSION['user']['hero']['xp'] + $xp;
    
            $level = $levelModel->getNextLevelById($heroId, $classId);
            $remainingXp = $currentXp;
    
            if ($level && $xp >= $level['required_xp']) {
                $newLevel = $currentLevel + 1;
                $pvMax = $_SESSION['user']['hero']['pv_max'] + $level['pv_bonus'];
                $manaMax = $_SESSION['user']['hero']['mana_max'] + $level['mana_bonus'];
                $strength = $_SESSION['user']['hero']['strength'] + $level['strength_bonus'];
                $initiative = $_SESSION['user']['hero']['initiative'] + $level['initiative_bonus'];
                $remainingXp -= $level['required_xp'];
    
                $updateSuccess = $heroModel->updateHeroStatsAndLevel(
                    $heroId, 
                    $pvMax, 
                    $manaMax, 
                    $strength, 
                    $initiative, 
                    $remainingXp, 
                    $newLevel
                );
    
                if ($updateSuccess) {
                    $_SESSION['user']['hero']['current_level'] = $newLevel;
                    $_SESSION['user']['hero']['pv_max'] = $pvMax;
                    $_SESSION['user']['hero']['mana_max'] = $manaMax;
                    $_SESSION['user']['hero']['strength'] = $strength;
                    $_SESSION['user']['hero']['initiative'] = $initiative;
                    $_SESSION['user']['hero']['xp'] = $remainingXp;
    
                    echo json_encode([
                        'success' => true,
                        'modalContent' => [
                            'newLevel' => $newLevel,
                            'pvBonus' => $level['pv_bonus'],
                            'manaBonus' => $level['mana_bonus'],
                            'strengthBonus' => $level['strength_bonus'],
                            'initiativeBonus' => $level['initiative_bonus']
                        ]
                    ]);
                    exit; 
                } else {
                    echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour du niveau.']);
                    exit;
                }
            } else {
                $updateSuccess = $heroModel->updateHeroStats($heroId, $pv, $mana, $xp);
    
                if ($updateSuccess) {
                    $_SESSION['user']['hero']['current_pv'] = $pv;
                    $_SESSION['user']['hero']['current_mana'] = $mana;
    
                    echo json_encode(['success' => true]);
                    exit;
                } else {
                    echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour des stats.']);
                    exit;
                }
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Héros introuvable dans la session.']);
            exit;
        }
    }
    


    

    public function updateGold() {
        $data = json_decode(file_get_contents('php://input'), true);
    
        if (isset($_SESSION['user']['hero'])) {
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $goldSpent = $data['goldSpent'] ?? 0;
    
            if ($goldSpent < 0) {
                echo json_encode(['success' => false, 'message' => 'Montant invalide.']);
                return;
            }
    
            $heroModel = new Hero();
            $currentGold = $_SESSION['user']['hero']['gold'];
            $newGold = $currentGold - $goldSpent;
    
            if ($newGold < 0) {
                echo json_encode(['success' => false, 'message' => 'Or insuffisant.']);
                return;
            }
    
            $updateSuccess = $heroModel->updateHeroGold($heroId, $newGold);
    
            if ($updateSuccess) {
                $_SESSION['user']['hero']['gold'] = $newGold;
                echo json_encode(['success' => true, 'newGold' => $newGold]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour de l\'or.']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Héros introuvable dans la session.']);
        }
    }
    

    public function show() {
        $heroModel = new Hero();
        $hero = $heroModel->getHeroByUserId($_SESSION['user']['id']);

        if ($hero) {
            $this->view('pages/hero', ['hero' => $hero]);
        } else {
            $this->view('pages/hero', ['error' => 'Aucun héros trouvé.']);
        }
    }
}
?>
