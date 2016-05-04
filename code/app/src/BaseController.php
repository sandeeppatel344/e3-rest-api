<?php
namespace App;

/**
 * This is a base which is extended by other Action calsses.
 * @author Mohan Cheema <mohan@cigno-it.com>
 * @version 1.0
 * @package App
 */
class BaseController
{
	/**
	 *
	 */
	public function sendotp($conf, $data)
	{
		date_default_timezone_set('Asia/Kolkata');
		$message = $data['otp']." is your verification code to reset your password. Otp is valid only for 10 mins.";
		$recipient = isset($data['recipient']) ? $data['recipient'] : '09820547560';
		$callBack = isset($conf['smsCallBack']) ? $conf['smsCallBack'] : "";

		$url = $conf['smsUrl']."&username=".$conf['smsUser']."&password=".$conf['smsPass']."&sender=".$conf['smsSendId']."&route=".$conf['smsRoute']."&message=".str_replace(" ", "+", $message)."&to=".$recipient."&sendondate=".date('d-m-Y\TH:i:s')."&callback=".$callBack;
		/*echo $url;
		exit;*/
		try
		{
			$data = $this->callurl($url);
		}
		catch (\Exception $e)
		{
			// $data = array("error", $e->getMessage());
			throw new \Exception($e->getMessage());
		}
		return $data;
	}

	protected function isJson($string)
	{
		return is_string($string) && is_array(json_decode($string, true)) && (json_last_error() == JSON_ERROR_NONE) ? true : false;
	}

	protected function callurl($url)
	{
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER, 0);            // No header in the result
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // Return, do not echo result

		// Fetch and return content, save it.
		$raw_data = curl_exec($ch);
		if (curl_errno($ch))
		{
			curl_close($ch);

			throw new \Exception(curl_error($ch));
		}
		else
		{
			curl_close($ch);
			if ($this->isJson($raw_data))
			{
				$data = json_decode($raw_data);
				return $data;
			}
			else
			{
				throw new \Exception(trim($raw_data));
			}
		}
	}

	/**
	 * Generate Token protected function
	 * @param integer $userId to store token against in DB
	 * @param class $db to connect to database
	 * @param integer $expiry token expiry time
	 * @param ineteger $refresh token time extention
	 * @return array $tokenData consisting of token expiry time and refresh time
	 */
	protected function generateToken($userId, $db, $expiry, $refresh)
	{
		try
		{
			$token = bin2hex(openssl_random_pseudo_bytes(16)); //generate a random token
			$tokenExpiration = date('Y-m-d H:i:s', strtotime('+'.$expiry.' hour'));
			$tokenRefresh = date('Y-m-d H:i:s', strtotime('+'.$refresh.' hour'));
			$this->insertUpdateToken($db, $userId, 'insert', array($token, $tokenExpiration, $tokenRefresh));
			return array($token, $tokenExpiration, $tokenRefresh);
		}
		catch (\Exception $e)
		{
			throw new \Exception("Error generating token", 1);
		}
	}

	/**
	 * Check token protected function
	 * This checks the token supplied by the application is still valid or not.
	 * If valid continue with the request. Else throw an error.
	 * @param array $tokens contain token to be checked for validation
	 * @param integer $userId ID of the user
	 * @param class $db to connect to database
	 * @param integer $expiry token expiry time
	 * @param ineteger $refresh token time extention
	 * @return array $tokenData consisting of token expiry time and refresh time
	 */
	protected function checkToken($tokens, $userId, $db, $expiry, $refresh, $logger = null, $service = null)
	{
		$token = $tokens[0];
		$tokenExpiration = date('Y-m-d H:i:s', strtotime('+'.$expiry.' hour'));
		$tokenRefresh = date('Y-m-d H:i:s', strtotime('+'.$refresh.' hour'));

		if (!is_null($userId))
		{
			try
			{
	            if (($token == null || $token == '') && ($service != 'login' && $service != null))
				{
	                throw new \Exception("User not authenticated");
	            }
				$stmt = $db->select()->from('token')->where('token', '=', $token)->whereMany(array('user_id'=>$userId, 'token'=>$token), '=');
				$stmtExec = $stmt->execute();
				$dataFetched = $stmtExec->fetchAll();

				if (sizeof($dataFetched) > 0)
				{
					if (!is_null($logger))
					{
						$this->logger->info(strtotime($dataFetched[0]['expired_by'])." => ".time());
						$this->logger->info((strtotime($dataFetched[0]['expired_by']) > time()) ? 'True' : 'False');
						$this->logger->info((strtotime($dataFetched[0]['refresh_by']) > time()) ? 'True' : 'False');
					}
					if ((strtotime($dataFetched[0]['expired_by']) > time()) && (strtotime($dataFetched[0]['refresh_by']) > time()))
					{
						try
						{
							if ($this->insertUpdateToken($db, $userId, 'update', array($tokenExpiration, $tokenRefresh), $token, false))
							{
								// return true;
								return array($token, $tokenExpiration, $tokenRefresh);
							}
							else
							{
								throw new \Exception("Session Expired", 4);
							}
						}
						catch (\PDOException $e)
						{
							throw new \Exception("DB Error ocured.", 5);
						}
					}
					else
					{
						$this->insertUpdateToken($db, $userId, 'update', false, $token, true);
						throw new \Exception("Session Expired", 4);
					}
				}
				else
				{
					return $this->generateToken($userId, $db, $expiry, $refresh);
				}
			}
			catch (\Exception $e)
			{
				throw new \Exception("Error verifying token.", 2);
			}
		}
		else
		{
			// echo "Else";
			throw new \Exception("Error occured.", 2);
		}
	}

	/**
	 * insertUpdateToken protected function
	 * This will make an entry in token database if not exist or new token is generated.
	 * If token has expired updated the active to N. If token is with in refresh time limit extends the expiry time.
	 * @param class $db to connect to database
	 * @param integer $userId ID of the user
	 * @param string $token contain token to be updated else bool false
	 * @param string $prevToken previous token to be expired
	 * @param boolean $setExpire true or false
	 * @return boolean true or false
	 */
	protected function insertUpdateToken($db, $userId, $action = 'insert', $token = false, $prevToken = null, $setExpire = false)
	{
		$affRow;
		if ($action == "insert")
		{
			try
			{
				$stmtIns = $db->insert(array('token','expired_by','refresh_by','isactive','user_id','role_id'))->into('token')
				->values(array($token[0], $token[1], $token[2], 'Y', $userId, 1));
				$insId = $stmtIns->execute();
			}
			catch (\Exception $e)
			{
				throw new \Exception("Error Processing Request.".$e->getMessage(), 8);
			}

			if ($insId == "")
			{
				$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "User login failed.", "errors" => array("Error"));
				throw new \Exception("Token generation error.", 3);
			}
			else
			{
				return true;
			}
		}
		else
		{
			if (!is_null($prevToken) && $setExpire)
			{
				try
				{
					$expStmt = $db->update(array('isactive' => 'N'))->table('token')->whereMany(array('token'=> $prevToken, 'user_id' => $userId), '=');
					$affRow = $expStmt->execute();
				}
				catch (\Exception $e)
				{
					throw new \Exception("Error Processing Request. ".$e->getMessage(), 6);
				}
			}
			else if (!is_null($prevToken) && !$setExpire)
			{
				try
				{
					$stmtUp = $db->update(array('expired_by' => $token[0], "refresh_by" => $token[1]))->table('token')->whereMany(array('token'=> $prevToken, 'user_id' => $userId), '=');
					$affRow = $stmtUp->execute();
				}
				catch (\Exception $e)
				{
					throw new \Exception("Error Processing Request. ".$e->getMessage(), 7);
				}
			}
			if ($affRow == 0)
			{
				$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "User login failed.", "errors" => array('Error'));
				throw new \Exception("Token generation error", 3);
			}
			else
			{
				return true;
			}
		}
	}

	/**
	 * Based on token get the user id from the database
	 * @param string $token token for which user id to be fecthed
	 * @param class $db to connect to database
	 * @return integer $userId.
	 */
	protected function getUserId($token, $db)
	{
		$stmt = $db->select()->from('token')->where('token', '=', $token[0]);
		$stmtExec = $stmt->execute();
		$dataFetched = $stmtExec->fetch();

		return isset($dataFetched['user_id']) ? $dataFetched['user_id'] : null;
	}

	/**
	 * Function generate random otp number
	 * @param boolean $onlyNum true or for number only OTP
	 * @param integer $numChar number of charachters for OTP
	 * @return $otpSend OTP number to be sent
	 */
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

	protected function verifyToken($token, $db, $settings)
	{
		try
		{
				$gToken = $this->checkToken($token, $this->getUserId($token, $db), $db, $settings['appsets']['tokenExpiry'], $settings['appsets']['tokenRefresh'], $this->logger, 'login');
		}
		catch (\Exception $e)
		{
			$retMessage = array("Code" => "SERVICE_ERROR", "message" => "Invalid token supplied...", "errors" => array($e->getMessage()));
				return array("code" => 401, "data" => $retMessage);
		}
	}
}