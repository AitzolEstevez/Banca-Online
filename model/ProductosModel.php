<?php
if ($_SERVER['SERVER_NAME'] == "lau.zerbitzaria.net") {
    include_once ("connect_data_SERV.php");
} else {
    include_once ("connect_data_LOCAL.php");
}

include_once ("ProductosClass.php");

// ////////////////////////////////////////////////////////////////////////////////////////////
class ProductosModel extends ProductosClass
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

    // ////////////////////////////////////////////////////////////////////////////////////////////
    public function setListEProductosByProveedor($proveedor)
    {
        $this->OpenConnect(); // konexio zabaldu - abrir conexiÃ³n

        $sql = "CALL SelectAllProductosByProveedor($proveedor)"; // SQL sententzia - sentencia SQL

        $result = $this->link->query($sql);

        // $this->link->num_rows; num rows of result

        $list = array();

        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) { // each row

            $nuevo = new ProductosModel();

            $nuevo->id = $row['id'];
            $nuevo->nombre = $row['nombre'];
            $nuevo->precio = $row['precio'];
            $nuevo->img = $row['img'];

            array_push($list, $nuevo);
        }
        mysqli_free_result($result);
        $this->CloseConnect();
        return $list;
    }
}

?>