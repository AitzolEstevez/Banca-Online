<?php

class CuentasClass
{

    public $idCuentas;

    public $numcuenta;

    public $tipo;

    public $saldo;

    public $borrado;

    


    /**
     * Get the value of idCuentas
     */ 
    public function getIdCuentas()
    {
        return $this->idCuentas;
    }

    /**
     * Set the value of idCuentas
     *
     * @return  self
     */ 
    public function setIdCuentas($idCuentas)
    {
        $this->idCuentas = $idCuentas;

        return $this;
    }

    /**
     * Get the value of numcuenta
     */ 
    public function getNumcuenta()
    {
        return $this->numcuenta;
    }

    /**
     * Set the value of numcuenta
     *
     * @return  self
     */ 
    public function setNumcuenta($numcuenta)
    {
        $this->numcuenta = $numcuenta;

        return $this;
    }

    /**
     * Get the value of tipo
     */ 
    public function getTipo()
    {
        return $this->tipo;
    }

    /**
     * Set the value of tipo
     *
     * @return  self
     */ 
    public function setTipo($tipo)
    {
        $this->tipo = $tipo;

        return $this;
    }

    /**
     * Get the value of saldo
     */ 
    public function getSaldo()
    {
        return $this->saldo;
    }

    /**
     * Set the value of saldo
     *
     * @return  self
     */ 
    public function setSaldo($saldo)
    {
        $this->saldo = $saldo;

        return $this;
    }

    /**
     * Get the value of borrado
     */ 
    public function getBorrado()
    {
        return $this->borrado;
    }

    /**
     * Set the value of borrado
     *
     * @return  self
     */ 
    public function setBorrado($borrado)
    {
        $this->borrado = $borrado;

        return $this;
    }
}

