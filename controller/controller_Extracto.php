<?php

include_once ("../model/ExtractoModel.php");

$extracto= new ExtractoModel();

$response=array();

//$response['listClientes']=$extracto->setListClientes();
//$response['listProveedores']=$extracto->setListProveedores();
$response['error']="no error";

echo json_encode($response);

unset ($extracto);
unset ($response);