<?php

if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{
    include_once ("connect_data_LOCAL.php");
}

include_once("UsuariosClass.php");

class UsuariosModel extends UsuariosClass{
    
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

    public function finduser(){
        $this->OpenConnect();

        $nombre=$this->nombre;
        $contrasena=$this->contrasena;

        $sql="SELECT * FROM 'usuarios' WHERE 'nombre'='$nombre' && 'contraseña'='$contrasena'";
        $result= $this->link->query($sql);

        $userExists=false;
        
        if ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){ 
            if ($contrasena==$row['contrasena']){
                $this->tipo=$row['tipo'];
                
                $userExists=true;
            }
        }
        return $userExists;
        mysqli_free_result($result);
        $this->CloseConnect();


    }


}