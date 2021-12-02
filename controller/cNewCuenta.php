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
$respuesta=$cuenta->ifExistCuenta();
$response['id']=$respuesta;

if($respuesta != -1){
    $response['existe'] = "si";
}else{
    $response['existe'] = "no";
}

if($response['existe'] == "no"){
    if($cuenta->createCuenta()){
        $idcuenta = $cuenta->ifExistCuenta();
        $usuario->idcuenta=$idcuenta;
        $usuario->createAdminUser();
        $response['creado'] = "Cuenta creada correctamente";
    }
}else{
    $response['creado'] = "No se ha creado la cuenta";
}


echo json_encode($response);

unset($response);