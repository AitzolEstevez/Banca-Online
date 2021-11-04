<?php

if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{
    include_once ("connect_data_LOCAL.php");
}

include_once("FacturaClass.php");

<<<<<<< HEAD
//////////////////////////////////////////////////////////////////////////////////////////////

class FacturaModel extends FacturaClass {
    
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
=======
class FacturaModel extends FacturaClass{
    
    public $link;

    public function OpenConnect(){
        
        $konDat=new connect_data();
        try{
            $this->link=new mysqli($konDat->host,$konDat->userbbdd,$konDat->passbbdd,$konDat->ddbbname);
>>>>>>> e03697d173c1b1f551070d6a15e57ce4e5699ccf
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
        }
<<<<<<< HEAD
        $this->link->set_charset("utf8"); // honek behartu egiten du aplikazio eta
        //                  //databasearen artean UTF -8 erabiltzera datuak trukatzeko
    }
    
    public function CloseConnect()
    {
        mysqli_close ($this->link);
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function setListClientes()
    {
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $sql = "CALL MostrarFacturasClientes()"; // SQL sententzia - sentencia SQL
        
        $result = $this->link->query($sql);
        
        //$this->link->num_rows; num rows  of result
        
        $list=array();
        
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { //each row
            
            $newFactura=new FacturaModel();
            
            $newFactura->id=$row['id'];
            $newFactura->numerofactura=$row['numerofactura'];
            $newFactura->nombre=$row['cliente'];
            $newFactura->idcuenta=$row['numcuenta'];
            $newFactura->idproducto=$row['producto'];
            $newFactura->precio=$row['precio'];
            $newFactura->fecha=$row['fecha'];
            $newFactura->cantidad=$row['cantidad'];
            $newFactura->importe=$row['importe'];
            
            array_push($list, $newFactura);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function setListProveedores()
    {
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $sql = "CALL MostrarFacturasProveedores()"; // SQL sententzia - sentencia SQL
        
        $result = $this->link->query($sql);
        
        //$this->link->num_rows; num rows  of result
        
        $list=array();
        
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { //each row
            
            $newFactura=new FacturaModel();
            
            $newFactura->id=$row['id'];
            $newFactura->numerofactura=$row['numerofactura'];
            $newFactura->nombre=$row['proveedor'];
            $newFactura->idproducto=$row['producto'];
            $newFactura->precio=$row['precio'];
            $newFactura->fecha=$row['fecha'];
            $newFactura->cantidad=$row['cantidad'];
            $newFactura->importe=$row['importe'];
            
            array_push($list, $newFactura);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function insert(){
        
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $TituloPeliculaInsert=$this->TituloPelicula;
        $AnioInsert=$this->Anio;
        $DirectorInsert=$this->Director;
        $cartelInsert=$this->cartel;
        
        if ($cartelInsert =="") { $cartelInsert ="view/img/default.png";}
        
        $sql="CALL spInsertPelicula('$TituloPeliculaInsert',$AnioInsert,$DirectorInsert,'$cartelInsert')";
        
        if ($this->link->query($sql))  // true if success
        //$this->link->affected_rows;  number of inserted rows
        {
            return "insertado.Num de inserts: ".$this->link->affected_rows;
        } else {
            return $sql."Error al insertar";
        }
        
        $this->CloseConnect();
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function delete(){
        
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $id=$this->idPelicula;
        $sql="CALL spDeletePelicula($id)";
        
        if ($this->link->query($sql))  // true if success
        //$this->link->affected_rows;  number of deleted rows
        {
            return "borrado.Num de deletes: ".$this->link->affected_rows;
        } else {
            return "Error al borrar";
        }
        $this->CloseConnect();
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function view(){
        
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $idPelicula=$this->idPelicula;
        
        $sql = "CALL spFindIdPelicula($idPelicula)"; // SQL sententzia - sentencia SQL
        
        $aurkituta=false;
        
        $result = $this->link->query($sql);
        if ($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
        {
            $this->TituloPelicula=$row['TituloPelicula'];
            $this->Anio=$row['Anio'];
            $this->Director=$row['Director'];
            $this->cartel=$row['cartel'];
            $aurkituta=true;
        }
        return $aurkituta;
        mysqli_free_result($result);
        $this->CloseConnect();
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    
    public function update(){
        
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $idPelicula=$this->idPelicula;
        $TituloPelicula=$this->TituloPelicula;
        $Anio=$this->Anio;
        $Director=$this->Director;
        $cartel=$this->cartel;
        
        if ($cartel =="") { $cartel ="view/img/default.png";}
        
        $sql="CALL spUpdatePelicula($idPelicula,'$TituloPelicula',$Anio,$Director,'$cartel')";
        
        if ($this->link->query($sql))  // true if success
        //$this->link->affected_rows;  number of inserted rows
        {
            return "updated.Num de updates: ".$this->link->affected_rows;
        } else {
            return "Error al modificar";
        }
        
        $this->CloseConnect();
    }
    
}
?>
=======

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
