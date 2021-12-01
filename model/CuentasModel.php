<?php
/*if ($_SERVER['SERVER_NAME'] == "lau.zerbitzaria.net") {
    include_once ("connect_data_SERV.php");
} else {*/
    include_once ("connect_data_LOCAL.php");
//}

include_once ("CuentasClass.php");

// ////////////////////////////////////////////////////////////////////////////////////////////
class CuentasModel extends CuentasClass
{

    public $link;


    // save director data in the object
    public function OpenConnect()
    {
        $konDat = new connect_data();
        try {
            $this->link = new mysqli($konDat->host, $konDat->userbbdd, $konDat->passbbdd, $konDat->ddbbname);
           
        } catch (Exception $e) {
            echo $e->getMessage();
        }
        $this->link->set_charset("utf8"); // honek behartu egiten du aplikazio eta
                                          // //databasearen artean UTF -8 erabiltzera datuak trukatzeko
    }

    public function CloseConnect()
    {
        mysqli_close($this->link);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////
    public function setListCuentas()
    {

        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $sql = "CALL SelectCuentasAdmin()"; // SQL sententzia - sentencia SQL

        $result = $this->link->query($sql);

        // $this->link->num_rows; num rows of result

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { // each row

            $newCuenta = new CuentasModel();

            $newCuenta->idCuentas = $row['id'];
            $newCuenta->numcuenta = $row['numcuenta'];
            $newCuenta->tipo = $row['tipo'];
            $newCuenta->saldo = $row['saldo'];

            array_push($list, $newCuenta);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////

    public function updateCuentas()
    {
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $saldo = $this->saldo;
        $idcuenta = $this->idCuentas;

        $sql = "CALL updateCuentas($saldo,$idcuenta)";

        if ($this->link->query($sql)) // true if success
                                       // $this->link->affected_rows; number of inserted rows
        {
            return "updated.Num de updates: " . $this->link->affected_rows;
        } else {
            return "Error al modificar";
        }

        $this->CloseConnect();
    }


    public function aumentarSaldo($importe, $destino){

        $this->OpenConnect();
        
        $update = false;

        $sql = "update cuentas set saldo=saldo+$importe where id=$destino";

        if ($this->link->query($sql)){
            $update = true;   
        }

        return $update;
        mysqli_free_result($result);
        $this->CloseConnect();

    }


    public function reducirSaldo($importe, $destino){

        $this->OpenConnect();
        
        $update = false;

        $sql = "update cuentas set saldo=saldo-$importe where id=$destino and saldo>0";

        if ($this->link->query($sql)){
            
            if($this->link->affected_rows){
                $update = true;
            } 
        }

        return $update;
        mysqli_free_result($result);
        $this->CloseConnect();

    }


    public function findsaldobyid($origen){
        $this->OpenConnect();

        $sql="select saldo from cuentas where id=$origen";

        $result = $this->link->query($sql);

        
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $cuenta = new CuentasModel();
            $cuenta->saldo=$row['saldo'];

        
        }

        $this->CloseConnect();
        return $cuenta;

    }

}