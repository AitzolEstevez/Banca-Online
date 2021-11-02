<?php

class ProveedorClass{

    public $id;
    public $nombre;

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
}