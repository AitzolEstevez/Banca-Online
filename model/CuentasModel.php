<?php

if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{
    include_once ("connect_data_LOCAL.php");
}

include_once("CuentasClass.php");

class CuentasModel extends CuentasClass{

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

        $sql = "CALL spAllCuentas";

        $result = $this->link->query($sql);

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $new=new peli_class();
            
            $new->setIdPelicula($row['idPelicula']);
            $new->setTituloPelicula($row['TituloPelicula']);
            $new->setAnio($row['Anio']);
            $new->setDirector($row['Director']);
            $new->setCartel($row['cartel']);
            
            array_push($list, $new);
        }
        
    }

}