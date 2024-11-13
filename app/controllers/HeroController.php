<?php

class HeroController extends Controller {

    // Afficher le formulaire de création de personnage
    public function create() {
        $this->view('pages/create');
    }

    // Traiter la création de personnage
    public function store() {
        $firstname = $_POST['firstname'] ?? '';
        $lastname = $_POST['lastname'] ?? '';
        $class = $_POST['class'] ?? '';
        $bio = $_POST['bio'] ?? '';

        // Validation de base
        if (empty($lastname) || empty($firstname) || empty($class)) {
            $this->view('pages/create', ['error' => 'Il faut entrer un nom et un prénom et choisir sa classe.']);
            return;
        }

        // Vérification si un personnage existe déjà
        $heroModel = new Hero();
        if ($heroModel->heroExists()) {
            $this->view('pages/create', ['error' => 'Êtes vous sûr de vouloir supprimer votre ancien personnage et en créer un nouveau ?']);
            return;
        }

        // Création du personnage
        if ($heroModel->createHero($lastname, $firstname, $class, $bio)) {
            $this->view('pages/home', ['success' => 'Votre personnage a été créé avec succès.']);
        } else {
            $this->view('pages/create', ['error' => 'Une erreur est survenue lors de la création de votre personnage.']);
        }
    }

        $heroModel = new Hero();
        
        // Vérifier si le hero existe
        $hero = $heroModel->getHero($_SESSION['user']['id']);

        if ($hero) {
            
        } else {
            
        }
    }

    // Supprimer le personnage
    public function delete($id) {
        $heroModel = new Hero();
        
        // Vérification de l'identité de l'utilisateur
        if ($id === $_SESSION['user']['id']) {
            $heroModel->deleteHero($id);
            
            exit;
        }

        $this->view('pages/home', ['error' => 'Vous ne pouvez pas supprimer ce personnage.']);
    }
}
