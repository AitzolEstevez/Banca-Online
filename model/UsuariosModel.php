<?php


if($_SERVER['SERVER_NAME']=="lau.zerbitzaria.net"){
    include_once ("connect_data_SERV.php");
}else{
    include_once ("connect_data_LOCAL.php");
}



class UsuariosModel extends UsuariosClass{

    public function OpenConnect(){

    }

    public function CloseConnect()
    {
        //mysqli_close ($this->link);
    }
}