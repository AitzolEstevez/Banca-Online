<?php
include_once ("../model/ExtractoModel.php");

$extracto = new ExtractoModel();

$data = json_decode(file_get_contents("php://input"), true);

$response = array();

$numcuenta = $data['numcuenta'];
$response['listExtracto'] = $extracto->setListExtractoByCuenta($numcuenta);

$response['error'] = "no error";

echo json_encode($response);

unset($extracto);
unset($response);