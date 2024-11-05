<?php

class UserController extends Controller {

    // Afficher le formulaire de création de compte
    public function create() {
        $this->view('users/create');
    }

    // Traiter la création de compte
    public function store() {
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        $email = $_POST['email'] ?? '';

        // Validation de base
        if (empty($username) || empty($password) || empty($email)) {
            $this->view('users/create', ['error' => 'Tous les champs sont requis.']);
            return;
        }

        // Vérification si l'utilisateur existe déjà
        $userModel = new User();
        if ($userModel->userExists($username, $email)) {
            $this->view('users/create', ['error' => 'Le nom d\'utilisateur ou l\'email est déjà utilisé.']);
            return;
        }

        // Création de l'utilisateur
        if ($userModel->createAccount($username, $password, $email)) {
            $this->view('users/login', ['success' => 'Votre compte a été créé avec succès.']);
        } else {
            $this->view('users/create', ['error' => 'Une erreur est survenue lors de la création de votre compte.']);
        }
    }
}
