<?php

include_once ("../model/CuentasModel.php");
include_once ("../model/UsuariosModel.php");


$data = json_decode(file_get_contents("php://input"),true);

$num = $data['num'];
$tipo = $data['tipo'];

$cuenta = new CuentasModel();
$usuario = new UsuariosModel();

$response = array();

$cuenta->numcuenta=$num;
$cuenta->tipo=$tipo;

if($cuenta->ifExistCuenta() == -1){
    $response['existe'] = "no";
}else{
    $response['existe'] = "si";
}

if($response['existe'] == "no"){
    if($cuenta->createCuenta()){
        $response['creado'] = "si";
    }else{
        $response['creado'] = "no";
    }
}


echo json_encode($response);

unset($response);