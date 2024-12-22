<?php

class Router
{
    private static $instance = null;
    private $routes = [];
    private $prefix;
    private $lockedUrls = [];

    private function __construct($prefix = '')
    {
        $this->prefix = trim($prefix, '/');
    }

    public static function getInstance($prefix = '')
    {
        if (self::$instance === null) {
            self::$instance = new Router($prefix);
        }
        return self::$instance;
    }

    public function addRoute($uri, $controllerMethod, $lockUrl = false)
    {
        $this->routes[trim($uri, '/')] = $controllerMethod;
        if ($lockUrl) {
            $this->lockedUrls[trim($uri, '/')] = true;
        }
    }

    public function route($url)
    {
        $trimmedUrl = trim($url, '/');

        if (isset($this->lockedUrls[$trimmedUrl])) {
            if ($this->isUserAttemptingToModifyUrl($trimmedUrl)) {
                echo "Erreur : Vous ne pouvez pas modifier l'URL des chapitres.";
                exit;
            }
        }

        if ($this->prefix && strpos($url, $this->prefix) === 0) {
            $url = substr($url, strlen($this->prefix) + 1);
        }

        $url = trim($url, '/');

        foreach ($this->routes as $route => $controllerMethod) {
            $routeParts = explode('/', $route);
            $urlParts = explode('/', $url);

            if (count($routeParts) === count($urlParts)) {
                $params = [];
                $isMatch = true;
                foreach ($routeParts as $index => $part) {
                    if (preg_match('/^{\w+}$/', $part)) {
                        $params[] = $urlParts[$index];
                    } elseif ($part !== $urlParts[$index]) {
                        $isMatch = false;
                        break;
                    }
                }

                if ($isMatch) {
                    list($controllerName, $methodName) = explode('@', $controllerMethod);
                    $controller = new $controllerName();
                    call_user_func_array([$controller, $methodName], $params);
                    return;
                }
            }
        }

        require_once  dirname(__DIR__) . '/' . 'views/pages/404.php';
    }

    private function isUserAttemptingToModifyUrl($url)
    {
        if (!isset($_SESSION['locked_urls'])) {
            $_SESSION['locked_urls'] = [];
        }

        if (!in_array($url, $_SESSION['locked_urls'])) {
            $_SESSION['locked_urls'][] = $url;
            return false;
        }

        return isset($_GET['userModify']) && $_GET['userModify'] == 'true';
    }
}
