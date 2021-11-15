<?php
include_once ("../model/FacturaModel.php");
include_once ("../model/MiStockModel.php");
include_once ("../model/CuentasModel.php");

$data = file_get_contents("php://input");
$data = json_decode($data);

$factura = new FacturaModel();
$stock = new MiStockModel();
$cuentas = new CuentasModel();

$response = array();

//$response['listClientes'] = $factura->setListClientes();
$response['listProveedores'] = $factura->setListProveedores();
$response['listStock'] = $stock->setListMiStock();
$response['listCuentas'] = $cuentas->setListCuentas();

$response['error'] = "no error";

echo json_encode($response);

unset($factura);
unset($response);