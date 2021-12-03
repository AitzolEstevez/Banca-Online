<?php
include_once ("../model/FacturaModel.php");
include_once ("../model/ExtractoModel.php");
include_once ("../model/MiStockModel.php");

$data = json_decode(file_get_contents("php://input"),true);

$fechaActual = date('Y-m-d');
$numfactura = mt_Rand(100000,999999); 


///////////////////////////////////
$añadirfondos=$data['añadirfondos'];
$realizarpedido=$data['realizarpedido'];
///////////////////////////////


$factura = new FacturaModel();
$extracto = new ExtractoModel();
$stock = new MiStockModel();

$response = array();

if($realizarpedido==1){

    $cuenta=$data['cuenta'];
    $proveedor=$data['proveedor'];
    $producto=$data['producto'];
    $precio=$data['precio'];
    $cantidad=$data['cantidad'];
    $total=$data['total'];
    $img=$data['img'];
    $selected=$data['selected'];

    ////////////FACTURA//////////////
    $factura->numerofactura=$numfactura;
    $factura->idcuenta=$cuenta;
    $factura->nombre=$proveedor;
    $factura->idproducto=$producto;
    $factura->precio=$precio;
    $factura->fecha=$fechaActual;
    $factura->cantidad=$cantidad;
    $factura->importe=$total;

    ////////////EXTRACTO//////////////
    $extracto->fecha=$fechaActual;
    $extracto->concepto=$selected;
    $extracto->importe=$total;
    $extracto->idcuenta=$cuenta;


    ////////////STOCK//////////////
    $stock->idproducto=$producto;
    $stock->stock=$cantidad;
    $stock->precio=$precio;
    $stock->img=$img;
    
    $response['insertFactura'] = $factura->insertFactura();
    $response['insertStock'] = $stock->updateMiStock();
    $response['insertExtracto'] = $extracto->insertExtracto();

}elseif ($añadirfondos==1) {

    $cuenta=$data['cuenta'];
    $total=$data['total'];
    $selected=$data['selected'];

    ////////////EXTRACTO//////////////
    $extracto->fecha=$fechaActual;
    $extracto->concepto=$selected;
    $extracto->importe=$total;
    $extracto->idcuenta=$cuenta;

    $response['insertFondos'] = $extracto->insertFondos();

}else{
    $response['error'] = "no error";  
}

echo json_encode($response);

unset($factura);
unset($response);