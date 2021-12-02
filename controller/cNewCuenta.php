<?php

include_once ("../model/CuentasModel.php");

$data = json_decode(file_get_contents("php://input"),true);

$num = $data['num'];
$tipo = $data['tipo'];

$cuenta = new CuentasModel();

$response = array();

$cuenta->numcuenta=$num;
$cuenta->tipo=$tipo;

if($cuenta->ifExistCuenta()){
    $response['existe'] = "si";
}else{
    $response['existe'] = "no";
}

if($response['existe'] = "no"){
    if($cuenta->createCuenta()){
        $response['creado'] = "Cuenta creada correctamente";
    }else{
        $response['creado'] = "No se ha creado la cuenta";
    }
}


echo json_encode($response);

unset($response);