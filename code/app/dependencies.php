<?php
/**
 * DIC configuration
 */
$container = $app->getContainer();
/**
 * Service providers
 */

/**
 * Twig
 */
$container['view'] = function ($c) {
	$settings = $c->get('settings');
	$view = new Slim\Views\Twig($settings['view']['template_path'], $settings['view']['twig']);
	// Add extensions
	$view->addExtension(new Slim\Views\TwigExtension($c->get('router'), $c->get('request')->getUri()));
	$view->addExtension(new Twig_Extension_Debug());
	return $view;
};

/**
 * Flash messages
 */
$container['flash'] = function ($c) {
	return new Slim\Flash\Messages;
};

/**
 * Service factories
 */
/**
 * monolog Log Factory
 */
$container['logger'] = function ($c) {
	$settings = $c->get('settings');
	$logger = new Monolog\Logger($settings['logger']['name']);
	$logger->pushProcessor(new Monolog\Processor\UidProcessor());
	$logger->pushHandler(new Monolog\Handler\StreamHandler($settings['logger']['path'], Monolog\Logger::DEBUG));
	return $logger;
};

/**
 * Database Factory
 */
$container['db'] = function ($c) {
	$settings = $c->get('settings');
	$dsn = 'mysql:host='.$settings['db']['host'].';dbname='.$settings['db']['dbname'].';charset=utf8';
	$pdo = new Slim\PDO\Database($dsn, $settings['db']['user'], $settings['db']['pass']);
	return $pdo;
};

/**
 * Action factories
 */
$container[App\Action\HomeAction::class] = function ($c) {
	return new App\Action\HomeAction($c->get('view'), $c->get('logger'));
	// return new App\Action\HomeAction($c->get('logger'));
};

$container[App\Action\UserAction::class] = function ($c) {
	return new App\Action\UserAction($c->get('logger'), $c->get('db'), $c->get('settings'));
};

$container[App\Action\BatchAction::class] = function ($c) {
	return new App\Action\BatchAction($c->get('logger'), $c->get('db'), $c->get('settings'));
};

$container[App\Action\SessionAction::class] = function ($c) {
	return new App\Action\SessionAction($c->get('logger'), $c->get('db'), $c->get('settings'));
};

$container[App\Action\ProfileAction::class] = function ($c) {
	return new App\Action\ProfileAction($c->get('logger'), $c->get('db'), $c->get('settings'));
};

$container[App\Action\CountryAction::class] = function ($c) {
	return new App\Action\CountryAction($c->get('logger'), $c->get('db'), $c->get('settings'));
};

$container[App\Action\GeneralAction::class] = function ($c) {
	return new App\Action\GeneralAction($c->get('logger'), $c->get('db'), $c->get('settings'));
};