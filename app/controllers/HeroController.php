<?php

class HeroController extends Controller {

    public function create() {
        $classModel = new ClassModel();
        $classes = $classModel->getAllClasses();
    
        $raceModel = new RaceModel();
        $races = $raceModel->getAllRace();
    
        $talentModel = new talentModel();
        $raceTalents = [];
    
        foreach ($races as $race) {
            $randomTalent = $talentModel->getRandomTalentForRace($race['id']);
    
            if (!$randomTalent) {
                $randomTalent = [
                    "id" => 0,
                    'name' => 'Aucun talent',
                    'description' => 'Vous êtes venu dans ce misérable monde en étant banal.',
                ];
            }
    
            $raceTalents[$race['name']] = $randomTalent;
        }
    
        $this->view('pages/create', [
            'classes' => $classes,
            'races' => $races,
            'raceTalents' => $raceTalents
        ]);
    }
    

    public function store() {
        $lastname = $_POST['lastname'] ?? '';
        $firstname = $_POST['firstname'] ?? '';
        $className = $_POST['class'] ?? '';
        $raceName = $_POST['race'] ?? '';
        $biography = $_POST['bio'] ?? '';
        $talentId = $_POST['talent_id'] ?? 0;

        if (empty($lastname) || empty($firstname) || empty($className) || empty($raceName)) {
            $this->view('pages/create', ['error' => 'Nom, prénom, race et classe sont obligatoires.']);
            return;
        }

        $heroModel = new Hero();
        $userModel = new User();
        $classModel = new ClassModel();
        $classData = $classModel->getClassStats($className);

        $raceModel = new RaceModel();
        $raceData = $raceModel->getRaceName($raceName);

        if ($talentId == 8){
            $classData['strength'] += 5;
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
                $classData['initiative'],
                $talentId
            );

            if ($heroCreated) {
                $_SESSION['user']['hero'] = $userModel->getHeroByUserId($_SESSION['user']['id']);
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
            echo var_dump($level);
            $remainingXp = $currentXp;
    
            if ($level && $remainingXp >= $level['required_xp']) {
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
                    $_SESSION['user']['hero']['xp'] = 0;
                    
                    ob_clean();
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

                    ob_clean();
                    echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour du niveau.']);
                    exit;
                }
            } else {
                $updateSuccess = $heroModel->updateHeroStats($heroId, $pv, $mana, $xp);
    
                if ($updateSuccess) {
                    $_SESSION['user']['hero']['current_pv'] = $pv;
                    $_SESSION['user']['hero']['current_mana'] = $mana;
                    $_SESSION['user']['hero']['xp'] = $xp;
    
                    ob_clean();
                    echo json_encode(['success' => true]);
                    exit;
                } else {
                    ob_clean();
                    echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour des stats.']);
                    exit;
                }
            }
        } else {
            ob_clean();
            echo json_encode(['success' => false, 'message' => 'Héros introuvable dans la session.']);
            exit;
        }
    }

    public function equipWeapon() {
        ob_clean();
        header('Content-Type: application/json');
        
        $data = json_decode(file_get_contents('php://input'), true);
    
        if ( isset($data['id']) && isset($data['type'])) {
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $weaponId = $data['id'];
            $type = $data['type']; 
    
            $heroModel = new Hero();
    
            $updateSuccess = false;
            if ($type === 'primary') {
                $updateSuccess = $heroModel->updatePrimaryWeapon($heroId, $weaponId);
            } elseif ($type === 'secondary') {
                $updateSuccess = $heroModel->updateSecondaryWeapon($heroId, $weaponId);
            } else {
                echo json_encode(['success' => false, 'message' => 'Type d\'arme invalide.']);
                exit;
                return;
            }
    
            if ($updateSuccess) {
                $_SESSION['user']['hero'] = $heroModel->getHeroById( $heroId );
                echo json_encode(['success' => true, 'message' => 'Arme équipée avec succès.']);
                exit;
            } else {
                echo json_encode(['success' => false, 'message' => 'Erreur lors de l\'équipement de l\'arme.']);
                exit;
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Données manquantes.']);
            exit;
        }
    }
    
    

    public function equipArmor() {
        ob_clean();
        header('Content-Type: application/json');
        
        $data = json_decode(file_get_contents('php://input'), true);
        
        if (isset($data['id'])) {
            $itemId = $data['id'];
            $heroId = $_SESSION['user']['hero']['hero_id'];
        
            $inventoryModel = new Inventory();
            $slotData = $inventoryModel->getSlotById($itemId);
            
            if ($slotData) {
                $slot = $slotData['slot'];
        
                $heroModel = new Hero();
                $updateSuccess = false;
        
                switch ($slot) {
                    case 'head':
                        $updateSuccess = $heroModel->updateHeroArmorSlot($heroId, 'helmet_id', $itemId);
                        break;
                    case 'body':
                        $updateSuccess = $heroModel->updateHeroArmorSlot($heroId, 'armor_id', $itemId);
                        break;
                    case 'legs':
                        $updateSuccess = $heroModel->updateHeroArmorSlot($heroId, 'greaves_id', $itemId);
                        break;
                    case 'hands':
                        $updateSuccess = $heroModel->updateHeroArmorSlot($heroId, 'gloves_id', $itemId);
                        break;
                    default:
                        echo json_encode(['success' => false, 'message' => 'Slot d\'armure inconnu.']);
                        exit;
                }
        
                if ($updateSuccess) {
                    $_SESSION['user']['hero'] = $heroModel->getHeroById($heroId);
                    echo json_encode(['success' => true, 'message' => 'Armure équipée avec succès.']);
                    exit;
                } else {
                    echo json_encode(['success' => false, 'message' => 'Erreur lors de l\'équipement de l\'armure.']);
                    exit;
                }
            } else {
                echo json_encode(['success' => false, 'message' => 'Slot d\'armure introuvable pour cet item.']);
                exit;
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Données manquantes.']);
            exit;
        }
    }
    
    

    public function updateGold() {
        ob_clean();
        $data = json_decode(file_get_contents('php://input'), true);
    
        if (isset($_SESSION['user']['hero'])) {
            $heroId = $_SESSION['user']['hero']['hero_id'];
            $goldSpent = $data['goldSpent'];
    
            $heroModel = new Hero();
            $currentGold = $_SESSION['user']['hero']['gold'];
            $newGold = $currentGold + $goldSpent;
    
            if ($newGold < 0) {
                echo json_encode(['success' => false, 'message' => 'Or insuffisant.']);
                exit;
                return;
            }
    
            $updateSuccess = $heroModel->updateHeroGold($heroId, $newGold);
    
            if ($updateSuccess) {
                $_SESSION['user']['hero']['gold'] = $newGold;
                echo json_encode(['success' => true, 'newGold' => $newGold]);
                exit;
            } else {
                echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour de l\'or.']);
                exit;
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Héros introuvable dans la session.']);
            exit;
        }
    }

    public function reset() {
        $firstname = $_SESSION['user']['hero']['hero_firstname'];
        $lastname = $_SESSION['user']['hero']['hero_lastname'];
        $className = $_SESSION['user']['hero']['class_name'];
        $raceName = $_SESSION['user']['hero']['race_name'];
        $biography = $_SESSION['user']['hero']['biography'];
        $talentId = $_SESSION['user']['hero']['talent_id'];
    
        // Création d'une instance du modèle Hero
        $heroModel = new Hero();
    
        // Suppression du héros actuel
        $heroModel->deleteHero($_SESSION['user']['hero']['hero_id']);
    
        // Récupération des données de la classe
        $classModel = new ClassModel();
        $classData = $classModel->getClassStats($className);
    
        // Récupération des données de la race
        $raceModel = new RaceModel();
        $raceData = $raceModel->getRaceName($raceName);
    
        // Création du nouveau héros
        $heroCreated = $heroModel->createHero(
            $lastname,
            $firstname,
            $classData['id'],
            $raceData['id'],
            $biography,
            $classData['base_pv'],
            $classData['base_mana'],
            $classData['strength'],
            $classData['initiative'],
            $talentId
        );
    
        if ($heroCreated) {
            $heroId =  $_SESSION['heroId'];
    
            $_SESSION['user']['hero'] = $heroModel->getHeroById($heroId);
    
            $levelModel = new levelModel();
            $level = $levelModel->getNextLevelById($heroId, $_SESSION['user']['hero']['class_id']);
            if ($level) {
                $_SESSION['user']['hero']['nextLevel'] = $level;
            }
    
            $chapter = $heroModel->getChapterByHeroId($heroId);
            if ($chapter) {
                $_SESSION['Chapitre'] = $chapter["chapter"];
            }
    
            header("Location: /DungeonXplorer/");
        }
    }
    
}
?>
