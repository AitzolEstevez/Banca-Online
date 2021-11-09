<?php

if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{
    include_once ("connect_data_LOCAL.php");
}

include_once("CuentasClass.php");

//////////////////////////////////////////////////////////////////////////////////////////////

class CuentasModel extends CuentasClass {
    
    public $link;
    public $objDirector;  //save director data in the object
    
    public function OpenConnect()
    {
        $konDat=new connect_data();
        try
        {
            $this->link=new mysqli($konDat->host,$konDat->userbbdd,$konDat->passbbdd,$konDat->ddbbname);
            // mysqli klaseko link objetua sortzen da dagokion konexio datuekin
            // se crea un nuevo objeto llamado link de la clase mysqli con los datos de conexiÃ³n.
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
        }
        $this->link->set_charset("utf8"); // honek behartu egiten du aplikazio eta
        //                  //databasearen artean UTF -8 erabiltzera datuak trukatzeko
    }
    
    public function CloseConnect()
    {
        mysqli_close ($this->link);
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function setListCuentas()
    {
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $sql = "CALL SelectCuentasAdmin()"; // SQL sententzia - sentencia SQL
        
        $result = $this->link->query($sql);
<<<<<<< HEAD
        
        //$this->link->num_rows; num rows  of result
        
        $list=array();
        
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { //each row
            
            $newCuenta=new CuentasModel();
=======

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $new=new CuentasClass();
>>>>>>> Pol
            
            $newCuenta->idCuentas=$row['id'];
            $newCuenta->numcuenta=$row['numcuenta'];
            $newCuenta->tipo=$row['tipo'];
            $newCuenta->interes=$row['interes'];
            $newCuenta->negociado=$row['negociado'];
            
            array_push($list, $newCuenta);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }
}