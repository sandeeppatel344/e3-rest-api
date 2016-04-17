<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class SessionAction extends \App\BaseController
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

	public function __invoke(Request $request, Response $response, $args)
	{
		$rqHead = $request->getHeaders();
		$this->userToken = isset($rqHead['HTTP_E3_TOKEN']) ? $rqHead['HTTP_E3_TOKEN'] : false;

		$useIdChk = $this->verifyToken($this->userToken, $this->dbConn, $this->settings);
		$this->userId = $this->getUserId($this->userToken, $this->dbConn);

		if (isset($this->userId)) {
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
			} else {
				return $response->withStatus($useIdChk['code'])->withHeader('Access-Control-Allow-Origin', '*')->withHeader('Content-Type', 'application/json')->write(json_encode($useIdChk['data']));
			}
	}

	private function assignment($data = null)
	{
		if (!is_null($data)) {
			try {
				$stmt = $this->dbConn->select(array('session_assignment.name', 'Concat(person.first_name, " ", person.last_name) As approved_by', 'user_assignment_status.assignment_status_id', 'session_assignment.id', 'user_assignment_status.user_comment', 'user_assignment_status.approver_comment'))->from('session_assignment')->join('user_assignment_status', 'user_assignment_status.assignment_id', '=', 'session_assignment.id')->join('batch_user', 'user_assignment_status.batch_user_id', '=', 'batch_user.id')->join('user', 'batch_user.user_id', '=', 'user.id')->join('person', 'person.user_id', '=', 'user.id')->where('session_assignment.session_id', '=', $data)->where('user.id', '=', $this->userId);
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

	private function media($data = null)
	{
		if (!is_null($data)) {
			try {
				$stmt = $this->dbConn->select(array('url', 'type'))->from('session_media')->where('session_id', '=', $data);
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

	private function distinction($data = null)
	{
		if (!is_null($data)) {
			try {
				$stmt = $this->dbConn->select(array('name', 'description'))->from('session_distinction')->where('session_id', '=', $data);
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
}