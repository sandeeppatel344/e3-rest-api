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

		return $response->withStatus($retData['code'])->withHeader('Content-Type', 'application/json')->write(json_encode($retData['data']));
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
					$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array('Username not found/Multiple user found'));
					return array("code" => 422, "data" => $retMessage);
				}
			}
			else
			{
				$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array('Username not sent'));
				return array("code" => 422, "data" => $retMessage);
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
	}

	private function password($data = array())
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
					$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array('Username not found/Multiple user found'));
					return array("code" => 422, "data" => $retMessage);
				}
			}
			else
			{
				$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array('Username not sent'));
				return array("code" => 422, "data" => $retMessage);
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR".$otp, "message" => "Invalid User.", "errors" => array($e->getMessage()));
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
}