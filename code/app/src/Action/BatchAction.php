<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

/**
 * Batch Class
 * This class is responssible for all batch related data to be returned to the requesting application
 * @author Mohan Cheema <mohan@cigno-it.com>
 * @version 1.0
 * @package App
 * @subpackage App\Action
 */
class BatchAction extends \App\BaseController
{

	public $logger;
	private $dbConn;
	private $settings;
	private $userToken;
	private $userId;

	/**
	 * Consturctor function
	 */
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
				$dataRec = file_get_contents('php://input');
				$this->logger->info("Batch action dispatched ".implode(', ', $args));
				$data = json_decode($dataRec, true);
			if (!isset($args['param1']) || $args['param1'] == "")
			{
				$funcToCall = $args['action'];
				$retData = $this->$funcToCall($args['id']);
			}
			else
				{
				$funcToCall = $args['param1']."".ucwords($args['action']);
				$retData = $this->$funcToCall($args['id']);
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
	 * Function to list the batch sessions
	 * @param $data batch id passed as URL argument
	 * @return array batch session data
	 */
	private function session($data = null)
	{
		try
		{
			$stmt = $this->dbConn->select(array('session.id as id', 'session.name as name', 'session.date as date', 'session.start_time as start_time', 'session.end_time as end_time', 'session.venue as venue', 'session.isactive as is_active', 'IFNULL((select is_present from session_attendance where batch_user_id = batch_user.id and session_attendance.session_id = session.id), "N") as is_attended'))->distinct()->from('session')->join('batch', 'session.batch_id', '=', 'batch.id')->join('batch_user', 'batch_user.batch_id', '=', 'batch.id')->whereMany(array('batch.id' => $data, 'batch_user.user_id' => $this->userId, 'batch.is_delete' => 'N'), '=')->orderBy('session.date', 'ASC')->orderBy('session.start_time', 'ASC');
			$stmtExec = $stmt->execute();
			$dataFetched = $stmtExec->fetchAll();
			if (sizeof($dataFetched) > 0)
			{
				return array("code" => 200, "data" => $dataFetched);
			}
			else
			{
				return array("code" => 200, "data" => array());
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "DB failed.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied...", "errors" => array($e->getMessage()));
			return array("code" => 401, "data" => $retMessage);
		}
	}

	/**
	 * Function to list the batch meetings
	 * @param $data batch id passed as URL argument
	 * @return array batch meeting data
	 */
	private function meeting($data = null)
	{
		try
		{
			$stmtExec = $stmt->execute();
			$dataFetched = $stmtExec->fetchAll();
			if (sizeof($dataFetched) > 0)
			{
				return array("code" => 200, "data" => $dataFetched);
			}
			else
			{
				return array("code" => 200, "data" => array());
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "DB failed.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied...", "errors" => array($e->getMessage()));
			return array("code" => 401, "data" => $retMessage);
		}
	}

	/**
	 * Function to list the batch group members
	 * @param $data batch id passed as URL argument
	 * @return array batch group members
	 */
	private function memberGroup($data = null)
	{
		try
		{
			$st=$this->dbConn->select(array("batch_groups_id"))->from('batch_user')->whereMany(array('user_id' => $this->userId, 'is_delete' => 'N'), '=')->execute()->fetch();
			$st['batch_groups_id'] = (!is_null($st['batch_groups_id'])) ? $st['batch_groups_id'] : "" ;

			$st2=$this->dbConn->select(array('user_id'))->from('batch_user')->whereMany(array('batch_groups_id' => $st['batch_groups_id'], 'is_delete' => 'N'), '=')->execute()->fetchAll();
			$gUser = array();

			for ($i=0; $i < sizeof($st2);$i++)
			{
				array_push($gUser, $st2[$i]['user_id']);
			}
			if (sizeof($gUser) > 0)
			{
				$stmt = $this->dbConn->select(array('Concat(person.first_name, " ", person.last_name) As name', 'person.mobile', 'person.email', 'city_taluka.name As city'))->from('user')->join('person', 'person.user_id', '=', 'user.id')->join('user_address_details', 'user_address_details.user_id', '=', 'user.id')->join('city_taluka', 'user_address_details.city_taluka_id', '=', 'city_taluka.id')->whereIn('user.id', $gUser);
				$stmtExec = $stmt->execute();
				$dataFetched = $stmtExec->fetchAll();
			}
			else
			{
				$dataFetched = array();
			}
			if (sizeof($dataFetched) > 0)
			{
				return array("code" => 200, "data" => $dataFetched);
			}
			else
			{
				return array("code" => 200, "data" => array());
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "DB failed.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied...", "errors" => array($e->getMessage()));
			return array("code" => 401, "data" => $retMessage);
		}
	}
}