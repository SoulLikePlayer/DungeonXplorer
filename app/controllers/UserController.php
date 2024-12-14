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
                $heroModel = new Hero();
                $chapter = $heroModel->getChapterByHeroId( $_SESSION['user']['hero']['hero_id']);
                if ($chapter) {
                    $_SESSION['Chapitre'] = $chapter["chapter"]; 
                }

                $sessionId = $heroModel->startSession($_SESSION['user']['hero']['hero_id']);
                $_SESSION["session_id"] = $sessionId;

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
        if(isset($_SESSION['session_id'])){
            $heroModel = new Hero();
            $heroModel->endSession($_SESSION['session_id']);
        }
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
    public function edit() {
        $userModel = new User();
        $user = $userModel->getUserById( $_SESSION['user']['id']);

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
    public function delete() {
        $userModel = new User();
        
        $userModel->deleteUser($_SESSION['user']['id']);
        unset($_SESSION['user']);
        session_destroy();
        header('Location: /DungeonXplorer');
        exit;
    }

    // Affichage du pannel Admin
    public function pannelAdmin(){
        $userModel = new User();
        $allUser = $userModel->getAllUser();
        $_SESSION['admin']['allUser'] = $allUser;
        $this->view('pages/Pannel_admin');
    }

    public function deleteUserAdmin($id){
        $userModel = new User();
        $userModel->deleteUser($id);
        $allUser = $userModel->getAllUser();
        $_SESSION['admin']['allUser'] = $allUser;
        header('Location: /DungeonXplorer/admin/pannel');
        exit;
    }

    public function details_user_admin($id){
        $userModel = new User();
        $userSelected = $userModel->getUserById($id);
        $userHeros = $userModel->getHeroByUserId($id);
        $details = $userModel->getUserDetails($id);

        $_SESSION['admin']['userSelect'] = $userSelected;
        $_SESSION['admin']['userHeros'] = $userHeros ?? [];
        $_SESSION['admin']['userStat'] = $details;
        
        $this->view('pages/details_user_admin');
    }
    
}
