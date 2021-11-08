<?php

include_once("'../model/UsuariosModel.php'");

$data=json_decode(file_get_contents("php://input"),true);

$nombre=$data['nombre'];
$contrasena=$data['contrasena'];

$response=array();

if (( $name !=null ) && ( $password !=null )){

    $usuario = new UsuariosModel();
    $usuario->nombre=$nombre;
    $usuario->contrasena=$contrasena;

    if ($user->findUserByUsername()){
        session_start();
        $_SESSION['nombre']=$nombre;
        
        $_SESSION['tipo']=$usuario->tipo;
    
        $response['usuario']=$usuario; 
        $response['error']="no error";       
    } else{
        $response['error']="incorrect user";
    }

}else {
    $response['error']="username or password not filled";
}

echo json_encode($response);

unset($response);
