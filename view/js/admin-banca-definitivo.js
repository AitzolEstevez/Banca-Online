document.addEventListener("DOMContentLoaded", function (event) {

    loadPagina();

});

/*Variable Global
-------------*/
cuenta = "";

/*LoadPagina
------------------------------------------------------------------------------------------------*/
function loadPagina() {

    var url = "../../controller/controller_Extractos.php";

    fetch(url, {
        method: 'GET', // or 'POST'
    })
        .then(res => res.json()).then(result => {

            var clientes = result.listClientes;
            var proveedores = result.listProveedores;
            var stock = result.listStock;
            var cuentas = result.listCuentas;

            cuenta = cuentas;

            console.log(result);

            document.querySelector(".btnBanca").addEventListener("click", function () {
                BancaOnlineload(cuentas);
            });
            document.querySelector(".btnFactura").addEventListener("click", function () {
                Proveedorload(proveedores, cuentas);
            });
            document.querySelector(".btnStock").addEventListener("click", function () {
                MiStockload(stock);
            });
            document.querySelector(".btnPrestamo").addEventListener("click", loadPrestamo);
            document.querySelector(".btnLeasing").addEventListener("click", loadLeasing);


        })
        .catch(error => console.error('Error status:', error));

}

/*BancaOnlineload
------------------------------------------------------------------------------------------------*/
function BancaOnlineload(cuentas) {

    document.querySelector(".table").innerHTML = "";

    var newRow = "";
    newRow += "<thead>";
    newRow += "<tr>";
    newRow += "<th><span>FECHA</span></th>";
    newRow += "<th><span>CONCEPTO</span></th>";
    newRow += "<th><span>IMPORTE</span></th>";
    newRow += "<th><span>SALDO</span></th>";
    newRow += "</tr>";
    newRow += "</thead>";

    document.querySelector(".table").innerHTML = newRow;

    document.querySelector(".itfDefault").style.display = "none";
    document.querySelector(".itfFactura").style.display = "none";
    document.querySelector(".itfStock").style.display = "none";
    document.querySelector(".itfBanca").style.display = "block";


    /*Tabla
    -----------------------------------------------------------------------*/
    document.querySelector(".tabla").className = "col-xl-12 col-md-12 tabla";
    document.querySelector(".tabla").style.transition = "0.3s";
    document.querySelector(".leasing").style.display = "none";
    document.querySelector(".prestamo").style.display = "none";


    /*ComboCuentas
    -----------------------------------------------------------------------*/
    var newRow = "";
    newRow += "<option value=-1>Selecciona una cuenta</option>";

    for (let i = 0; i < cuentas.length; i++) {

        newRow += "<option value='" + cuentas[i].idCuentas + "'>" + cuentas[i].numcuenta + "</option>";
    }

    document.getElementById("SelectCuentas").innerHTML = newRow;

}

/*ExtractoCuentasById
-----------------------------------------------------------------------*/
document.getElementById("SelectCuentas").addEventListener("change", function () {

    var combo = document.getElementById("SelectCuentas");
    var selected = combo.options[combo.selectedIndex].value;
    selected = selected - 1;

    valor = document.getElementById("SelectCuentas").value;

    /*Datos
    ----------------------------------------------------------------------------------------------------------------*/
    if (selected == -2) {
        document.querySelector(".itfBanca2").style.display = "none";
        document.querySelector(".numCuenta").innerHTML = "<span class='text-muted m-r-5'>Número Cuenta:</span><br>-";
        document.querySelector(".tipoCuenta").innerHTML = "<span class='text-muted m-r-5'>Cuenta:</span>-";
        document.querySelector(".numeroCuenta").innerHTML = "<br>";
        document.querySelector(".saldo").innerHTML = "€-";

    } else {
        document.querySelector(".itfBanca2").style.display = "flex";
        document.querySelector(".numCuenta").innerHTML = "<span class='text-muted m-r-5'>Número Cuenta:</span><br>" + cuenta[selected].numcuenta;
        document.querySelector(".tipoCuenta").innerHTML = "<span class='text-muted m-r-5'>Cuenta:</span>" + cuenta[selected].tipo;
        document.querySelector(".numeroCuenta").innerHTML = cuenta[selected].numcuenta;
        document.querySelector(".saldo").innerHTML = "€" + cuenta[selected].saldo;
    }

    var url = "../../controller/controller_ExtractoCuenta.php";

    var data = { 'numcuenta': valor };

    fetch(url, {
        method: 'POST', // or 'POST'
        body: JSON.stringify(data),
        headers: { 'Content-Type': 'application/json' }  //input data
    })
        .then(res => res.json()).then(result => {

            var extracto = result.listExtracto;

            var newRow = "";
            newRow += "<thead>";
            newRow += "<tr>";
            newRow += "<th><span>FECHA</span></th>";
            newRow += "<th><span>CONCEPTO</span></th>";
            newRow += "<th><span>IMPORTE</span></th>";
            newRow += "<th><span>SALDO</span></th>";
            newRow += "</tr>";
            newRow += "</thead>";
            newRow += "<tbody>";

            for (let i = 0; i < extracto.length; i++) {

                newRow += "<tr>" + "<td>" + extracto[i].fecha + "</td>";
                newRow += "<td>" + extracto[i].concepto + "</td>";

                if (extracto[i].importe > 0) {
                    newRow += "<td style='color:#15D800;'>+" + extracto[i].importe + "</td>";
                } else if (extracto[i].importe < 0) {
                    newRow += "<td style='color:red;'>" + extracto[i].importe + "</td>";
                }

                if (extracto[i].saldo > 0) {
                    newRow += "<td>" + extracto[i].saldo + "</td></tr>";
                } else if (extracto[i].saldo < 0) {
                    newRow += "<td style='color:red;'>" + extracto[i].saldo + "</td></tr>";
                } else {
                    newRow += "<td>" + extracto[i].saldo + "</td></tr>";
                }

            }

            newRow += "</tbody>";

            document.querySelector(".table").innerHTML = newRow;

        })
        .catch(error => console.error('Error status:', error));
});

/*Añadir Fondos
-----------------------------------------------------------------------*/
document.querySelector(".inputCantidad input").addEventListener("keyup", function () {

    event.preventDefault();
    if (event.keyCode === 13) {
        var añadirfondos = 1;
        var realizarpedido = 0;

        var fondos = document.querySelector(".inputCantidad input").value;
        var cuenta = document.getElementById("SelectCuentas").value;

        var url = "../../controller/controller_insert.php";

        var data = { 'total': fondos, 'cuenta': cuenta, 'selected': 'Ingreso', 'añadirfondos': añadirfondos, 'realizarpedido': realizarpedido };

        fetch(url, {
            method: 'POST', // or 'POST'
            body: JSON.stringify(data),
            headers: { 'Content-Type': 'application/json' }  //input data
        }).then(res => res.json()).then(result => {

            Swal.fire(
                'Fondos añadidos correctamente',
                '',
                'success'
            )


        }).catch(error => console.error('Error status:', error));
    }
});

/*Proveedorload
------------------------------------------------------------------------------------------------*/
function Proveedorload(proveedores, cuentas) {
    document.querySelector(".itfDefault").style.display = "none";
    document.querySelector(".itfStock").style.display = "none";
    document.querySelector(".itfBanca").style.display = "none";
    document.querySelector(".itfBanca2").style.display = "none";
    document.querySelector(".itfFactura").style.display = "block";

    /*Tabla
    -----------------------------------------------------------------------*/
    document.querySelector(".tabla").className = "col-xl-12 col-md-12 tabla";
    document.querySelector(".tabla").style.transition = "0.3s";
    document.querySelector(".leasing").style.display = "none";
    document.querySelector(".prestamo").style.display = "none";

    /*ExtractoFacturas
    -----------------------------------------------------------------------*/
    var newRow = "";
    newRow += "<thead>";
    newRow += "<tr>";
    newRow += "<th><span>FECHA</span></th>";
    newRow += "<th><span>NUMERO FACTURA</span></th>";
    newRow += "<th><span>NUMERO CUENTA</span></th>";
    newRow += "<th><span>PROVEEDOR</span></th>";
    newRow += "<th><span>PRODUCTO</span></th>";
    newRow += "<th><span>PRECIO/UD</span></th>";
    newRow += "<th><span>CANTIDAD</span></th>";
    newRow += "<th><span>IMPORTE</span></th>";
    newRow += "</tr>";
    newRow += "</thead>";
    newRow += "<tbody>";

    for (let i = 0; i < proveedores.length; i++) {

        newRow += "<tr>";
        newRow += "<td>" + proveedores[i].fecha + "</td>";
        newRow += "<td>" + proveedores[i].numerofactura + "</td>";
        newRow += "<td>" + proveedores[i].idcuenta + "</td>";
        newRow += "<td>" + proveedores[i].nombre + "</td>";
        newRow += "<td>" + proveedores[i].idproducto + "</td>";
        newRow += "<td>" + proveedores[i].precio + "</td>";
        newRow += "<td>" + proveedores[i].cantidad + "</td>";
        newRow += "<td>" + proveedores[i].importe + "</td>";
        newRow += "</tr>";
    }

    newRow += "</tbody>";

    document.querySelector(".table").innerHTML = newRow;

    var newRow2 = "";
    newRow2 += "<!-- Button trigger modal -->"
        + "<button type='button' class='btn btn-primary' id='btnProveedor' data-bs-toggle='modal' data-bs-target='#exampleModal'>"
        + "<h6 class='m-b-5 text-white'>Realizar Pedido</h6>"
        + "</button>"

        + "<!-- Modal -->"
        + "<div class='modal fade' id='exampleModal' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>"
        + "<div class='modal-dialog modal-lg'>"
        + "<div class='modal-content'>"
        + "<div class='modal-header'>"
        + "<h1 class='modal-title' id='exampleModalLabel'>Pedido</h1>"
        + "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>"
        + "</div>"
        + "<div class='modal-body'>"
        + "<div style='display:flex;'>"
        + "<div style='width:40%; padding:10px;'>"
        + "<img id='modalImg' width='100%' height='100%' src=''>"
        + "</div>"
        + "<div style='width:60%; padding:10px;'>"
        + "<h3>Cuenta</h3>"
        + "<div id='Cuentas2'></div>"
        + "<h3>Proveedor</h3>"
        + "<div id='Proveedores2'></div>"
        + "<h3>Producto</h3>"
        + "<div id='Productos'></div>"
        + "</div>"
        + "</div>"
        + "<div id='modalFlex'><div>"
        + "<h3>Precio/Ud</h3>"
        + "<input id='Precio' type='text' disabled class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm'>"
        + "</div>"
        + "<div>"
        + "<h3>Cantidad</h3>"
        + "<input type='text' id='Cantidad' class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm' onkeypress='return onlyNumberKey(event)'>"
        + "</div>"
        + "</div>"
        + "<h3>Total</h3>"
        + "<input type='text' id='Total' disabled class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm'>"
        + "</div>"
        + "<div class='modal-footer'>"
        + "<button type='button' id='btnCancelar' class='btn btn-secondary' data-bs-dismiss='modal'>Cancelar</button>"
        + "<button type='button' id='btnPedido' class='btn btn-primary' data-bs-dismiss='modal'>Hacer pedido</button>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"

    document.querySelector(".btnPedir").innerHTML = newRow2;

}

/*MiStockload
------------------------------------------------------------------------------------------------*/
function MiStockload(stock) {
    document.querySelector(".itfDefault").style.display = "none";
    document.querySelector(".itfBanca").style.display = "none";
    document.querySelector(".itfBanca2").style.display = "none";
    document.querySelector(".itfFactura").style.display = "none";
    document.querySelector(".itfStock").style.display = "block";

    /*Tabla
    -----------------------------------------------------------------------*/
    document.querySelector(".tabla").className = "col-xl-12 col-md-12 tabla";
    document.querySelector(".tabla").style.transition = "0.3s";
    document.querySelector(".leasing").style.display = "none";
    document.querySelector(".prestamo").style.display = "none";

    /*ExtractoStock
    -----------------------------------------------------------------------*/
    var newRow = "";
    newRow += "<thead>";
    newRow += "<tr>";
    newRow += "<th><span>PRODUCTO</span></th>";
    newRow += "<th><span>PRECIO</span></th>";
    newRow += "<th><span>STOCK</span></th>";
    newRow += "</tr>";
    newRow += "</thead>";
    newRow += "<tbody>";

    for (let i = 0; i < stock.length; i++) {

        newRow += "<tr>";
        newRow += "<td>" + stock[i].producto + "</td>";
        newRow += "<td>" + stock[i].precio + "</td>";
        newRow += "<td>" + stock[i].stock + "</td>";
        newRow += "</tr>";
    }

    newRow += "</tbody>";

    document.querySelector(".table").innerHTML = newRow;

}

/*loadPrestamo
------------------------------------------------------------------------------------------------*/
function loadPrestamo() {

    /*Tabla
    -----------------------------------------------------------------------*/
    document.querySelector(".tabla").className = "col-xl-8 col-md-6 tabla";
    document.querySelector(".tabla").style.transition = "0.3s";
    document.querySelector(".leasing").style.display = "none";
    document.querySelector(".prestamo").style.display = "block";


}

/*loadLeasing
------------------------------------------------------------------------------------------------*/
function loadLeasing() {

    /*Tabla
    -----------------------------------------------------------------------*/
    document.querySelector(".tabla").className = "col-xl-8 col-md-6 tabla";
    document.querySelector(".tabla").style.transition = "0.3s";
    document.querySelector(".prestamo").style.display = "none";
    document.querySelector(".leasing").style.display = "block";


}

/*Solo Numeros
------------------------------------------------------------------------------------------------*/
function onlyNumberKey(evt) {

    // Only ASCII character in that range allowed
    var ASCIICode = (evt.which) ? evt.which : evt.keyCode
    if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
        return false;
    return true;
}