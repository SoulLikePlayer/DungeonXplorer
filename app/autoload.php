<?php

spl_autoload_register(function ($class) {
    $directories = array(
        'app/models/',
        'app/controllers/',
        'app/core/'
    );

    foreach ($directories as $directory) {
        $filePath = $directory . $class . '.php';
        if (file_exists($filePath)) {
            require_once $filePath;
            return;
        }
    }
});

