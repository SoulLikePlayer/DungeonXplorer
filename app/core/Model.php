<?php

class Model {
    protected function getDatabaseConnection() {
        require_once __DIR__ . '/../config/config.php';
        return getDatabaseConnection();
    }
}
