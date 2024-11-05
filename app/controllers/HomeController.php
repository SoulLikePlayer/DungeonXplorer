<?php

require_once './app/config/config.php';

class HomeController
{
    public function index()
    {
        require 'app/views/pages/home.php';
    }
}

