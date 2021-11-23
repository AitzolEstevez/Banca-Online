document.addEventListener("DOMContentLoaded", function (event) {

    loadPágina();

});

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

        document.querySelector(".btnBanca").addEventListener("click",BancaOnlineload(cuentas));
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
    console.log(cuentas); 
    var newRow ="";
    newRow += "<option value=-1>Selecciona una cuenta</option>";
    
    for (let i = 0; i < cuentas.length; i++) {
            
        newRow += "<option value='"+cuentas[i].idCuentas+"'>"+cuentas[i].numcuenta+"</option>";
    }
    
    document.getElementById("SelectCuentas").innerHTML = newRow;

    document.getElementById("SelectCuentas").addEventListener("change",function(){

      console.log(
          this.
      );

    });

}

/*Proveedorload
------------------------------------------------------------------------------------------------*/

function Proveedorload(){
    document.querySelector(".itfDefault").style.display="none";
    document.querySelector(".itfStock").style.display="none";
    document.querySelector(".itfBanca").style.display="none";
    document.querySelector(".itfFactura").style.display="block";
}

/*MiStockload
------------------------------------------------------------------------------------------------*/

function MiStockload(){
    document.querySelector(".itfDefault").style.display="none";
    document.querySelector(".itfBanca").style.display="none";
    document.querySelector(".itfFactura").style.display="none";
    document.querySelector(".itfStock").style.display="block";
}