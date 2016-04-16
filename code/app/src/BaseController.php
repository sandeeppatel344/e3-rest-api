<?php

namespace App;

class BaseController
{
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

	protected function checkToken($tokens, $userId, $db, $expiry, $refresh, $logger = null, $service = null)
	{
		$token = $tokens[0];
		$tokenExpiration = date('Y-m-d H:i:s', strtotime('+'.$expiry.' hour'));
		$tokenRefresh = date('Y-m-d H:i:s', strtotime('+'.$refresh.' hour'));
		try
		{
            if (($token == null || $token == '') && ($service != 'login')) {
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
				echo ($setExpire) ? 'True' : 'False';
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
}