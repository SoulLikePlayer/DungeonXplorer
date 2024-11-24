<?php

class HeroController extends Controller {

    public function create() {
        $classModel = new ClassModel();
        $classes = $classModel->getAllClasses();
        $this->view('pages/create', ['classes' => $classes]);
    }

    public function store() {
        $lastname = $_POST['lastname'] ?? '';
        $firstname = $_POST['firstname'] ?? '';
        $className = $_POST['class'] ?? '';
        $biography = $_POST['bio'] ?? '';

        if (empty($lastname) || empty($firstname) || empty($className)) {
            $this->view('pages/create', ['error' => 'Nom, prénom et classe sont obligatoires.']);
            return;
        }

        $heroModel = new Hero();
        $classModel = new ClassModel();
        $classData = $classModel->getClassStats($className);

        if ($heroModel->heroExists()) {
            $this->view('pages/create', ['error' => 'Un héros existe déjà pour cet utilisateur.']);
            return;
        }

        if ($classData) {
            $heroCreated = $heroModel->createHero(
                $lastname,
                $firstname,
                $classData['id'],
                $biography,
                $classData['base_pv'],
                $classData['base_mana'],
                $classData['strength'],
                $classData['initiative']
            );

            if ($heroCreated) {
                $_SESSION['user']['hero'] = $heroModel->getHeroByUserId($_SESSION['user']['id']);
                $chapter = $heroModel->getChapterByHeroId( $_SESSION['user']['hero']['id']);
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
        $data = json_decode(file_get_contents('php://input'), true);
    
        if (isset($_SESSION['user']['hero'])) {
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $pv = $data['pv'] ?? 0;
            $mana = $data['mana'] ?? 0;
            $xp = $data['xp'] ?? 0;
            $level = $data['level'] ?? 0;
    
            $heroModel = new Hero();
            $updateSuccess = $heroModel->updateHeroStats($heroId, $pv, $mana);
    
            if ($updateSuccess) {
                // Mise à jour des données du héros dans la session
                $_SESSION['user']['hero']['pv'] = $pv;
                $_SESSION['user']['hero']['mana'] = $mana;
                $_SESSION['user']['hero']['xp'] = $xp;
                $_SESSION['user']['hero']['current_level'] = $level;
    
                echo json_encode(['success' => true]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour.']);
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
