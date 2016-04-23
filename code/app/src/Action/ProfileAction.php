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
		$stmt=$this->dbConn->select(array('person.*', 'user.username', 'user_address_details.address_line_1', 'user_address_details.address_line_2', 'user_address_details.pincode', 'user_address_details.street_landmark', 'user_address_details.country_id', 'user_address_details.state_id', 'user_address_details.district_id', 'user_address_details.city_taluka_id'))->from('person')->join('user', 'person.user_id', '=', 'user.id')->join('user_address_details', 'user_address_details.user_id', '=', 'user.id')->where('user.id', '=', $this->userId);
		$stmtExec = $stmt->execute();
		$stmtFetched = $stmtExec->fetch();

		$stmtFetched['spouse'] = array();
		$stmtFetched['children'] = array();

		$stmtFamily = $this->dbConn->select()->from('user_family_details')->where('user_id', '=', $this->userId);
		$stmtFExec = $stmtFamily->execute();
		$stmtFFetched = $stmtFExec->fetchAll();
		if(sizeof($stmtFFetched) > 0){
			for ($i=0; $i < sizeof($stmtFFetched); $i++) { 
				if(strtoupper($stmtFFetched[$i]['relation']) == 'SPOUSE') {
					array_push($stmtFetched['spouse'], $stmtFFetched[$i]);
				} else {
					array_push($stmtFetched['children'], $stmtFFetched[$i]);
				}
			}
		}
		// array_push($stmtFetched, $data);
		$stmtBook = $this->dbConn->select()->from('user_books')->where('user_id', '=', $this->userId);
		$stmtBExec = $stmtBook->execute();
		$stmtBFetched = $stmtBExec->fetchAll();
		$stmtFetched['books'] = $stmtBFetched;
		if (sizeof($stmtFetched) > 0) {
			return array("code" => 200, "data" => $stmtFetched);
		} else {
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
		$this->book = $data['book'];
		unset($data['book']);
		$this->userData = $data;
		return $this->updateAll();
	}

	protected function updateAll()
	{
		$userUpdt = $this->updateUser();
		$familyUpdt = $this->updateFamily();
		$bookUpdt = $this->updateBook();
		exit;
		return array($userUpdt, $familyUpdt, $bookUpdt);
	}

	protected function updateUser()
	{
		echo "USER";
	}

	protected function updateFamily()
	{
		echo "FAMILY";
	}

	protected function updateBook()
	{
		echo "BOOK";
	}
}