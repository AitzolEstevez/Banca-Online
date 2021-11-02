<?php
include_once ("connect_data.php");  // klase honetan gordetzen dira datu basearen datuak. erabiltzailea...
include_once("peliculaClass.php");
include_once("directorModel.php");

class peliculaModel extends peliculaClass {
    
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
    
    public function setList()
    {
        $this->OpenConnect();  // konexio zabaldu  - abrir conexiÃ³n
        
        $sql = "CALL spAllFilms()"; // SQL sententzia - sentencia SQL
        
        $result = $this->link->query($sql); 
        
        //$this->link->num_rows; num rows  of result
        
        $list=array();
        
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { //each row
            
            $newPeli=new FacturaClass();
            
            $newPeli->idPelicula=$row['idPelicula'];
            $newPeli->TituloPelicula=$row['TituloPelicula'];
            $newPeli->Anio=$row['Anio'];
            $newPeli->Director=$row['Director'];
            $newPeli->cartel=$row['cartel'];
            
            $director=new directorModel();
            $director->idDirector=$row['Director'];
            $director->findIdDirector();
            
            $newPeli->objDirector=$director;
     
            array_push($list, $newPeli);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }
    
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