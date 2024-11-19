<?php

class HeroController extends Controller {

    /**
     * Affiche la page de création d'un héros avec la liste des classes disponibles.
     */
    public function create() {
        $classModel = new ClassModel();
        $classes = $classModel->getAllClasses();
        $this->view('pages/create', ['classes' => $classes]);
    }

    /**
     * Stocke un nouveau héros dans la base de données.
     */
    public function store() {
        // Récupérer les données du formulaire
        $lastname = $_POST['lastname'] ?? '';
        $firstname = $_POST['firstname'] ?? '';
        $className = $_POST['class'] ?? '';
        $biography = $_POST['bio'] ?? '';

        // Vérifier les champs obligatoires
        if (empty($lastname) || empty($firstname) || empty($className)) {
            $this->view('pages/create', ['error' => 'Nom, prénom et classe sont obligatoires.']);
            return;
        }

        // Initialisation des modèles nécessaires
        $heroModel = new Hero();
        $classModel = new ClassModel();
        $classData = $classModel->getClassStats($className);

        // Vérifier si un héros existe déjà pour l'utilisateur
        if ($heroModel->heroExists()) {
            $this->view('pages/create', ['error' => 'Un héros existe déjà pour cet utilisateur.']);
            return;
        }

        // Création du héros si la classe est valide
        if ($classData) {
            $heroId = $heroModel->createHero(
                $lastname,
                $firstname,
                $classData['id'],
                $biography,
                $classData['base_pv'],
                $classData['base_mana'],
                $classData['strength'],
                $classData['initiative']
            );

            // Si le héros est créé, gérer les armes principales et secondaires
            if ($heroId) {
                // Définir les armes en fonction de la classe
                $primaryWeapon = null;
                $secondaryWeapon = null;

                if ($className === 'Guerrier') {
                    $primaryWeapon = 17; // Épée de guerre
                    $secondaryWeapon = 34; // Bouclier
                } elseif ($className === 'Magicien') {
                    $primaryWeapon = 22; // Bâton magique
                    $secondaryWeapon = 35; // Dague
                } elseif ($className === 'Voleur') {
                    $primaryWeapon = 27; // Dagues de voleur
                    $secondaryWeapon = 35; // Dague
                }

                // Mettre à jour les armes principales et secondaires dans la table Hero
                if ($primaryWeapon && $secondaryWeapon) {
                    $heroModel = new Hero();
                    $heroModel->setArmeHero($primaryWeapon, $secondaryWeapon, $heroId);
                }

                // Charger les informations du héros dans la session et rediriger
                $_SESSION['user']['hero'] = $heroModel->getHeroByUserId($_SESSION['user']['id']);
                header("Location: /DungeonXplorer/inventory/loadInventory");
                exit;
            } else {
                $this->view('pages/create', ['error' => 'Erreur lors de la création du personnage.']);
            }
        } else {
            $this->view('pages/create', ['error' => 'Classe non valide.']);
        }
    }
}
