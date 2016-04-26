<?php
/**
 * List of valid Routes
 */
$app->get('/', App\Action\HomeAction::class)->setName('homepage');
$app->get('/country', App\Action\CountryAction::class);
$app->get('/country/{id}/{action}', App\Action\CountryAction::class);
$app->get('/country/{id}/{action}/{sid}/{action2}', App\Action\CountryAction::class);
$app->get('/country/{id}/{action}/{sid}/{action2}/{did}/{action3}', App\Action\CountryAction::class);
$app->get('/user/{action}', App\Action\UserAction::class);
$app->post('/user/{action}', App\Action\UserAction::class);
$app->post('/user/{action}/{param1}', App\Action\UserAction::class);
$app->get('/batch/{id}/{action}', App\Action\BatchAction::class);
$app->get('/batch/{id}/{action}/{param1}', App\Action\BatchAction::class);
$app->get('/session/{id}/{action}', App\Action\SessionAction::class);
$app->map(['POST', 'GET'], '/profile/{action}', App\Action\ProfileAction::class);
$app->get('/e3/{action}', App\Action\GeneralAction::class);