<?php
    // On inclut le fichier de connexion à la base de données
    require_once('../config/config.php');

    // On initialise les variables
    $user = $_POST['user'];
    $mail = $_POST['email'];
    $password = $_POST['password'];

    // On vérifie que les variables ne soient pas vides
    if(isset($_POST["user"])) {
        if(empty($_POST["user"])) {
            $prenomError = "Le nom d'utilisateur est requis";
        } else if(!preg_match("/^[[:alpha:]ÀÂÄÉÈÊËÏÎÔÖÙÛÜŸÇàâäéèêëïîôöùûüÿç\-\s]+$/i", $_POST["user"])) {
            $prenomError = "Le nom d'utilisateur n'est pas valide";
        } else {
            $prenom = htmlspecialchars($_POST["user"]);
        }
    }

    if(isset($_POST["email"])) {
        if(empty($_POST["email"])) {
            $mailError = "L'adresse mail est requise";
        } else if(!preg_match("/^[a-zA-Z.]+@[a-zA-Z]+\.[a-zA-Z]+$/i", $_POST["email"])) {
            $mailError = "Entrez une adresse mail valide. Exemple : \"exemple.test@gmail.com\"";
        } else {
            $mail = htmlspecialchars(strtolower($_POST["email"]));
        }
    }

    if(isset($_POST["password"])) {
        if(empty($_POST["password"])) {
            $passwordError = "Le mot de passe est requis";
        } else if(strlen($_POST["password"]) < 8) {
            $passwordError = "Le mot de passe doit contenir au moins 8 caractères";
        } else {
            $password = sha1(htmlspecialchars($_POST["password"]));
        }
    }

    // On vérifie que l'utilisateur n'existe pas déjà
    function verifAccountExist($mail) {
        global $bdd;
        $req = $bdd->prepare("SELECT COUNT(*) AS count FROM Account WHERE email = :mail");
        $req->execute(array("mail" => $mail));
        $result = $req->fetch(PDO::FETCH_ASSOC);
        return $result['count'];
    }

    try {
        // On insère les données dans la base de données
        $req = $bdd->prepare("INSERT INTO Account(id, username, password, email) VALUES(:user, :mail, :password)");
        
        $success = $req->execute(array(
            "user" => $user,
            "mail" => $mail,
            "password" => sha1($password)
        ));

        if ($success) {
            // On créé une variable de session
            session_start();
            $_SESSION["com_mail"] = $mail;
            $_SESSION["com_user"] = $user;
            $_SESSION["com_nom"] = $nom;

            // On redirige l'utilisateur vers la page de connexion
            header("Location: ../../index.php");
        } else {
            // Afficher un message d'erreur
            echo "Erreur lors de l'insertion dans la base de données.";
        }
    } catch (PDOException $e) {
        // Gérer l'exception
        echo "Erreur lors de l'exécution de la requête SQL : " . $e->getMessage();
    }
    
?>


<div class = creation_compte>
    <form method="POST" action="create_account.php">
        <input type="text" id="mail" name="mail" placeholder="Email">
        <input type="text" id="user" name="user" placeholder="Nom d'utilisateur">
        <input type="password" id="password" name="password" placeholder="Mot de passe">

        <input type="submit">Créer compte</input>
        Vous avez déjà un compte : <a href="auth.php">Se connecter</a> 
    </form>
</div>
