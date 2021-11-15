<?php

class FacturaClass
{

    public $id;

    public $numerofactura;
    
    public $nombre;

    public $idcuenta;

    public $idproducto;

    public $precio;

    public $fecha;

    public $cantidad;

    public $importe;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    public function getNumerofactura()
    {
        return $this->numerofactura;
    }

    public function setNumerofactura($numerofactura)
    {
        $this->numerofactura = $numerofactura;

        return $this;
    }

    public function getNombre()
    {
        return $this->nombre;
    }

    public function setNombre($nombre)
    {
        $this->nombre = $nombre;

        return $this;
    }

    public function getIdcuenta()
    {
        return $this->idcuenta;
    }

    public function setIdcuenta($idcuenta)
    {
        $this->idcuenta = $idcuenta;

        return $this;
    }

    public function getIdproducto()
    {
        return $this->idproducto;
    }

    public function setIdproducto($idproducto)
    {
        $this->idproducto = $idproducto;

        return $this;
    }

    public function getPrecio()
    {
        return $this->precio;
    }

    public function setPrecio($precio)
    {
        $this->precio = $precio;

        return $this;
    }

    public function getFecha()
    {
        return $this->fecha;
    }

    public function setFecha($fecha)
    {
        $this->fecha = $fecha;

        return $this;
    }

    public function getCantidad()
    {
        return $this->cantidad;
    }

    public function setCantidad($cantidad)
    {
        $this->cantidad = $cantidad;

        return $this;
    }

    public function getImporte()
    {
        return $this->importe;
    }

    public function setImporte($importe)
    {
        $this->importe = $importe;

        return $this;
    }
}