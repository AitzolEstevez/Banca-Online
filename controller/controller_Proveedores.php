<?php
include_once ("../model/ProveedorModel.php");

$proveedor = new ProveedorModel();

$response = array();

$response['listProveedores']=$proveedor->setListProveedores();

$response['error']="no error";

echo json_encode($response);

unset($proveedor);
unset($response);