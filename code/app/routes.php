<?php
// Routes
$app->get('/', App\Action\HomeAction::class)->setName('homepage');
$app->get('/user/course', App\Action\UserAction::class);
$app->map(['POST', 'PUT'], '/user/{action}', App\Action\UserAction::class);
$app->post('/user/{action}/{param1}', App\Action\UserAction::class);
$app->get('/batch/{id}/{action}', App\Action\BatchAction::class);
$app->get('/session/{id}/{action}', App\Action\SessionAction::class);