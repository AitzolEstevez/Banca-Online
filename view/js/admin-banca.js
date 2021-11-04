// function rellenar() {

//     var izena = document.getElementById('Izena').value;
//     var abizena = document.getElementById('Abizena').value;
//     var nota = document.getElementById('Nota').value;

//     document.getElementById('hemen').innerHTML+="<tr>"+"<td>"+izena+"</td>"+"<td>"+abizena+"</td>"+"<td>"+nota+"</td>"+ "</tr>";

//     document.getElementById('Izena').value = "";
//     document.getElementById('Abizena').value = "";
//     document.getElementById('Nota').value = "";
// }

//Enviar e insertar el valor del DateTime en base de datos (NO TESTEADO)

// $(function () {
//     var today = new Date();
//     var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
//     var time = today.getHours() + ":" + today.getMinutes();
//     var dateTime = date+' '+time;
//     $("#form_datetime").datetimepicker({
//         format: 'yyyy-mm-dd hh:ii',
//         autoclose: true,
//         todayBtn: true,
//         startDate: dateTime
//     });
// });

document.addEventListener("DOMContentLoaded", function (event) {

    loadExtracto();

});

function loadExtracto(){

    var url = "controller/controller_Extractos.php";

	fetch(url, {
	  method: 'GET', // or 'POST'
	})
	.then(res => res.json()).then(result => {

		var clientes = result.listClientes;
		var proveedores = result.listProveedores;
		var stock = result.listStock;
		var cuentas = result.listCuentas;
		
		
		var newRow ="";
		newRow += "<option>Selecciona una cuenta</option>";
		
		for (let i = 0; i < cuentas.length; i++) {
				
			newRow += "<option value='"+cuentas[i].numcuenta+"'>"+cuentas[i].numcuenta+"</option>";
		}
		
		newRow +="</table>";   
		document.getElementById("SelectCuentas").innerHTML = newRow;
		
		document.getElementById("SelectCuentas").addEventListener("change", BancaOnlineload());
			
			
		
		console.log('Success:', clientes);

		//////////////////////////////////////////////////////////////////////////////////

		tabs=document.querySelectorAll("#myTab li button");

		for (let i = 0; i < tabs.length; i++) {
			tabs[i].addEventListener("click", function(){

				valor=tabs[i].id;

				console.log(valor);
				if(valor=="Clientes"){
					Clienteload();
				}else if(valor=="Proveedores"){
					Proveedorload();
				}else if(valor=="MiStock"){
					MiStockload();
				}else{
					BancaOnlineload();
				}
				
				if(valor=="BancaOnline"){
					document.getElementById("FlexBancaOnline").style.display="flex";
				}else{
					document.getElementById("FlexBancaOnline").style.display="none";
				}

			});
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////
		
		function Clienteload(){
			var newRow ="";
			newRow +="<table> ";
			newRow +="<tr><th>Fecha</th><th>Numero Factura</th><th>Cliente</th><th>Numero Cuenta</th><th>Producto</th><th>Precio/u</th><th>Cantidad</th><th>Importe</th></tr>";
			
			for (let i = 0; i < clientes.length; i++) {
					
				newRow += "<tr>" +"<td>"+clientes[i].fecha+"</td>"
									+"<td>"+clientes[i].numerofactura+"</td>"
									+"<td>"+clientes[i].nombre+"</td>"
									+"<td>"+clientes[i].idcuenta+"</td>"
									+"<td>"+clientes[i].idproducto+"</td>"
									+"<td>"+clientes[i].precio+"</td>"
									+"<td>"+clientes[i].cantidad+"</td>"
									+"<td>"+clientes[i].importe+"</td>"
								+"</tr>";	
			}
			newRow +="</table>";   
			document.getElementById("tabla").innerHTML = newRow;
			document.getElementById("tabla").style.display="block";			
		}
		
		//////////////////////////////////////////////////////////////////////////////////

		function Proveedorload(){
			var newRow ="";
			newRow +="<table> ";
			newRow +="<tr><th>Fecha</th><th>Numero Factura</th><th>Proveedor</th><th>Producto</th><th>Precio/u</th><th>Cantidad</th><th>Importe</th></tr>";
			
			for (let i = 0; i < proveedores.length; i++) {
					
				newRow += "<tr>" +"<td>"+proveedores[i].fecha+"</td>"
									+"<td>"+proveedores[i].numerofactura+"</td>"
									+"<td>"+proveedores[i].nombre+"</td>"
									+"<td>"+proveedores[i].idproducto+"</td>"
									+"<td>"+proveedores[i].precio+"</td>"
									+"<td>"+proveedores[i].cantidad+"</td>"
									+"<td>"+proveedores[i].importe+"</td>"
								+"</tr>";	
			}
			newRow +="</table>";   
			document.getElementById("tabla").innerHTML = newRow;	
			document.getElementById("tabla").style.display="block";
		}
		
		//////////////////////////////////////////////////////////////////////////////////
		
		function MiStockload(){
			var newRow ="";
			newRow +="<table> ";
			newRow +="<tr><th>Producto</th><th>Precio/u</th><th>Stock</th></tr>";
			
			for (let i = 0; i < stock.length; i++) {
					
				newRow += "<tr>" +"<td>"+stock[i].producto+"</td>"
									+"<td>"+stock[i].precio+"</td>"
									+"<td>"+stock[i].stock+"</td>"
								+"</tr>";	
			}
			newRow +="</table>";   
			document.getElementById("tabla").innerHTML = newRow;
			document.getElementById("tabla").style.display="block";
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////
		
		function BancaOnlineload(){
			
			document.getElementById("tabla").style.display="none";
			
			var newRow ="";
			newRow += "<option>Selecciona una cuenta</option>";
			
			for (let i = 0; i < cuentas.length; i++) {
					
				newRow += "<option value='"+cuentas[i].numcuenta+"'>"+cuentas[i].numcuenta+"</option>";
			}
			
			newRow +="</table>";   
			document.getElementById("SelectCuentas").innerHTML = newRow;
			
			document.getElementById("SelectCuentas").addEventListener("change", function(){
				valor=document.getElementById("SelectCuentas").value;
				console.log(valor);
			

			    var url = "controller/controller_ExtractoCuenta.php";

				var data = { 'numcuenta':valor};

				fetch(url, {
				  method: 'GET', // or 'POST'
				  body: JSON.stringify(data)
				})
				.then(res => res.json()).then(result => {
				
					var extracto = result.listExtracto;
				
					var newRow ="";
					newRow +="<table> ";
					newRow +="<tr><th>Fecha</th><th>Concepto/u</th><th>Importe</th><th>Saldo</th></tr>";
					
					for (let i = 0; i < extracto.length; i++) {
							
						newRow += "<tr>" +"<td>"+extracto[i].fecha+"</td>"
											+"<td>"+extracto[i].concepto+"</td>"
											+"<td>"+extracto[i].importe+"</td>"
											+"<td>"+extracto[i].saldo+"</td>"
										+"</tr>";	
					}
					newRow +="</table>";   
					document.getElementById("tabla").innerHTML = newRow;
					document.getElementById("tabla").style.display="block";
				
					
				})
				.catch(error => console.error('Error status:', error));	
			
			});
						
		}
		


	})
	.catch(error => console.error('Error status:', error));	


}