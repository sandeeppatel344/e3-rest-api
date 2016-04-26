<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

/**
 * User Class
 * This class is responssible for all User related data to be returned to the requesting application
 * @author Mohan Cheema <mohan@cigno-it.com>
 * @version 1.0
 * @package App
 * @subpackage App\Action
 */
class UserAction extends \App\BaseController
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

		if ($args['action'] != 'login' && $args['action'] != 'otp' && $args['param1'] != 'forgot')
		{
			$useIdChk = $this->verifyToken($this->userToken, $this->dbConn, $this->settings);
			$this->userId = $this->getUserId($this->userToken, $this->dbConn);

			if (isset($this->userId))
			{
				$dataRec = file_get_contents('php://input');
				$this->logger->info("Batch action dispatched ".implode(', ', $args));
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
		else
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
	}

	/**
	 * Function to login user to application
	 * @param array $data username and password
	 * @return array $data
	 */
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
						$gToken = $this->checkToken($this->userToken, $dataFetched['id'], $this->dbConn, $this->settings['appsets']['tokenExpiry'], $this->settings['appsets']['tokenRefresh'], $this->logger, 'login');

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

	/**
	 * Function to generate OTP
	 * @param array $data username
	 * @return array $data
	 */
	private function generateOtp($data = array())
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
					/*$updateStmt = $this->dbConn->update(array('password' => $otp))->table('user')->where('id', '=', $dataFetched[0]['id']);
					$affectRow = $updateStmt->execute();*/
					$stmt = $this->dbConn->insert(array('username', 'otp', 'created_datetime', 'expire_on', 'active'))->into('forgot_password_otp')->values(array($data['username'], $otp, date('Y-m-d H:i:s'), date('Y-m-d H:i:s', strtotime(date('Y-m-d H:i:s')) +60*60), 'Y'));
					$insId = $stmt->execute();
					if ($insId > 1)
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

	/**
	 * Function to reset password
	 * @param array $data username, otp and new password
	 */
	private function forgotPassword($data = array())
	{
		try
		{
			$stmtOtp = $this->dbConn->select()->from('forgot_password_otp')->whereMany(array('username' => $data['username'], 'otp' => $data['otp'], 'active' => 'Y'), '=')->where('expire_on', '<=', date('Y-m-d H:i:s'));
			$stmtOtpExec = $stmtOtp->execute();
			$stmtOtpData = $stmtOtpExec->fetch();

			if (sizeof('stmtOtpData') > 0)
			{
				$updateStmt = $this->dbConn->update(array('password' => $data['new_password']))->table('user')->whereMany(array('username' => $data['username']), '=');
				$affectRow = $updateStmt->execute();
				if ($affectRow == 1)
				{
					$otpUp = $this->dbConn->update(array('active' => 'N'))->table('forgot_password_otp')->whereMany(array('username' => $data['username'], 'otp' => $data['otp'], 'active' => 'Y'), '=');
					$otpAffR = $otpUp->execute();
					return array("code" => 200);
				}
				else
				{
					$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors111" => array('Username not found/Multiple User(s) found'));
					return array("code" => 422, "data" => $retMessage);
				}
			}
			else
			{
				$retMessage = array("Code" => "SERVICE_ERROR", "message" => "OTP Expired.", "errors" => array('OTP Expired please generate new.'));
				return array("code" => 422, "data" => $retMessage);
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors1" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Invalid User.", "errors11" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
	}

	/**
	 * Function to reset user password
	 * @param array $data current password and new password
	 * @return array $data
	 */
	private function password($data = array())
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
	 * Function to get user course list
	 * @param array $data username and password
	 * @return array $data
	 */
	private function course($data = array())
	{
		try
		{
			$courseStmt = $this->dbConn->select(array('batch.center_course_id AS course_id', 'batch.name AS batch_name', 'batch.status AS batch_status',
				'batch.start_date AS batch_start_date', 'batch.end_date AS batch_end_date', 'course.name AS course_name', 'batch_user.batch_id AS batch_id', 'batch_user.user_id AS user_id', 'center_course.id AS center_id', 'center.name AS center_name'))->from('batch_user')->join('batch', 'batch_user.batch_id', '=', 'batch.id')->join('center_course', 'batch.center_course_id', '=', 'center_course.id')->join('center', 'center_course.center_id', '=', 'center.id')->join('course', 'center_course.course_id', '=', 'course.id')->where('batch_user.user_id', '=', $this->userId);
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

	/**
	 * Function to update / insert the assignment status
	 * @param array $data username and password
	 * @return array $data
	 */
	private function assignment($data = array())
	{
		try
		{
			$stmtBaUsId = $this->dbConn->select(array('id'))->from('batch_user')->where('user_id', '=', $this->userId);
			$stmtBaUsIdExec = $stmtBaUsId->execute();
			$dataBaUsIdFetched = $stmtBaUsIdExec->fetch();

			if (!is_null($data['prev_status_id']))
			{
				$stmt = $this->dbConn->update(array('assignment_status_id' => $data['status_id'], 'user_comment' => $data['user_comment']))->table('user_assignment_status')->whereMany(array('assignment_id' => $data['assignment_id'], 'batch_user_id' => $dataBaUsIdFetched['id'], 'assignment_status_id' => $data['prev_status_id']), '=');
				$stmtAffRow = $stmt->execute();
			}
			else
			{
				$stmt = $this->dbConn->insert(array('assignment_id','batch_user_id','assignment_status_id','user_comment'))->into('user_assignment_status')->values(array($data['assignment_id'], $dataBaUsIdFetched['id'], $data['status_id'], $data['user_comment']));
				$insId = $stmt->execute();
			}
			if ($stmtAffRow == 1 || (is_numeric($insId) && $insId > 0) )
			{
				return array("code" => 200);
			}
			else
			{
				$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Function not allowed.", "errors" => null);
				return array("code" => 403, "data" => $retMessage);
			}
		}
		catch (\PDOException $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "DB Error.", "errors" => array($e->getMessage()));
			return array("code" => 422, "data" => $retMessage);
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied.", "errors" => null);
			return array("code" => 401, "data" => $retMessage);
		}
	}
}