<?php

if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{
    include_once ("connect_data_LOCAL.php");
}

<<<<<<< HEAD
include_once("ExtractoClass.php");

//////////////////////////////////////////////////////////////////////////////////////////////

class ExtractoModel extends ExtractoClass {
    
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
    

    public function setListExtractoByCuenta($numcuenta)
    {
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $sql = "CALL MostrarExtractoCuentas($numcuenta)"; // SQL sententzia - sentencia SQL
        
        $result = $this->link->query($sql); 
        
        //$this->link->num_rows; num rows  of result
        
        $list=array();
        
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { //each row
            
            $newFactura=new ExtractoModel();
            
            $newFactura->id=$row['id'];
            $newFactura->fecha=$row['fecha'];
            $newFactura->concepto=$row['concepto'];
            $newFactura->importe=$row['importe'];
            $newFactura->saldo=$row['saldo'];

            array_push($list, $newFactura);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }
}


?>
=======
include_once("ExtractoClass.php")

class ExtractoModel extends ExtractoClass{
    
    public $link;

    public function OpenConnect(){
        
        $konDat=new connect_data();
        try{
            $this->link=new mysqli($konDat->host,$konDat->userbbdd,$konDat->passbbdd,$konDat->ddbbname);
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
        }

        $this->link->set_charset("utf8");
    }

    public function CloseConnect(){
        mysqli_close ($this->link);
    }

    public function insert(){}


    public function update(){}


    public function delete(){}


    public function setList(){
        
        $this->OpenConnect();

        $sql = "";

        $result = $this->link->query($sql);

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            
            
            array_push($list, $new);
        }
        
    }
    
}
>>>>>>> e03697d173c1b1f551070d6a15e57ce4e5699ccf
