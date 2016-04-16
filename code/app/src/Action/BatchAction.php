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
		$this->userToken = isset($rqHead['HTTP_E3_TOKEN']) ? $rqHead['HTTP_E3_TOKEN'] : false;
		$dataRec = file_get_contents('php://input');
		$this->logger->info("Batch action dispatched ".implode(', ',$args));
		$data = json_decode($dataRec, true);
		if (!isset($args['param1']) || $args['param1'] == "")
		{
			$retData = $this->$args['action']($args['id']);
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

	private function session($data = null)
	{
		try {
			$gToken = $this->checkToken($this->userToken, $dataFetched['id'], $this->dbConn, $this->settings['appsets']['tokenExpiry'], $this->settings['appsets']['tokenRefresh'], $this->logger, 'login');
			$stmt = $this->dbConn->select(array('session.id as id', 'session.name as name', 'session.date as date', 'session.start_time as start_time', 'session.end_time as end_time', 'session.venue as venue', 'session.isactive as is_active', 'session_attendance.is_present as is_attended'))->from('batch_user')->join('session_attendance', 'batch_user.id', '=', 'session_attendance.batch_user_id')->join('session', 'session_attendance.session_id', '=', 'session.id')->where('batch_user.id', '=', $data)->orderBy('session.date', 'ASC')->orderBy('session.start_time', 'ASC');
			$stmtExec = $stmt->execute();
			$dataFetched = $stmtExec->fetchAll();
			if (sizeof($dataFetched) > 0) {
				return array("code" => 200, "data" => $dataFetched);
			} else {
				return array("code" => 200, "data" => array());
			}
		} catch (\PDOException $e) {
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "DB failed.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		} catch (\Exception $e) {
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied...", "errors" => array($e->getMessage()));
			return array("code" => 401, "data" => $retMessage);
		}
	}
}