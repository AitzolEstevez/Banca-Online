<?php
if ($_SERVER['SERVER_NAME'] == "lau.zerbitzaria.net") {
    include_once ("connect_data_SERV.php");
} else {
    include_once ("connect_data_LOCAL.php");
}

include_once ("MiStockClass.php");

// ////////////////////////////////////////////////////////////////////////////////////////////
class MiStockModel extends MiStockClass
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

    //////////////////////////////////////////////////////////////////////////////////////////////
    public function setListMiStock()
    {
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $sql = "CALL SelectAllMiStock()"; // SQL sententzia - sentencia SQL

        $result = $this->link->query($sql);

        // $this->link->num_rows; num rows of result

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { // each row

            $newStock = new MiStockModel();

            $newStock->id = $row['id'];
            $newStock->producto = $row['producto'];
            $newStock->precio = $row['precio'];
            $newStock->stock = $row['stock'];

            array_push($list, $newStock);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }

    //////////////////////////////////////////////////////////////////////////////////////////////

    public function updateMiStock(){
        $this->OpenConnect();

        $idproducto=$this->idproducto;
        $stock=$this->stock;
        $precio=$this->precio;
        $img=$this->img;

        $sql="select * from mistock where idproducto=$idproducto";
        $result= $this->link->query($sql);

        
        if ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){ 
           
            $sql = "CALL updateStock($stock,$idproducto)";
            $this->link->query($sql);
            return "Numero de stocks actualizados";

        }else{

            $sql = "CALL insertStock($idproducto,$precio,$stock,$img)";
            $this->link->query($sql);
            return "Nuevo producto insertado al inventario";
        }

        $this->CloseConnect();

    }
}