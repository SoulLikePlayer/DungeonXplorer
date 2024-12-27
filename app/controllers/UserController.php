<?php

class UserController extends Controller {

    // Afficher le formulaire de création de compte
    public function create() {
        $this->view('users/create');
    }

    // Traiter la création de compte
    public function store() {
        $firstName = $_POST['firstname'] ?? null; // Facultatif
        $lastName = $_POST['lastname'] ?? null;   // Facultatif
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
        if ($userModel->createAccount($username, $password, $email, $firstName, $lastName)) {
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
        $usernameOrEmail = $_POST['username'] ?? ''; // Peut être un pseudo ou un email
        $password = $_POST['password'] ?? '';
    
        // Vérification de base
        if (empty($usernameOrEmail) || empty($password)) {
            $this->view('users/login', ['error' => 'Tous les champs sont requis.']);
            return;
        }
    
        $userModel = new User();
    
        // Vérifier si l'utilisateur existe avec le pseudo ou l'email
        $user = $userModel->getUserByUsernameOrEmail($usernameOrEmail);

        if ($user && password_verify($password, $user['password'])) {
            $_SESSION['user'] = $user;
    
            $hero = $userModel->getHeroByUserId($user['id']);
            if ($hero) {
                $_SESSION['user']['hero'] = $hero;
                $heroModel = new Hero();
                $chapter = $heroModel->getChapterByHeroId($_SESSION['user']['hero']['hero_id']);
                if ($chapter) {
                    $_SESSION['Chapitre'] = $chapter["chapter"];
                }
    
                $sessionId = $userModel->startSession($_SESSION['user']['id']);
                $_SESSION["session_id"] = $sessionId;
    
                header("Location: /DungeonXplorer/inventory/loadInventory");
                exit;
            }
            header('Location: /DungeonXplorer');
            ob_end_flush();
            exit;
        } else {
            // Sinon, on affiche un message d'erreur
            $this->view('users/login', ['error' => 'Nom d\'utilisateur, email ou mot de passe incorrect.']);
        }
    }
    

    // Déconnexion
    public function logout() {
        unset($_SESSION['user']);
        if(isset($_SESSION['session_id'])){
            $userModel = new User();
            $userModel->endSession($_SESSION['session_id']);
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
        $userModel = new User();
        $heroes = $userModel->getHeroByUserId($_SESSION['user']['id']);


        $this->view('users/profile', ['heroes' => $_SESSION['user']['allHero'] ?? []]);
    }

    public function selectHero() {
        $heroId = $_POST['hero_id'] ?? null;
    
        if ($heroId) {
            $heroModel = new Hero();
            $hero = $heroModel->getHeroById($heroId);
    
            if ($hero) {
                $_SESSION['user']['hero'] = $hero;
                if(isset($_SESSION['Chapitre'])){
                    unset($_SESSION['Chapitre']);
                }
                $chapter = $heroModel->getChapterByHeroId($_SESSION['user']['hero']['hero_id']);
                if ($chapter) {
                    $_SESSION['Chapitre'] = $chapter["chapter"];
                }
    
                $this->view('users/profile', ['success' => 'Héros sélectionné avec succès.', "heroes" => $_SESSION['user']['allHero']]);
            } else {
                $this->view('users/profile', ['error' => 'Héros invalide.']);
            }
        } else {
            $this->view('users/profile', ['error' => 'Veuillez sélectionner un héros.']);
        }
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
        $userHeros = $userModel->getAllHeroByUserId($id);
        $details = $userModel->getUserDetails($id);

        $_SESSION['admin']['userSelect'] = $userSelected;
        $_SESSION['admin']['userHeros'] = $userHeros ?? [];
        $_SESSION['admin']['userStat'] = $details;
        
        $this->view('pages/details_user_admin');
    }

    public function chaptersListAdmin() {
        $chapterModel = new Chapter();
        $chapters = $chapterModel->getAllChapters();
        $this->view('pages/chapterList', ['chapters' => $chapters]);
    }

    public function monstersListAdmin() {
        $monsterModel = new Monster();
        $monsters = $monsterModel->getAllMonsters();
    
        foreach ($monsters as &$monster) {
            $monster['loots'] = $monsterModel->getLootById($monster['id']);
            $monster['attacks'] = $monsterModel->getAttacksByMonsterId($monster['id']);
        }
    
        $this->view('pages/monsters_list_admin', ['monsters' => $monsters]);
    }

    public function deleteHero() {
        $heroId = $_POST['hero_id'] ?? null;
    
        if ($heroId) {
            $heroModel = new Hero();
            $userModel = new User();
            
            $hero = $heroModel->getHeroById($heroId);
            if ($heroModel->deleteHero($heroId)) {
                    if ($_SESSION['user']['hero']['hero_id'] === $heroId) {
                        unset($_SESSION['user']['hero']);
                        unset($_SESSION['Chapitre']);
                    }
    
                    $heroes = $userModel->getHeroByUserId($_SESSION['user']['id']);
                    
                    $this->view('users/profile', ['success' => 'Héros supprimé avec succès.', 'heroes' => $_SESSION['user']['allHero']]);
                } else {
                    $this->view('users/profile', ['error' => 'Une erreur est survenue lors de la suppression du héros.']);
            }
        } else {
            $this->view('users/profile', ['error' => 'Veuillez sélectionner un héros à supprimer.']);
        }
    }
    
    
    
}
