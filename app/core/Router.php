<?php

class Router
{
    private $routes = [];
    private $prefix;

    public function __construct($prefix = '')
    {
        $this->prefix = trim($prefix, '/');
    }

    public function addRoute($uri, $controllerMethod)
    {
        $this->routes[trim($uri, '/')] = $controllerMethod;
    }

    public function route($url)
    {
        if ($this->prefix && strpos($url, $this->prefix) === 0) {
            $url = substr($url, strlen($this->prefix) + 1);
        }

        $url = trim($url, '/');

        if (array_key_exists($url, $this->routes)) {
            list($controllerName, $methodName) = explode('@', $this->routes[$url]);

            $controller = new $controllerName();
            $controller->$methodName();
        } else {
            echo '<h2>La page demandée n\'existe pas</h2>';
        }
    }
}

