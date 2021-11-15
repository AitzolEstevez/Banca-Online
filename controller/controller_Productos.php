<?php
include_once ("../model/ProductosModel.php");

$producto = new ProductosModel();

$data = json_decode(file_get_contents("php://input"), true);

$response = array();

$proveedor = $data['proveedor'];
$response['listProductos'] = $producto->setListEProductosByProveedor($proveedor);

$response['error'] = "no error";

echo json_encode($response);

unset($producto);
unset($response);