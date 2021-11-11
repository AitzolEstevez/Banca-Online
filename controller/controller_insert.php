<?php
include_once ("../model/FacturaModel.php");
include_once ("../model/ExtractoModel.php");
include_once ("../model/MiStockModel.php");

$data = json_decode(file_get_contents("php://input"),true);

$fechaActual = date('Y-m-d');
$numfactura = mt_Rand(100000,999999); 

//$cuenta=$data['cuenta'];



$proveedor=$data['proveedor'];
$producto=$data['producto'];
$precio=$data['precio'];
$cantidad=$data['cantidad'];
$total=$data['total'];

$factura = new FacturaModel();
$extracto = new ExtractoModel();
$stock = new MiStockModel();

$response = array();

$factura->numerofactura=$numfactura;
$factura->nombre=$proveedor;
$factura->idproducto=$producto;
$factura->precio=$precio;
$factura->fecha=$fechaActual;
$factura->cantidad=$cantidad;
$factura->importe=$total;

$response['insertFactura'] = $factura->insertFactura();
//$response['insertExtracto'] = $extracto->setListProveedores();
//$response['insertStock'] = $stock->setListMiStock();

$response['error'] = "no error";

echo json_encode($response);

unset($factura);
unset($response);