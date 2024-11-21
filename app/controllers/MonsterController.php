<?php

class MonsterController extends Controller {

    // Affiche la page pour créer un monstre
    public function create() {
        $this->view('pages/create_monster'); // Afficher une page de formulaire de création de monstre
    }

    // Stocke le monstre créé dans la base de données
    public function store() {
        $name = $_POST['name'] ?? '';
        $pv = $_POST['pv'] ?? 0;
        $mana = $_POST['mana'] ?? 0;
        $initiative = $_POST['initiative'] ?? 0;
        $strength = $_POST['strength'] ?? 0;
        $attack = $_POST['attack'] ?? '';
        $xp = $_POST['xp'] ?? 0;

        if (empty($name)) {
            $this->view('pages/create_monster', ['error' => 'Le nom du monstre est obligatoire.']);
            return;
        }

        $monsterModel = new Monster();

        // Vérifie si le monstre existe déjà
        if ($monsterModel->monsterExists($name)) {
            $this->view('pages/create_monster', ['error' => 'Ce monstre existe déjà.']);
            return;
        }

        // Création du monstre
        $monsterCreated = $monsterModel->createMonster(
            $name,
            $pv,
            $mana,
            $initiative,
            $strength,
            $attack,
            $xp
        );

        if ($monsterCreated) {
            header("Location: /DungeonXplorer/monster/showAll");
            exit;
        } else {
            $this->view('pages/create_monster', ['error' => 'Erreur lors de la création du monstre.']);
        }
    }
}
?>
