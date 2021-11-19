<?php

include_once("../model/CuentasModel.php");
include_once("../model/ExtractoModel.php");

$data=json_decode(file_get_contents("php://input"),true);

$importe=$data['importe'];
$origen=$data['origen'];
$destino=$data['destino'];
$concepto=$data['concepto'];

//$fechaActual = date('Y-m-d');

$response = array();
$cuenta = new CuentasModel();
$cuenta->aumentarSaldo($importe,$destino);
/*if(){
    $response['error']="no error";
}else{
    $response['error']="error";
}*/

if($cuenta->reducirSaldo($importe,$origen)){
    $response['error2']="no error";
}else{
    $response['error2']="error";
}


/*
$extracto = new ExtractoModel();

$extracto->fecha=$fechaActual;

$extracto->insertExtractoNum($importe, $origen, $destino, $concepto);
*/

echo json_encode($response);
