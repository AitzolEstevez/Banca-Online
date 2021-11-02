<?php


class UsuariosClass{

    public $id;
    public $nombre;
    public $contrasena;
    public $tipo;
    public $idcuenta;
    public $dni;
    public $telefono;
    public $correo;
    
    public function getId(){
        return $this->id;
    }

    public function setId($id){
        $this->id = $id;

        return $this;
    }
 
    public function getNombre(){
        return $this->nombre;
    }

    public function setNombre($nombre){
        $this->nombre = $nombre;

        return $this;
    }
 
    public function getContrasena(){
        return $this->contrasena;
    }
 
    public function setContrasena($contrasena){
        $this->contrasena = $contrasena;

        return $this;
    }
 
    public function getTipo(){
        return $this->tipo;
    }

    public function setTipo($tipo){
        $this->tipo = $tipo;

        return $this;
    }
 
    public function getIdcuenta(){
        return $this->idcuenta;
    }

    public function setIdcuenta($idcuenta){
        $this->idcuenta = $idcuenta;

        return $this;
    }
 
    public function getDni(){
        return $this->dni;
    }

    public function setDni($dni){
        $this->dni = $dni;

        return $this;
    }
 
    public function getTelefono(){
        return $this->telefono;
    }
 
    public function setTelefono($telefono){
        $this->telefono = $telefono;

        return $this;
    }

    public function getCorreo(){
        return $this->correo;
    }

    public function setCorreo($correo){
        $this->correo = $correo;

        return $this;
    }
}