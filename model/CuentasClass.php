<?php

class CuentasClass {
    
    public $idCuentas;
    public $numcuenta;
    public $tipo;
    public $interes;
    public $negociado;
    public $borrado;
    
    public function getIdCuentas(){
        return $this->idCuentas;
    }
 
    public function setIdCuentas($idCuentas){
        $this->idCuentas = $idCuentas;

        return $this;
    }

    public function getNumcuenta(){
        return $this->numcuenta;
    }

    public function setNumcuenta($numcuenta){
        $this->numcuenta = $numcuenta;

        return $this;
    }

    public function getTipo(){
        return $this->tipo;
    }
 
    public function setTipo($tipo){
        $this->tipo = $tipo;

        return $this;
    }

    public function getInteres(){
        return $this->interes;
    }

    public function setInteres($interes)  {
        $this->interes = $interes;

        return $this;
    }

    public function getNegociado(){
        return $this->negociado;
    }

    public function setNegociado($negociado){
        $this->negociado = $negociado;

        return $this;
    }

    public function getBorrado(){
        return $this->borrado;
    }
   
    public function setBorrado($borrado){
        $this->borrado = $borrado;

        return $this;
    }
}

