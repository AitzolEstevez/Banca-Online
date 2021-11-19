<?php

include_once("../model/CuentasModel.php");
include_once("../model/ExtractoModel.php");

$data=json_decode(file_get_contents("php://input"),true);

$importe=$data['importe'];
$origen=$data['origen'];
$destino=$data['destino'];
$concepto=$data['concepto'];

//$fechaActual = date('Y-m-d');
$respuesta = ""; 

$response = array();

$cuenta = new CuentasModel();

if($origen != $destino){

    if($cuenta->reducirSaldo($importe, $origen) && $importe<1000000){
        $response['cambio1']="no error";
        $respuesta = "Hecho";
    }else{
        $response['cambio1']="error";
        $respuesta = "No hecho";
    }

    if($respuesta == "Hecho"){
        if($cuenta->aumentarSaldo($importe, $destino)){
        $response['cambio2']="no error";
        $respuesta = "Hecho";
    }else{
        $response['cambio2']="error";
        $respuesta = "No hecho";
    }

    }

    if($respuesta == "Hecho"){
        $response['error'] = "Transferencia realizada";
    }else{
        $response['error'] = "Error en la transferencia";
    }


}else{

    $response['error'] = "No puede ser la misma cuenta";

}




/*
$extracto = new ExtractoModel();

$extracto->fecha=$fechaActual;

$extracto->insertExtractoNum($importe, $origen, $destino, $concepto);
*/

 
echo json_encode($response);
