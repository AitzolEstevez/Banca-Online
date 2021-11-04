<?php

if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{
    include_once ("connect_data_LOCAL.php");
}

include_once("MiStockClass.php");
<<<<<<< HEAD

//////////////////////////////////////////////////////////////////////////////////////////////

class MiStockModel extends MiStockClass {
    
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
=======

class MiStockModel extends MiStockClass{
    
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
        
>>>>>>> e03697d173c1b1f551070d6a15e57ce4e5699ccf
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function setListMiStock()
    {
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $sql = "CALL SelectAllMiStock()"; // SQL sententzia - sentencia SQL
        
        $result = $this->link->query($sql);
        
        //$this->link->num_rows; num rows  of result
        
        $list=array();
        
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { //each row
            
            $newStock=new MiStockModel();
            
            $newStock->id=$row['id'];
            $newStock->producto=$row['producto'];
            $newStock->precio=$row['precio'];
            $newStock->stock=$row['stock'];
            
            array_push($list, $newStock);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }
}