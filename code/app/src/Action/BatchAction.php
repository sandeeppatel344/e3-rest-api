<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class BatchAction extends \App\BaseController
{
    
	public $logger;
	private $dbConn;
	private $settings;
	private $userToken;

	public function __construct($logger, $pdo, $settings)
	{
		$this->logger = $logger;
		$this->dbConn = $pdo;
		$this->settings = $settings;
	}

	public function __invoke(Request $request, Response $response, $args)
	{
		$rqHead = $request->getHeaders();
		$this->userToken = isset($rqHead['HTTP_USER_TOKEN']) ? $rqHead['HTTP_USER_TOKEN'] : false;
		$dataRec = file_get_contents('php://input');
		$this->logger->info("User action dispatched");
		$data = json_decode($dataRec, true);
		if (!isset($args['param1']) || $args['param1'] == "")
		{
			$retData = $this->$args['action']($data);
		}
		else
		{
			$funcToCall = $args['param1']."".ucwords($args['action']);
			$retData = $this->$funcToCall($data);
		}

		if (isset($retData['data']))
		{
			return $response->withStatus($retData['code'])->withHeader('Content-Type', 'application/json')->write(json_encode($retData['data']));
		}
		else
		{
			return $response->withStatus($retData['code']);
		}
	}
}