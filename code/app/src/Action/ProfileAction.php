<?php

namespace App\Action;

use Psr\Log\LoggerInterface;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class ProfileAction extends \App\BaseController
{
	public $logger;

	private $dbConn;
	private $settings;
	private $userToken;
	private $userId;

	protected $spouse;
	protected $children;
	protected $userData;
	protected $address;
	protected $book;

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

	private function get()
	{
		$data=array();
		$stmt=$this->dbConn->select(array('person.*', 'user.username'))->from('person')->join('user', 'person.user_id', '=', 'user.id')->where('user.id', '=', $this->userId);
		$stmtExec = $stmt->execute();
		$stmtFetched = $stmtExec->fetch();
		$stmtFetched['address'] = $this->dbConn->select()->from('user_address_details')->where('user_id', '=', $this->userId)->execute()->fetch();
		$stmtFetched['spouse'] = array();
		$stmtFetched['children'] = array();

		$stmtFamily = $this->dbConn->select()->from('user_family_details')->where('user_id', '=', $this->userId);
		$stmtFExec = $stmtFamily->execute();
		$stmtFFetched = $stmtFExec->fetchAll();
		if (sizeof($stmtFFetched) > 0)
		{
			for ($i=0; $i < sizeof($stmtFFetched); $i++)
			{
				if (strtoupper($stmtFFetched[$i]['relation']) == 'SPOUSE')
				{
					array_push($stmtFetched['spouse'], $stmtFFetched[$i]);
				}
				else
				{
					array_push($stmtFetched['children'], $stmtFFetched[$i]);
				}
			}
		}
		// array_push($stmtFetched, $data);
		$stmtBook = $this->dbConn->select()->from('user_books')->where('user_id', '=', $this->userId);
		$stmtBExec = $stmtBook->execute();
		$stmtBFetched = $stmtBExec->fetchAll();
		$stmtFetched['books'] = $stmtBFetched;
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

	private function update($data)
	{
		$this->children = $data['children'];
		unset($data['children']);
		$this->spouse = $data['spouse'];
		unset($data['spouse']);
		$this->book = $data['books'];
		unset($data['books']);
		$this->address = $data['address'];
		unset($data['address']);
		unset($data['username']);
		$this->userData = $data;
		if ($this->updateAll())
		{
			return array("code" => 200);
		}
		else
		{
			$retMessage = array("Code" => "APPLICATION_ERROR", "message" => "Profile update failed.", "errors" => array('error occured while updating profile'));
			return array("code" => 422, "data" => $retMessage);
		}
	}

	protected function updateAll()
	{
		$userUpdt = strpos($this->updateUser(), 'error');
		$addressUpdt = strpos($this->updateAdd(), 'error');
		$spouseUpdt = strpos($this->updateSpouse(), 'error');
		$childrenUpdt = strpos($this->updateChildren(), 'error');
		$bookUpdt = strpos($this->updateBook(), 'error');
		return count(array_keys((array($userUpdt, $addressUpdt, $spouseUpdt, $childrenUpdt, $bookUpdt)), false)) == count(array($userUpdt, $addressUpdt, $spouseUpdt, $childrenUpdt, $bookUpdt));
	}

	protected function updateUser()
	{
		$retData;
		try
		{
			$stmtData = $this->getQueryData($this->userData);
			if ($stmtData['query'] == 'update')
			{
				$data = array();
				for ($i=0; $i < sizeof($stmtData['columns']); $i++)
				{
					if (!is_null($stmtData['colData'][$i]))
					{
						$data[$stmtData['columns'][$i]] = $stmtData['colData'][$i];
					}
				}
				$stmt = $this->dbConn->update($data)->table('person')->whereMany($stmtData['clause'], '=');
				$stmtExec = $stmt->execute();
				if ($stmtExec == 1)
				{
					$retData = "User Profile Updated";
				}
				else
				{
					$retData = "User Profile not updated";
				}
			}
		}
		catch (\PDOException $pe)
		{
				var_dump($pe);
				exit();
			$retData = "User Profile update error. ".$pe;
		}
		catch (\Exception $e)
		{
			$retData = "User Profile update error. ".$e;
		}
		return $retData;
	}

	protected function updateAdd()
	{
		$retData;
		try
		{
			$stmtData = $this->getQueryData($this->address);
			if ($stmtData['query'] == 'update')
			{
				$data = array();
				for ($i=0; $i < sizeof($stmtData['columns']); $i++)
				{
					if (!is_null($stmtData['colData'][$i]))
					{
						$data[$stmtData['columns'][$i]] = $stmtData['colData'][$i];
					}
				}
				$stmt = $this->dbConn->update($data)->table('user_address_details')->whereMany($stmtData['clause'], '=');
				$stmtExec = $stmt->execute();
				if ($stmtExec == 1)
				{
					$retData = "User Profile Updated";
				}
				else
				{
					$retData = "User Profile not updated";
				}
			}
		}
		catch (\PDOException $pe)
		{
				var_dump($pe);
				exit();
			$retData = "User AProfile update error. ".$pe;
		}
		catch (\Exception $e)
		{
			$retData = "User AProfile update error. ".$e;
		}
		return $retData;
	}

	protected function updateSpouse()
	{
		$retData = array();
		for ($i=0; $i < sizeof($this->spouse); $i++)
		{
			try
			{
				$stmtData = $this->getQueryData($this->spouse[$i]);
				if ($stmtData['query'] == 'update')
				{
					$data = array();
					for ($j=0; $j < sizeof($stmtData['columns']); $j++)
					{
						if (!is_null($stmtData['colData'][$j]))
						{
							$data[$stmtData['columns'][$j]] = $stmtData['colData'][$j];
						}
					}
					$stmt = $this->dbConn->update($data)->table('user_family_details')->whereMany($stmtData['clause'], '=');
					$stmtExec = $stmt->execute();
					if ($stmtExec == 1)
					{
						$retData[] = "User Profile Updated";
					}
					else
					{
						$retData[] = "User Profile not updated";
					}
				}
				else
				{
					$stmt = $this->dbConn->insert($stmtData['columns'])->into('user_family_details')->values($stmtData['colData']);
					$stmtExec = $stmt->execute();
					if (is_numeric($stmtExec) && $stmtExec > 0)
					{
						$retData[] = "User Profile updated.";
					}
				}
			}
			catch (\PDOException $pe)
			{
				$retData[] = "User SProfile update error. ".$pe;
			}
			catch (\Exception $e)
			{
				$retData[] = "User SProfile update error. ".$e;
			}
		}
		return implode(', ', $retData);
	}

	protected function updateChildren()
	{
		$retData = array();
		for ($i=0; $i < sizeof($this->children); $i++)
		{
			try
			{
				$stmtData = $this->getQueryData($this->children[$i]);
				if ($stmtData['query'] == 'update')
				{
					$data = array();
					for ($j=0; $j < sizeof($stmtData['columns']); $j++)
					{
						if (!is_null($stmtData['colData'][$j]))
						{
							$data[$stmtData['columns'][$j]] = $stmtData['colData'][$j];
						}
					}
					$stmt = $this->dbConn->update($data)->table('user_family_details')->whereMany($stmtData['clause'], '=');
					$stmtExec = $stmt->execute();
					if ($stmtExec == 1)
					{
						$retData[] = "User Profile Updated";
					}
					else
					{
						$retData[] = "User Profile not updated";
					}
				}
				else
				{
					$stmt = $this->dbConn->insert($stmtData['columns'])->into('user_family_details')->values($stmtData['colData']);
					$stmtExec = $stmt->execute();
					if (is_numeric($stmtExec) && $stmtExec > 0)
					{
						$retData[] = "User Profile updated.";
					}
				}
			}
			catch (\PDOException $pe)
			{
				$retData[] = "User CProfile update error. ".$pe;
			}
			catch (\Exception $e)
			{
				$retData[] = "User CProfile update error. ".$e;
			}
		}
		return implode(', ', $retData);
	}

	protected function updateBook()
	{
		$retData = array();
		for ($i=0; $i < sizeof($this->book); $i++)
		{
			try
			{
				$stmtData = $this->getQueryData($this->book[$i]);
				if ($stmtData['query'] == 'update')
				{
					$data = array();
					for ($j=0; $j < sizeof($stmtData['columns']); $j++)
					{
						if (!is_null($stmtData['colData'][$j]))
						{
							$data[$stmtData['columns'][$j]] = $stmtData['colData'][$j];
						}
					}
					$stmt = $this->dbConn->update($data)->table('user_books')->whereMany($stmtData['clause'], '=');
					$stmtExec = $stmt->execute();
					if ($stmtExec == 1)
					{
						$retData[] = "User Profile Updated";
					}
					else
					{
						$retData[] = "User Profile not updated";
					}
				}
				else
				{
					$stmt = $this->dbConn->insert($stmtData['columns'])->into('user_books')->values($stmtData['colData']);
					$stmtExec = $stmt->execute();
					if (is_numeric($stmtExec) && $stmtExec > 0)
					{
						$retData[] = "User Profile updated.";
					}
				}
			}
			catch (\PDOException $pe)
			{
				$retData[] = "User BProfile update error. ".$pe;
			}
			catch (\Exception $e)
			{
				$retData[] = "User BProfile update error. ".$e;
			}
		}
		return implode(', ', $retData);
	}

	protected function getQueryData($data)
	{
		$whereData = array();
		foreach ($data as $key => $value)
		{
			if ($key == 'id' && is_numeric($value))
			{
				$whereData['user_id'] = $this->userId;
				$whereData[$key] = $value;
			}
			elseif ($key == "user_id")
			{
				//Do NOT UPDATE USER ID as IT will be worked out
				$cols[] = 'user_id';
				$vals[] = $this->userId;
			}
			else
			{
				$cols[] = $key;
				$vals[] = $value;
			}
		}
		if (!array_key_exists('user_id', $cols))
		{
			$cols[] = 'user_id';
			$vals[] = $this->userId;
		}
		if (sizeof($whereData) > 0)
		{
			$query = 'update';
		}
		else
		{
			$query = 'select';
		}
		return array('query' => $query, 'columns' => $cols, 'colData' => $vals, 'clause' => $whereData);
	}
}