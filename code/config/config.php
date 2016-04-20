<?php
return [
	'settings' => [
		// Slim Settings
		'determineRouteBeforeAppMiddleware' => false,
		'displayErrorDetails' => true,
		// View settings
		'view' => [
			'template_path' => __DIR__ . '/../templates',
			'twig' => [
				'cache' => __DIR__ . '/../cache/twig',
				'debug' => true,
				'auto_reload' => true,
			],
		],
		// monolog settings
		'logger' => [
			'name' => 'app',
			'path' => __DIR__ . '/../logs/app.log',
		],
		'db' => [
			'host' => 'localhost',
			'user' => 'root',
			'pass' => '',
			'dbname' => 'e3erp',
		],
		'appsets' => [
			'tokenExpiry' => 8,
			'tokenRefresh' => 7,
			'otpNumOnly' => true,
			'otpNumChar' => 6,
		],
	],
];