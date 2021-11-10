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
				
			newRow += "<option value='"+cuentas[i].numcuenta+"'>"+cuentas[i].numcuenta+", "+cuentas[i].tipo+"</option>";
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
					  +"<h3>Cuenta</h3>"
					  +"<div id='Cuentas2'></div>"
	                  +"<h3>Proveedor</h3>"
					  +"<div id='Proveedores2'></div>"
					  +"<img id='modalImg' width='100px' height='100px' src='https://d.newsweek.com/en/full/1064234/base-goku-dramatic-finish.jpg?w=1600&h=1200&q=88&f=bde9c6b36d3234f7b7e7e898f29aa21a' alt=''>"
					  +"<h3>Producto</h3>"
					  +"<div id='Productos'></div>"
	                  +"<div id='modalFlex'><div>"
					  +"<h3>Precio/Ud</h3>"
					  +"<input id='Precio' type='text' disabled class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm'>"
					  +"</div>"
					  +"<div>"
					  +"<h3>Cantidad</h3>"
					  +"<input type='number' id='Cantidad' class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm'>"
					  +"</div>"
	                  +"</div>"
	                  +"<h3>Total</h3>"
	                  +"<input type='text' id='Total' disabled class='form-control' aria-label='Sizing example input' aria-describedby='inputGroup-sizing-sm'>"
					  +"</div>"
					  +"<div class='modal-footer'>"
	                  +"<button type='button' id='btnCancelar' class='btn btn-secondary' data-bs-dismiss='modal'>Cancelar</button>"
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
					  document.getElementById("btnPedido").addEventListener("click",function(){
						  Confirmacion();
					  });

					  document.getElementById("btnProveedor").addEventListener("click",function(){
						
						var newRow ="";
						newRow += "<select class='modalCombo' id='SelectCuentas2' class='form-select' aria-label='Default select example'>";
						newRow +="<option selected value=-1>Selecciona una cuenta</option>";

						for (let i = 0; i < cuentas.length; i++) {
								
							newRow +="<option value='"+cuentas[i].numcuenta+"'>"+cuentas[i].numcuenta+"</option>";
						}

						newRow +="</select>";

						console.log(newRow);

						document.getElementById("Cuentas2").innerHTML=newRow;

						document.getElementById("Cantidad").value="";
						document.getElementById("Total").value="";
						document.getElementById("Precio").value="";
						document.getElementById("modalImg").src="https://d.newsweek.com/en/full/1064234/base-goku-dramatic-finish.jpg?w=1600&h=1200&q=88&f=bde9c6b36d3234f7b7e7e898f29aa21a";

						var url = "controller/controller_Proveedores.php";
		
						fetch(url, {
						  method: 'GET', // or 'POST'
						})
						.then(res => res.json()).then(result => {
												
							var proveedor = result.listProveedores;

							var newRow ="";
							newRow += "<select class='modalCombo' id='SelectProveedor' class='form-select' aria-label='Default select example'>";
							newRow +="<option selected value=-1>Selecciona un proveedor</option>";

							
							for (let i = 0; i < proveedor.length; i++) {
									
								newRow +="<option value='"+proveedor[i].id+"'>"+proveedor[i].nombre+"</option>";
							}

							newRow +="</select>";

							document.getElementById("Proveedores2").innerHTML = newRow;
						
							
						})
						.catch(error => console.error('Error status:', error));	

							var newRow ="";
							newRow += "<select class='modalCombo' id='SelectProducto' class='form-select' aria-label='Default select example'>";
							newRow +="<option selected value=-1>Selecciona un producto</option>";

							newRow +="</select>";

							document.getElementById("Productos").innerHTML = newRow;


						document.getElementById("Proveedores2").addEventListener("change",function(){

							if (document.getElementById("Proveedores2").value=-1) {
								document.getElementById("Total").value="";
								document.getElementById("Cantidad").value="";
								document.getElementById("Precio").value="";
								document.getElementById("modalImg").src="https://d.newsweek.com/en/full/1064234/base-goku-dramatic-finish.jpg?w=1600&h=1200&q=88&f=bde9c6b36d3234f7b7e7e898f29aa21a";		
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
								newRow += "<select class='modalCombo' id='SelectProducto' class='form-select' aria-label='Default select example'>";
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
										document.getElementById("modalImg").src="https://d.newsweek.com/en/full/1064234/base-goku-dramatic-finish.jpg?w=1600&h=1200&q=88&f=bde9c6b36d3234f7b7e7e898f29aa21a";				
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
					
				newRow += "<option value='"+cuentas[i].numcuenta+"'>Cuenta "+cuentas[i].tipo+" ---> "+cuentas[i].numcuenta+"</option>";
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

}