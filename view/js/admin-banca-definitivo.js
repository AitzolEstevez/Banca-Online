document.addEventListener("DOMContentLoaded", function (event) {

    loadPágina();

});

var cuenta="";

function loadPágina(){

    var url = "../../controller/controller_Extractos.php";

	fetch(url, {
	  method: 'GET', // or 'POST'
	})
	.then(res => res.json()).then(result => {

		var clientes = result.listClientes;
		var proveedores = result.listProveedores;
		var stock = result.listStock;
		var cuentas = result.listCuentas;

        cuenta=cuentas;

        document.querySelector(".btnBanca").addEventListener("click",function(){
            BancaOnlineload(cuenta);
        });
        document.querySelector(".btnFactura").addEventListener("click",Proveedorload);
        document.querySelector(".btnStock").addEventListener("click",MiStockload);

    })
	.catch(error => console.error('Error status:', error));	

}

/*BancaOnlineload
------------------------------------------------------------------------------------------------*/

function BancaOnlineload(cuentas){

    document.querySelector(".itfDefault").style.display="none";
    document.querySelector(".itfFactura").style.display="none";
    document.querySelector(".itfStock").style.display="none";
    document.querySelector(".itfBanca").style.display="block";
    document.querySelector(".itfBanca2").style.display="flex";

    var newRow ="";
    newRow += "<option value=-1>Selecciona una cuenta</option>";
    
    for (let i = 0; i < cuentas.length; i++) {
            
        newRow += "<option value='"+i+"'>"+cuentas[i].numcuenta+"</option>";
    }
    
    document.getElementById("SelectCuentas").innerHTML = newRow;

    document.getElementById("SelectCuentas").addEventListener("change",function(){

        var combo = document.getElementById("SelectCuentas");
        var selected = combo.options[combo.selectedIndex].value;

        console.log(selected);

        if (selected==-1) {
            document.querySelector(".numCuenta").innerHTML="<span class='text-muted m-r-5'>Número Cuenta:</span><br>-";
            document.querySelector(".tipoCuenta").innerHTML="<span class='text-muted m-r-5'>Cuenta:</span>-";
            document.querySelector(".numeroCuenta").innerHTML="<br>";
            document.querySelector(".saldo").innerHTML="€-";
        }else{
            document.querySelector(".numCuenta").innerHTML="<span class='text-muted m-r-5'>Número Cuenta:</span><br>"+cuentas[selected].numcuenta;
            document.querySelector(".tipoCuenta").innerHTML="<span class='text-muted m-r-5'>Cuenta:</span>"+cuentas[selected].tipo;
            document.querySelector(".numeroCuenta").innerHTML=cuentas[selected].numcuenta;
            document.querySelector(".saldo").innerHTML="€"+cuentas[selected].saldo;
        }

    });

}

/*Proveedorload
------------------------------------------------------------------------------------------------*/

function Proveedorload(){
    document.querySelector(".itfDefault").style.display="none";
    document.querySelector(".itfStock").style.display="none";
    document.querySelector(".itfBanca").style.display="none";
    document.querySelector(".itfBanca2").style.display="none";
    document.querySelector(".itfFactura").style.display="block";

}

/*MiStockload
------------------------------------------------------------------------------------------------*/

function MiStockload(){
    document.querySelector(".itfDefault").style.display="none";
    document.querySelector(".itfBanca").style.display="none";
    document.querySelector(".itfBanca2").style.display="none";
    document.querySelector(".itfFactura").style.display="none";
    document.querySelector(".itfStock").style.display="block";
}