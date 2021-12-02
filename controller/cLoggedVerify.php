<?php
session_start(); 

$response=array();

if (isset($_SESSION['nombre']))
{
    $response["nombre"]=$_SESSION['nombre'];
    $response["error"]="Sesión iniciada";
}else{
    $response["error"]="Sesión no iniciada";
}
echo json_encode($response);