<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
/**
 * Class to return the master list of the following:
 *  1. Country
 *  2. States based on country ID
 *  3. Districts based on state ID
 *  4. City/Taluka based on District ID
 * @author Mohan Cheema <mohan@cigno-it.com>
 * @version 1.0
 * @package App
 * @subpackage App\Action
 */
class CountryAction extends \App\BaseController
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
		$rqHead = $request->getHeaders();
		$this->userToken = isset($rqHead['HTTP_E3_TOKEN']) ? $rqHead['HTTP_E3_TOKEN'] : false;

		$useIdChk = $this->verifyToken($this->userToken, $this->dbConn, $this->settings);
		$this->userId = $this->getUserId($this->userToken, $this->dbConn);

		if (isset($this->userId))
		{
			if (sizeof($args) <= 0)
			{
				$retData = $this->getCoutry();
			}
			else if (isset($args['action']) && !isset($args['action2']) && !isset($args['action3']))
			{
				$data = $args['id'];
				$funcToCall = "get".ucwords($args['action']);
				$retData = $this->$funcToCall($data);
			}
			else if (isset($args['action']) && isset($args['action2']) && !isset($args['action3']))
			{
				$data = $args['sid'];
				$funcToCall = "get".ucwords($args['action2']);
				$retData = $this->$funcToCall($data);
			}
			else
			{
				$data = $args['did'];
				$funcToCall = "get".ucwords($args['action3']);
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
	 * Function to return country
	 * @return array
	 */
	private function getCoutry()
	{
		$stmt = $this->dbConn->select(array('id','name', 'code'))->from('country');
		$stmtExec = $stmt->execute();
		$stmtFetched = $stmtExec->fetchAll();

		if (sizeof($stmtFetched) > 0)
		{
			return array("code" => 200, "data" => $stmtFetched);
		}
		else
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Profile loading failed.", "errors" => array('error occured'));
			return array("code" => 422, "data" => $retMessage);
		}
	}

	/**
	 * Function to return state
	 * @param country ID
	 * @return array
	 */
	private function getState($data = null)
	{
		$stmt = $this->dbConn->select(array('id','name', 'code'))->from('state')->where('country_id', '=', $data);
		$stmtExec = $stmt->execute();
		$stmtFetched = $stmtExec->fetchAll();
		if (sizeof($stmtFetched) > 0)
		{
			return array("code" => 200, "data" => $stmtFetched);
		}
		else
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Profile loading failed.", "errors" => array('error occured'));
			return array("code" => 422, "data" => $retMessage);
		}
	}

	/**
	 * Function to return districts
	 * @param state ID
	 * @return array
	 */
	private function getDistrict($data = null)
	{
		$stmt = $this->dbConn->select(array('id','name', 'code'))->from('district')->where('state_id', '=', $data);
		$stmtExec = $stmt->execute();
		$stmtFetched = $stmtExec->fetchAll();
		if (sizeof($stmtFetched) > 0)
		{
			return array("code" => 200, "data" => $stmtFetched);
		}
		else
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Profile loading failed.", "errors" => array('error occured'));
			return array("code" => 422, "data" => $retMessage);
		}
	}


	/**
	 * Function to return city
	 * @param district ID
	 * @return array
	 */
	private function getCity($data = null)
	{
		$stmt = $this->dbConn->select(array('id','name'))->from('city_taluka')->where('district_id', '=', $data);
		$stmtExec = $stmt->execute();
		$stmtFetched = $stmtExec->fetchAll();
		if (sizeof($stmtFetched) > 0)
		{
			return array("code" => 200, "data" => $stmtFetched);
		}
		else
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Profile loading failed.", "errors" => array('error occured'));
			return array("code" => 422, "data" => $retMessage);
		}
	}

}