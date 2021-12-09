<?php
if ($_SERVER['SERVER_NAME'] == "lau.zerbitzaria.net") {
    include_once ("connect_data_SERV.php");
} else {
    include_once ("connect_data_LOCAL.php");
}

include_once ("ExtractoClass.php");

// ////////////////////////////////////////////////////////////////////////////////////////////
class ExtractoModel extends ExtractoClass
{

    public $link;

    public $objDirector;

    // save director data in the object
    public function OpenConnect()
    {
        $konDat = new connect_data();
        try {
            $this->link = new mysqli($konDat->host, $konDat->userbbdd, $konDat->passbbdd, $konDat->ddbbname);
            // mysqli klaseko link objetua sortzen da dagokion konexio datuekin
            // se crea un nuevo objeto llamado link de la clase mysqli con los datos de conexiÃ³n.
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

    // ////////////////////////////////////////////////////////////////////////////////////////////
    public function setListExtractoByCuenta($numcuenta)
    {
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $sql = "CALL MostrarExtractoCuentas($numcuenta)"; // SQL sententzia - sentencia SQL

        $result = $this->link->query($sql);

        // $this->link->num_rows; num rows of result

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { // each row

            $newFactura = new ExtractoModel();

            $newFactura->fecha = $row['fecha'];
            $newFactura->concepto = $row['concepto'];
            $newFactura->importe = $row['importe'];
            $newFactura->saldo = $row['saldo'];

            array_push($list, $newFactura);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }

    //////////////////////////////////////////////////////////////////////////////////////////////
    public function insertExtracto()
    {
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $fecha = $this->fecha;
        $concepto = $this->concepto;
        $importe = $this->importe;
        $idcuenta = $this->idcuenta;

        $sql = "CALL updateCuentas($importe,$idcuenta)";
        $this->link->query($sql);


        $sql = "CALL insertExtracto('$fecha','$concepto',$importe,$idcuenta)";
        $this->link->query($sql);

        $this->CloseConnect();
    }

    //////////////////////////////////////////////////////////////////////////////////////////////
    public function insertFondos()
    {
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $fecha = $this->fecha;
        $concepto = $this->concepto;
        $importe = $this->importe;
        $idcuenta = $this->idcuenta;

        $sql = "CALL updateCuentasFondos($importe,$idcuenta)";
        $this->link->query($sql);


        $sql = "CALL insertExtractoFondos('$fecha','$concepto',$importe,$idcuenta)";
        $this->link->query($sql);

        $this->CloseConnect();
    }

    public function retirarFondos()
    {
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $fecha = $this->fecha;
        $concepto = $this->concepto;
        $importe = $this->importe;
        $idcuenta = $this->idcuenta;

        $sql = "CALL updateCuentas($importe,$idcuenta)";
        $this->link->query($sql);


        $sql = "CALL insertExtracto('$fecha','$concepto',$importe,$idcuenta)";
        $this->link->query($sql);

        $this->CloseConnect();
    }

    public function insertExtractoTrans($fechaActual, $conceptogasto, $importe, $origen){
        $this->OpenConnect();
        
        $insert = false;

        $sql = "CALL insertExtracto('$fechaActual', '$conceptogasto', $importe, $origen)";
        if($this->link->query($sql)){
            $insert = true;
        }

        return $insert;
        mysqli_free_result($result);
        $this->CloseConnect();

    }

    public function insertExtractoTrans2($fechaActual, $conceptogasto, $importe, $origen){
        $this->OpenConnect();
        $insert = false;

        $sql = "CALL insertExtractoFondos('$fechaActual', '$conceptogasto', $importe, $origen)";
        if($this->link->query($sql)){
            $insert = true;
        }

        return $insert;
        mysqli_free_result($result);
        $this->CloseConnect();
        
    }

    public function extractoByFecha($fecha1,$fecha2){
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $sql = "select * from extracto where fecha between '$fecha1' and '$fecha2' order by id desc"; // SQL sententzia - sentencia SQL

        $result = $this->link->query($sql);

        // $this->link->num_rows; num rows of result

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { // each row

            $newextracto = new ExtractoModel();

            $newextracto->fecha = $row['fecha'];
            $newextracto->concepto = $row['concepto'];
            $newextracto->importe = $row['importe'];
            $newextracto->saldo = $row['saldo'];

            array_push($list, $newextracto);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }

}

?>