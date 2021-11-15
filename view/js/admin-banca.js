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
				
			newRow += "<option value='"+cuentas[i].idCuentas+"'>"+cuentas[i].numcuenta+", "+cuentas[i].tipo+"</option>";
		}
		
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
			document.getElementById("btnRealizarPedido").style.display="none";	
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
			
			
			var newRow2 ="";
			
			newRow2 +="<!-- Button trigger modal -->"
          	+"<button type='button' class='btn btn-primary' id='btnProveedor' data-bs-toggle='modal' data-bs-target='#exampleModal'>"
            	+"Hacer pedido"
          	+"</button>"

          	+"<!-- Modal -->"
	          +"<div class='modal fade' id='exampleModal' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>"
	            +"<div class='modal-dialog modal-lg'>"
	              +"<div class='modal-content'>"
	                +"<div class='modal-header'>"
	                  +"<h1 class='modal-title' id='exampleModalLabel'>Pedido</h1>"
	                  +"<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>"
	                +"</div>"
	                +"<div class='modal-body'>"
					+"<div style='display:flex;'>"
					  +"<div style='width:40%; padding:10px;'>"
					  +"<img id='modalImg' width='100%' height='100%' src='view/img/placeholder.png'>"
					  +"</div>" 
					  +"<div style='width:60%; padding:10px;'>"
					  +"<h3>Cuenta</h3>"
					  +"<div id='Cuentas2'></div>"
	                  +"<h3>Proveedor</h3>"
					  +"<div id='Proveedores2'></div>"
					  +"<h3>Producto</h3>"
					  +"<div id='Productos'></div>"
					  +"</div>"
					+"</div>"
	                  +"<div id='modalFlex'><div>"
					  +"<h3>Precio/Ud</h3>"
					  +"<input id='Precio' type='text' disabled class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm'>"
					  +"</div>"
					  +"<div>"
					  +"<h3>Cantidad</h3>"
					  +"<input type='text' id='Cantidad' class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm' onkeypress='return onlyNumberKey(event)'>"
					  +"</div>"
	                  +"</div>"
	                  +"<h3>Total</h3>"
	                  +"<input type='text' id='Total' disabled class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm'>"
					  +"</div>"
					  +"<div class='modal-footer'>"
	                  +"<button type='button' id='btnCancelar' class='btn btn-danger' data-bs-dismiss='modal'>Cancelar</button>"
	                  +"<button type='button' id='btnPedido' class='btn btn-primary' data-bs-dismiss='modal'>Hacer pedido</button>"
					  +"</div>"
					  +"</div>"
					  +"</div>"
					  +"</div>"

					document.getElementById("btnRealizarPedido").style.display="block";
					document.getElementById("btnRealizarPedido").innerHTML = newRow2;	

					document.getElementById("btnCancelar").addEventListener("click",function(){
						Cancelar();
					});

					document.querySelector(".btn-close").addEventListener("click",function(){
						Cancelar();
					});

					/*document.getElementById("btnPedido").addEventListener("click",function(){
						Confirmacion();
					});*/

					document.getElementById("btnProveedor").addEventListener("click",function(){
						
						var newRow ="";
						newRow += "<select class='modalCombo' id='SelectCuentas2' style='width:100%;' class='form-select' aria-label='Default select example'>";
						newRow +="<option selected value=-1>Selecciona una cuenta</option>";

						for (let i = 0; i < cuentas.length; i++) {
								
							newRow +="<option value='"+cuentas[i].idCuentas+"'>"+cuentas[i].numcuenta+"</option>";
						}

						newRow +="</select>";

						console.log(newRow);

						document.getElementById("Cuentas2").innerHTML=newRow;

						document.getElementById("Cantidad").value="";
						document.getElementById("Total").value="";
						document.getElementById("Precio").value="";
						document.getElementById("modalImg").src="view/img/placeholder.png";

						var url = "controller/controller_Proveedores.php";
		
						fetch(url, {
						  method: 'GET', // or 'POST'
						})
						.then(res => res.json()).then(result => {
												
							var proveedor = result.listProveedores;

							var newRow ="";
							newRow += "<select class='modalCombo' id='SelectProveedor' style='width:100%;' class='form-select' aria-label='Default select example'>";
							newRow +="<option selected value=-1>Selecciona un proveedor</option>";

							
							for (let i = 0; i < proveedor.length; i++) {
									
								newRow +="<option value='"+proveedor[i].id+"'>"+proveedor[i].nombre+"</option>";
							}

							newRow +="</select>";

							document.getElementById("Proveedores2").innerHTML = newRow;
						
							
						})
						.catch(error => console.error('Error status:', error));	

							var newRow ="";
							newRow += "<select class='modalCombo' id='SelectProducto' style='width:100%;' class='form-select' aria-label='Default select example'>";
							newRow +="<option selected value=-1>Selecciona un producto</option>";

							newRow +="</select>";

							document.getElementById("Productos").innerHTML = newRow;


						document.getElementById("Proveedores2").addEventListener("change",function(){

							if (document.getElementById("Proveedores2").value=-1) {
								document.getElementById("Total").value="";
								document.getElementById("Cantidad").value="";
								document.getElementById("Precio").value="";
								document.getElementById("modalImg").src="view/img/placeholder.png";		
							}

							valor=document.getElementById("SelectProveedor").value;

							console.log(valor);

							var url = "controller/controller_Productos.php";

							var data = { 'proveedor':valor};
			
							fetch(url, {
							  method: 'POST', // or 'POST'
							  body: JSON.stringify(data),
								headers:{'Content-Type': 'application/json'}  //input data
							})
							.then(res => res.json()).then(result => {
														
								var productos = result.listProductos;
							
								var newRow ="";
								newRow += "<select class='modalCombo' id='SelectProducto' style='width:100%;' class='form-select' aria-label='Default select example'>";
								newRow +="<option selected value=-1>Selecciona un producto</option>";
	
								
								for (let i = 0; i < productos.length; i++) {
										
									newRow +="<option value='"+productos[i].id+"'>"+productos[i].nombre+"</option>";
									index=i;
								}
	
								newRow +="</select>";
	
								document.getElementById("Productos").innerHTML = newRow;
							
								document.getElementById("SelectProducto").addEventListener("change",function(){

									document.getElementById("modalImg").src=productos[index].img;
									precio=document.getElementById("Precio").value=productos[index].precio;

									if (document.getElementById("SelectProducto").value==-1) {
										document.getElementById("Total").value="";
										document.getElementById("Cantidad").value="";
										document.getElementById("Precio").value="";
										document.getElementById("modalImg").src="view/img/placeholder.png";				
									}

	
								});

								document.getElementById("Cantidad").addEventListener("keyup",function(){

									cantidad=document.getElementById("Cantidad").value;

									document.getElementById("Total").value=cantidad*precio;

								});

								
							})
							.catch(error => console.error('Error status:', error));	



						});

					});

					document.getElementById("btnPedido").addEventListener("click",function(){

						cuenta=document.getElementById("SelectCuentas2").value;
						proveedor=document.getElementById("SelectProveedor").value;
						producto=document.getElementById("SelectProducto").value;
						precio=document.getElementById("Precio").value;
						cantidad=document.getElementById("Cantidad").value;
						total=document.getElementById("Total").value;
						img=document.getElementById("modalImg").src;
						nombreproducto=document.getElementById("SelectProducto");
						selected = nombreproducto.options[nombreproducto.selectedIndex].text;

						//console.log(selected);

						if (cuenta==-1) {
							alert("Introduce una cuenta");
						}
						else{

							var url = "controller/controller_insert.php";

							var data = { 'cuenta':cuenta, 'proveedor':proveedor, 'producto':producto, 'precio':precio, 'cantidad':cantidad, 'total':total, 'img':img, 'selected':selected };
			
							fetch(url, {
							method: 'POST', // or 'POST'
							body: JSON.stringify(data),
								headers:{'Content-Type': 'application/json'}  //input data
							})
							.then(res => res.json()).then(result => {

								//alert(result.insertFactura);
								
								Swal.fire(
								'Pedido realizado correctamente',
								'Gracias por confiar en nosotros',
								'success'
								)

							})
							.catch(error => console.error('Error status:', error));	
							
						}

					});


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
			document.getElementById("btnRealizarPedido").style.display="none";
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////
		
		function BancaOnlineload(){
			
			document.getElementById("tabla").style.display="none";
			
			var newRow ="";
			newRow += "<option value=-1>Selecciona una cuenta</option>";
			
			for (let i = 0; i < cuentas.length; i++) {
					
				newRow += "<option value='"+cuentas[i].idCuentas+"'>Cuenta "+cuentas[i].tipo+" ---> "+cuentas[i].numcuenta+"</option>";
			}
			   
			document.getElementById("SelectCuentas").innerHTML = newRow;
			document.getElementById("btnRealizarPedido").style.display="none";

			
			document.getElementById("SelectCuentas").addEventListener("change", function(){

				valor=document.getElementById("SelectCuentas").value;
				console.log(valor);
			

			    var url = "controller/controller_ExtractoCuenta.php";

				var data = { 'numcuenta':valor};

				fetch(url, {
				  method: 'POST', // or 'POST'
				  body: JSON.stringify(data),
			  	  headers:{'Content-Type': 'application/json'}  //input data
				})
				.then(res => res.json()).then(result => {
				
					//console.log("hola");
				
					var extracto = result.listExtracto;
				
					var newRow ="";
					newRow +="<table> ";
					newRow +="<tr><th>Fecha</th><th>Concepto</th><th>Importe</th><th>Saldo</th></tr>";

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
			var newRow3="";
			newRow3 +="<!-- Button trigger modal -->"
			+"<button type='button' class='btn btn-primary' id='btnTransferencia' data-bs-toggle='modal' data-bs-target='#exampleModal'>"
			  +"Transferencia"
			+"</button>"

			+"<!-- Modal -->"
			+"<div class='modal fade' id='exampleModal' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>"
			  +"<div class='modal-dialog modal-lg'>"
				+"<div class='modal-content'>"
				  +"<div class='modal-header'>"
						+"<h1 class='modal-title' id='exampleModalLabel'>Transferencia</h1>"
						+"<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>"
					+"</div>"
					+"<div class='modal-body'>"
						+"<div id='modalCuentas'>"
						+"<div id='transferenciaFlex'>"
						+"<div id='cuenta1'>"
						+"<h3>Cuenta1</h3>"
						+"<select id='Trans1'></select>"
						+"</div>"
						+"<svg xmlns='http://www.w3.org/2000/svg' id='flechita' width='50' height='50' fill='currentColor' class='bi bi-arrow-right' viewBox='0 0 16 16'>"
						+"<path fill-rule='evenodd' d='M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z'/>"
					  	+"</svg>"
						+"<div>"
						+"<h3>Cuenta2</h3>"
						+"<select id='Trans2'></select>"
						+"</div>"
						+"</div>"
						+"<div>"
						+"<h3>Importe</h3>"
						+"<input type='text' id='importe' onkeypress='return onlyNumberKey(event)'></input>"
						+"</div>"
						+"</div>"
						+"<div class='modal-footer'>"
						+"<button type='button' id='btnCancelar' class='btn btn-danger' data-bs-dismiss='modal'>Cancelar</button>"
						+"<button type='button' id='btnPedido' class='btn btn-primary' data-bs-dismiss='modal'>Hacer pedido</button>"
						+"</div>"
					+"</div>"
				+"</div>"
			+"</div>"	
			document.getElementById("Transferencia").innerHTML=newRow3;	

			var newRow4 ="";
		newRow4 += "<option>Selecciona una cuenta</option>";
		
		for (let i = 0; i < cuentas.length; i++) {
				
			newRow4 += "<option value='"+cuentas[i].numcuenta+"'>"+cuentas[i].numcuenta+", "+cuentas[i].tipo+"</option>";
		}
		
		document.getElementById("Trans1").innerHTML = newRow4;

		var newRow5 ="";
		newRow5 += "<option>Selecciona una cuenta</option>";
		
		for (let i = 0; i < cuentas.length; i++) {
				
			newRow5 += "<option value='"+cuentas[i].numcuenta+"'>"+cuentas[i].numcuenta+", "+cuentas[i].tipo+"</option>";
		}
		
		document.getElementById("Trans2").innerHTML = newRow5;

			document.getElementById("btnCancelar").addEventListener("click",function(){
				CancelTrans();
				document.getElementById("Trans1").value="";
				document.getElementById("Trans2").value="";
				document.getElementById("importe").value="";
			  });
			  document.getElementById("btnPedido").addEventListener("click",function(){
				  Transferencia();
				  	document.getElementById("Trans1").value="";
					document.getElementById("Trans2").value="";
					document.getElementById("importe").value="";
			  });

			  
		}
		


	})
	.catch(error => console.error('Error status:', error));	


	function Compra(){
		const swalWithBootstrapButtons = Swal.mixin({
			customClass: {
			confirmButton: 'btn btn-success',
			cancelButton: 'btn btn-danger'
			},
			buttonsStyling: false
		})
		
		swalWithBootstrapButtons.fire({
			title: 'Dron tactico',
			text: "420�",
			imageUrl: "https://m.media-amazon.com/images/I/711UdLKoGbS._AC_SX425_.jpg",
			showCancelButton: true,
			confirmButtonText: 'Comprar',
			cancelButtonText: 'Cancelar',
		}).then((result) => {
			if (result.isConfirmed) {
			swalWithBootstrapButtons.fire(
				'Comprado!',
				'Tu compra se ha realizado con exito',
				'success',
			)
			} else if (
			/* Read more about handling dismissals below */
			result.dismiss === Swal.DismissReason.cancel
			) {
			swalWithBootstrapButtons.fire(
				'Cancelado',
				'Has cancelado tu compra',
				'error'
			)
			}
		})
	}

	function Confirmacion(){
		Swal.fire(
			'Pedido realizado correctamente',
			'Gracias por confiar en nosotros',
			'success'
		)
		
	}
	function Cancelar(){
		Swal.fire(
			'Cancelado',
			'Has cancelado tu compra',
			'error'
		)
		
	}
	function Transferencia(){
		Swal.fire(
			'Has realizado la transferencia',
			'',
			'success'
		)
		
	}
	function CancelTrans(){
		Swal.fire(
			'Cancelado',
			'Has cancelado la transferencia',
			'error'
		)
		
	}

}
function onlyNumberKey(evt) {
          
  // Only ASCII character in that range allowed
  var ASCIICode = (evt.which) ? evt.which : evt.keyCode
  if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
      return false;
  return true;
}