<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class UserAction extends \App\BaseController
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
			return $response->withStatus($retData['code'])->withHeader('Access-Control-Allow-Origin', '*')->withHeader('Content-Type', 'application/json')->write(json_encode($retData['data']));
		}
		else
		{
			return $response->withStatus($retData['code'])->withHeader('Access-Control-Allow-Origin', '*');
		}
	}

	private function login($data = array())
	{
		$roleId = array();
		$roleName = array();
		$personDetail = array();
		$dataSend = array();
		try
		{
			$this->logger->info("Testing");
			$stmt = $this->dbConn->select(array('id','isactive'))->from('user')->where('username', '=', $data['login'])->where('password', '=', $data['password']);
			$stmtExec = $stmt->execute();
			$dataFetched = $stmtExec->fetch();

			if (strtoupper($dataFetched['isactive']) == 'Y')
			{
				$stmt1 = $this->dbConn->select(array('role_id'))->from('batch_user')->where('user_id', '=', $dataFetched['id']);
				$stmt1Exec = $stmt1->execute();
				$dataFetched1 = $stmt1Exec->fetchAll();
				for ($i=0; $i < sizeof($dataFetched1); $i++)
				{
					array_push($roleId, $dataFetched1[$i]['role_id']);
				}

				$stmt2 = $this->dbConn->select(array('name'))->from('role')->whereIn('id', $roleId);
				$stmt2Exec = $stmt2->execute();
				$dataFetched2 = $stmt2Exec->fetchAll();
				for ($j=0; $j < sizeof($dataFetched2); $j++)
				{
					array_push($roleName, $dataFetched2[$j]['name']);
				}

				$stmt3 = $this->dbConn->select(array('first_name', 'last_name', 'gender'))->from('person')->where('user_id', '=', $dataFetched['id']);
				$stmt3Exec = $stmt3->execute();
				$dataFetched3 = $stmt3Exec->fetch();
				array_push($personDetail, array('name' => $dataFetched3['first_name'], 'gender' => $dataFetched3['gender']));

				if (sizeof($dataFetched) > 1)
				{
					try
					{
						$gToken = $this->checkToken($this->userToken, $dataFetched['id'], $this->dbConn, $this->settings['appsets']['tokenExpiry'], $this->settings['appsets']['tokenRefresh'], $this->logger);

						$dataSend['token'] = $gToken[0];
						$dataSend['role'] = $roleName;
						$dataSend['personProfile'] = $personDetail;

						return array("code" => 200, "data" => array('authentication' => $dataSend));
					}
					catch (\Exception $e)
					{
						$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "User login failed.", "errors" => array($e->getMessage()));
						return array("code" => 422, "data" => $retMessage);
					}
				}
				else
				{
					$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "User login failed.", "errors" => array('User not found / Invalid username and password'));
					return array("code" => 422, "data" => $retMessage);
				}
			}
			else
			{
				$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "User not active.", "errors" => array('User not found / Invalid username and password'));
				return array("code" => 422, "data" => $retMessage);
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "User login failed.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "User login failed. ", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
	}

	private function generateOTP($data = array())
	{
		try
		{
			if (isset($data['username']))
			{
				$stmt = $this->dbConn->select()->from('user')->where('username', '=', $data['username']);
				$stmtExec = $stmt->execute();
				$dataFetched = $stmtExec->fetchAll();
				if (sizeof($dataFetched) == 1)
				{
					$otp = $this->randomString($this->settings['appsets']['otpNumOnly'], $this->settings['appsets']['otpNumChar']);
					$updateStmt = $this->dbConn->update(array('password' => $otp))->table('user')->where('id', '=', $dataFetched[0]['id']);
					$affectRow = $updateStmt->execute();
					if ($affectRow == 1)
					{
						return array("code" => 200, "data" => array('code' => 'success', 'message' => $otp));
					}
				}
				else
				{
					$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array('Username not found/Multiple User(s) found'));
					return array("code" => 422, "data" => $retMessage);
				}
			}
			else
			{
				$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array('Username not sent'));
				return array("code" => 422, "data" => $retMessage);
			}
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

	private function password($data = array())
	{
		try
		{
			if (isset($data['username']) && isset($data['otp']) && isset($data['new_password']))
			{
				$stmt = $this->dbConn->select()->from('user')->whereMany(array('username'=> $data['username'], 'password' => $data['otp']), '=');
				$stmtExec = $stmt->execute();
				$dataFetched = $stmtExec->fetchAll();
				if (sizeof($dataFetched) == 1)
				{
					$updateStmt = $this->dbConn->update(array('password' => $data['new_password']))->table('user')->whereMany(array('id' => $dataFetched[0]['id'], 'username' => $data['username']), '=');
					$affectRow = $updateStmt->execute();
					if ($affectRow == 1)
					{
						return array("code" => 200);
					}
				}
				else
				{
					$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array('Username not found/Multiple User(s) found'));
					return array("code" => 422, "data" => $retMessage);
				}
			}
			elseif (isset($data['current_password']) && isset($data['new_password']))
			{
				try
				{
					$userStmt = $this->dbConn->select()->from('token')->where('token', '=', $this->userToken[0]);
					$stmtExec = $userStmt->execute();
					$dataFetched = $stmtExec->fetch();
					$updateStmt = $this->dbConn->update(array('password' => $data['new_password']))->table('user')->whereMany(array('id' => $dataFetched['user_id'], 'password' => $data['current_password']), '=');
					$affectRow = $updateStmt->execute();
					if ($affectRow == 1)
					{
						return array("code" => 200);
					}
				}
				catch (\Exception $e)
				{
					throw new \Exception("Error Processing Request".$e->getMessage(), 1);
				}
			}
			else
			{
				$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors" => array('Username not sent'));
				return array("code" => 422, "data" => $retMessage);
			}
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

	protected function randomString($onlyNum = false, $numChar = 4)
	{
		$string['smAlpha'] = 'abcdefghijklmnopqrstuvwxyz';
		$string['lrAlpha'] = 'ABCDEFGHIJKLMNOPQRTSUVWXYZ';
		$string['numbers'] = '1234567890';
		if (!$onlyNum)
		{
			$finalString = $string['smAlpha']."".$string['numbers']."".$string['lrAlpha'];
		}
		else
		{
			$finalString = $string['numbers'];
		}
		$string_shuffled = str_shuffle($finalString);
		$otpSend = substr($string_shuffled, 1, $numChar);

		return $otpSend;
	}

	private function course($data = array())
	{
		try
		{
			$userStmt = $this->dbConn->select()->from('token')->where('token', '=', $this->userToken[0]);
			$stmtExec = $userStmt->execute();
			$dataFetched = $stmtExec->fetch();
			try
			{
				$tokenCheck = $this->checkToken($this->userToken, $dataFetched['user_id'], $this->dbConn, $this->settings['appsets']['tokenExpiry'], $this->settings['appsets']['tokenRefresh'], $this->logger);
				if (is_array($tokenCheck) && $tokenCheck[0] == $dataFetched['token'])
				{
					$courseStmt = $this->dbConn->select(array('batch.center_course_id AS course_id', 'batch.name AS batch_name', 'batch.status AS batch_status',
						'batch.start_date AS batch_start_date', 'batch.end_date AS batch_end_date', 'course.name AS course_name', 'batch_user.batch_id AS batch_id', 'batch_user.user_id AS user_id', 'center_course.id AS center_id', 'center.name AS center_name'))->from('batch_user')->join('batch', 'batch_user.batch_id', '=', 'batch.id')->join('center_course', 'batch.center_course_id', '=', 'center_course.id')->join('center', 'center_course.center_id', '=', 'center.id')->join('course', 'center_course.course_id', '=', 'course.id')->where('batch_user.user_id', '=', $dataFetched['user_id']);
					$courseStmtExec = $courseStmt->execute();
					$courseData = $courseStmtExec->fetchAll();
					if (sizeof($courseData) > 0)
					{
						return array("code" => 200, "data" => $courseData);
					}
					else
					{
						return array("code" => 200, "data" => array());
					}
				}
				else
				{
					throw new \Exception("Error Processing Request", 1);
				}
			}
			catch (\Exception $e)
			{
				throw new \Exception($e->getMessage(), 1);
			}
			var_dump($tokenCheck);
			exit;
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied.", "errors" => $e->getMessage());
			return array("code" => 401, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied.", "errors" => $e->getMessage());
			return array("code" => 401, "data" => $retMessage);
		}
	}
}