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
            $_SESSION['user'] = $user;
            
            $hero = $userModel->getHeroByUserId($user['id']);
            if($hero){
                $_SESSION['user']['hero'] = $hero;
                header("Location: /DungeonXplorer/inventory/loadInventory");
                exit;
            }
            header('Location: /DungeonXplorer');
            ob_end_flush();
            exit;
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
            ob_end_flush();
            exit;
        }

        $this->view('users/profile');
    }

    // Afficher le formulaire pour éditer les informations de l'utilisateur
    public function edit($id) {
        $userModel = new User();
        $user = $userModel->getUserById($id);
        
        // Si l'utilisateur est introuvable ou si ce n'est pas l'utilisateur connecté
        if (!$user || $user['id'] !== $_SESSION['user']['id']) {
            header('Location: /DungeonXplorer');
            exit;
        }

        $this->view('users/edit', ['user' => $user]);
    }

    // Traiter la mise à jour des informations de l'utilisateur
    public function update($id) {
        $username = $_POST['username'] ?? '';
        $email = $_POST['email'] ?? '';

        // Validation de base
        if (empty($username) || empty($email)) {
            $this->view('users/edit', ['error' => 'Tous les champs sont requis.', 'user' => $_POST]);
            return;
        }

        $userModel = new User();
        
        // Mettre à jour l'utilisateur dans la base de données
        if ($userModel->updateUser($id, $username, $email)) {
            $_SESSION['user']['username'] = $username; // Mise à jour de la session
            $this->view('users/profile', ['success' => 'Profil mis à jour avec succès.']);
        } else {
            $this->view('users/edit', ['error' => 'Une erreur est survenue lors de la mise à jour.', 'user' => $_POST]);
        }
    }

    // Supprimer un utilisateur
    public function delete($id) {
        $userModel = new User();
        
        // Vérification de l'identité de l'utilisateur
        if ($id === $_SESSION['user']['id']) {
            $userModel->deleteUser($id);
            unset($_SESSION['user']);
            session_destroy();
            header('Location: /DungeonXplorer');
            exit;
        }

        $this->view('users/profile', ['error' => 'Vous ne pouvez pas supprimer ce compte.']);
    }
}
