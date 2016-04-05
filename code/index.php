<?php


require __DIR__ . '/vendor/autoload.php';

/**
* Require config file
* @return Array config values
*/
$settings = require __DIR__ . '/config/config.php';

/**
* Create an instance of Slim with custom view
* and set the configurations from config file
*/
//$app = new Slim\Slim(array('mode' => 'development'));
$app = new Slim\App($settings);


require __DIR__ . '/app/dependencies.php';
require __DIR__ . '/app/routes.php';

$app->run();
