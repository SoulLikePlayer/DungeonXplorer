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

    // Afficher le formulaire de connexion
    public function login() {
        $this->view('users/login');
    }

    // Traiter la connexion de l'utilisateur
    public function handleLogin() {
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';

        // Vérification de base
        if (empty($username) || empty($password)) {
            $this->view('users/login', ['error' => 'Tous les champs sont requis.']);
            return;
        }

        $userModel = new User();
        
        // Vérifier si l'utilisateur existe
        $user = $userModel->getUserByUsername($username);

        if ($user && password_verify($password, $user['password'])) {
            // Si la connexion réussie, on démarre une session et redirige l'utilisateur
            $_SESSION['user'] = $user;
            header('Location: /DungeonXplorer');
        } else {
            // Sinon, on affiche un message d'erreur
            $this->view('users/login', ['error' => 'Nom d\'utilisateur ou mot de passe incorrect.']);
        }
    }

    // Déconnexion
    public function logout() {
        unset($_SESSION['user']);
        session_destroy();
        header('Location: /DungeonXplorer');
    }

    // Profil de l'utilisateur
    public function profile() {
        if (!isset($_SESSION['user'])) {
            header('Location: /DungeonXplorer/user/login');
            exit;
        }

        $this->view('/DungeonXplorer/users/profile');
    }
}
