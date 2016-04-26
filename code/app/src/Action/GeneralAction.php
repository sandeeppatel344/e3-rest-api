<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

/**
 * Class to return the master list of the following:
 *  1. Turnover
 *  2. Occupation
 * @author Mohan Cheema <mohan@cigno-it.com>
 * @version 1.0
 * @package App
 * @subpackage App\Action
 */
class GeneralAction extends \App\BaseController
{
	public $logger;
	private $dbConn;
	private $settings;
	private $userToken;
	private $userId;

	public function __construct($logger, $pdo, $settings)
	{
		$this->logger = $logger;
		$this->dbConn = $pdo;
		$this->settings = $settings;
	}

	/**
	 * Function invoker function
	 * Based to request from application appropriate function is called
	 * @param class $request HTTP Service request interface
	 * @param class $respone HTTP Response interface
	 * @param array $args
	 * @return json JSON response back to requesting application.
	 */
	public function __invoke(Request $request, Response $response, $args)
	{
		/*var_dump($args);
		exit;*/
		$rqHead = $request->getHeaders();
		$this->userToken = isset($rqHead['HTTP_E3_TOKEN']) ? $rqHead['HTTP_E3_TOKEN'] : false;

		$useIdChk = $this->verifyToken($this->userToken, $this->dbConn, $this->settings);
		$this->userId = $this->getUserId($this->userToken, $this->dbConn);

		if (isset($this->userId))
		{
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
				return $response->withStatus($retData['code'])->withHeader('Access-Control-Allow-Origin', '*')->withHeader('Content-Type', 'application/json')->write(json_encode($retData['data']));
			}
			else
			{
				return $response->withStatus($retData['code'])->withHeader('Access-Control-Allow-Origin', '*');
			}
		}
		else
		{
			return $response->withStatus($useIdChk['code'])->withHeader('Access-Control-Allow-Origin', '*')->withHeader('Content-Type', 'application/json')->write(json_encode($useIdChk['data']));
		}
	}

	/**
	 * Function to return business turnover list
	 * @return array
	 */
	private function turnover()
	{
		try
		{
			$userStmt = $this->dbConn->select()->from('business_turnover');
			$stmtExec = $userStmt->execute();
			$dataFetched = $stmtExec->fetchAll();
			return array("code" => 200, "data" => $dataFetched);
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
	}

	/**
	 * Function to return occupation list
	 * @return array
	 */
	private function occupation()
	{
		try
		{
			$userStmt = $this->dbConn->select()->from('occupation');
			$stmtExec = $userStmt->execute();
			$dataFetched = $stmtExec->fetchAll();
			return array("code" => 200, "data" => $dataFetched);
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
	}
}