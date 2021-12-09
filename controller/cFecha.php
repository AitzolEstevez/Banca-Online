<?php

include_once ("../model/ExtractoModel.php");

$extracto= new ExtractoModel();

$data = json_decode(file_get_contents("php://input"), true);

$fecha1 = $data['fecha1'];
$fecha2 = $data['fecha2'];

$response=array();

$response['extractofecha']=$extracto->extractoByFecha($fecha1,$fecha2);
$response['error']="no error";

echo json_encode($response);

unset ($extracto);
unset ($response);