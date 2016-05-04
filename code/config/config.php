<?php
return [
	'settings' => [
		/**
		 * Slim Settings
		 */
		'determineRouteBeforeAppMiddleware' => false,
		'displayErrorDetails' => true,
		/**
		 * View settings
		 */
		'view' => [
			'template_path' => __DIR__ . '/../templates',
			'twig' => [
				'cache' => __DIR__ . '/../cache/twig',
				'debug' => true,
				'auto_reload' => true,
			],
		],
		/**
		 * monolog settings
		 */
		'logger' => [
			'name' => 'app',
			'path' => __DIR__ . '/../logs/app'.date('d_m_Y').'.log',
		],
		/**
		 * Database settings
		 */
		'db' => [
			'host' => 'localhost',
			'user' => 'root',
			'pass' => '',
			'dbname' => 'e3erp',
		],
		/**
		 * Application settings
		 */
		'appsets' => [
			'tokenExpiry' 	=> 8,
			'tokenRefresh' 	=> 7,
			'otpNumOnly' 	=> true,
			'otpNumChar' 	=> 6,
			'otpValidMin'	=> 10,
			'smsUrl'		=> 'http://sms.itwebservices.in/API/WebSMS/Http/v1.0a/index.php?reqid=1&format=json&unique=0',
			'smsUser'		=> 'EANDG',
			'smsPass'		=> 'ashwinidhuppe',
			'smsRoute'		=> 2,
			'smsSendId'		=> '8039',
			'smsCallBack'	=> ''
		],
	],
];