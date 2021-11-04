<?php

include_once ("../model/ExtractoModel.php");

$extracto= new ExtractoModel();

$data=file_get_contents("php://input");
$data=json_decode($data);

$response=array();

$numcuenta=$data->numcuenta;
$response['listExtracto']=$extracto->setListExtractoByCuenta($numcuenta);

$response['error']="no error";

echo json_encode($response);

unset ($extracto);
unset ($response);