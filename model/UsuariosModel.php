<?php
/*
if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{*/
if ($_SERVER['SERVER_NAME'] == "lau.zerbitzaria.net") {
    include_once ("connect_data_SERV.php");
} else {
    include_once ("connect_data_LOCAL.php");
}

include_once("UsuariosClass.php");

class UsuariosModel extends UsuariosClass
{

    public $link;

    public function OpenConnect()
    {}

    public function CloseConnect()
    {
        // mysqli_close ($this->link);
    }

    public function finduser(){
        $this->OpenConnect();

        $nombre=$this->nombre;
        $contrasena=$this->contrasena;

        $sql="select * from usuarios where nombre='$nombre' && contrasena='$contrasena'";
        $result= $this->link->query($sql);

        $userExists=false;
        
        if ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){ 
           /* if ($contrasena==$row['contrasena']){
                $this->tipo=$row['tipo'];
                
            }*/                
            $userExists=true;

        }
        return $userExists;
        mysqli_free_result($result);
        $this->CloseConnect();


    }

    public function findadmin(){
        $this->OpenConnect();

        $nombre=$this->nombre;
        $contrasena=$this->contrasena;

        $sql="select * from usuarios where nombre='$nombre' && contrasena='$contrasena' && tipo = 1;";
        $result= $this->link->query($sql);

        $userAdmin = false;

        if ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){ 
            $userAdmin = true;
        }

        return $userAdmin;
        mysqli_free_result($result);
        $this->CloseConnect();


    }


}

