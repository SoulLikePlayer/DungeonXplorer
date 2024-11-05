<?php

class Controller {
    public function view($view, $data = []) {
        $viewPath = __DIR__ . '/../views/' . $view . '.php';
        if (file_exists($viewPath)) {
            extract($data);
            require_once $viewPath;
        } else {
            die("Vue non trouvée : $view");
        }
    }
}
