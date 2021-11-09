<?php

include_once("../model/UsuariosModel.php");

$data=json_decode(file_get_contents("php://input"),true);

$nombre=$data['nombre'];
$contrasena=$data['contrasena'];

$response=array();

if (( $nombre !=null ) && ( $contrasena !=null )){

    $usuario = new UsuariosModel();
    $usuario->nombre=$nombre;
    $usuario->contrasena=$contrasena;
    
    if ($usuario->finduser()){
        session_start();
        $_SESSION['nombre']=$nombre;

        
        if($usuario->findadmin()){
            $response['tipo'] = "admin"; 
        }else{
            $response['tipo'] = "cliente";
        }


        $response['nombre']=$nombre;
        $response['error']="no error";       
    } else{
        $response['error']="incorrect user";
    }

}else {
    $response['error']="username or password not filled";
}

echo json_encode($response);

unset($response);
