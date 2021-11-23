<?php

include_once("../model/CuentasModel.php");
include_once("../model/ExtractoModel.php");

$data=json_decode(file_get_contents("php://input"),true);

$importe=$data['importe'];
$origen=$data['origen'];
$destino=$data['destino'];
$conceptogasto=$data['conceptogasto'];
$conceptoingreso=$data['conceptoingreso'];


$fechaActual = date('Y-m-d');
$respuesta = ""; 

$response = array();

$cuenta = new CuentasModel();
$extracto=new ExtractoModel();
$cuenta->idCuentas=$origen;

$response['saldo'] = $cuenta->findsaldobyid($origen);

if($importe>$response['saldo']->saldo){
    $response['error'] = "No puedes transferir más de lo que tienes";
}else{

if($importe == 0){
    $response['cero'] = "No puede ser 0";
}else{
    $response['cero'] = "";
}


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
        
        
        if($extracto->insertExtractoTrans($fechaActual, $conceptogasto, $importe, $origen)){
            $insert1 = "insertado";
        }

        if($extracto->insertExtractoTrans2($fechaActual, $conceptoingreso, $importe, $destino)){
            $insert2 = "insertado";
        }


        if($insert1 == "insertado" && $insert2 = "insertado"){
            $response['insertado'] = "insertado";
        }else{
            $response['insertado'] = "no insertado";
        }
        
    }else{
        $response['error'] = "Error en la transferencia";
    }


}else{

    $response['error'] = "No puede ser la misma cuenta";

}


}

/*
$extracto = new ExtractoModel();

$extracto->fecha=$fechaActual;

$extracto->insertExtractoNum($importe, $origen, $destino, $concepto);
*/

 
echo json_encode($response);
