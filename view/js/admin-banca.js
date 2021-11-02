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

    var url = "controller/controller_Extracto.php";

	fetch(url, {
	  method: 'GET', // or 'POST'
	})
	.then(res => res.json()).then(result => {
        

			console.log('Success:', result.listClientes);
			
			var clientes = result.listClientes;
            var proveedores = result.listProveedores;

            tabs=document.querySelectorAll("#myTab li button");

            for (let i = 0; i < tabs.length; i++) {
                tabs[i].addEventListener("click", function(){

                    valor=tabs[i].id;

                    console.log(valor);

                });
                
            }

       		var newRow ="";
  			newRow +="<table > ";
			newRow +="<tr><th>ID</th><th>TITULO</th><th>ANIO</th><th>DIRECTOR</th><th>CARTEL</th></tr>";
       		
			for (let i = 0; i < pelikulak.length; i++) {
					
				newRow += "<tr>" +"<td>"+pelikulak[i].idPelicula+"</td>"
									+"<td>"+pelikulak[i].TituloPelicula+"</td>"
									+"<td>"+pelikulak[i].Anio+"</td>"
									+"<td>"+pelikulak[i].objDirector.NombreDirector+"</td>"
									+"<td><img src='"+pelikulak[i].cartel+"'/></td>"
								+"</tr>";	
			}
       		newRow +="</table>";   
       		document.getElementById("tableFilms").innerHTML = newRow; // add
       		document.getElementById("numVisits").value=result.numVisits;
       		
       		var lista=loadSelect(pelikulak);;
       		document.getElementById("selectDelete").innerHTML=lista;
       		document.getElementById("selectUpdate").innerHTML=lista;
       		
       		var directors= result.directors;
       		
       		var listaDirectors=loadDirectors(directors);
       		
       		document.getElementById("SelectDirectorInsert").innerHTML=listaDirectors;
	})
	.catch(error => console.error('Error status:', error));	


}