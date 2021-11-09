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

////////////////////////Modal de comprar\\\\\\\\\\\\\\\\\\\\\\\
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
        text: "420€",
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
function onlyNumberKey(evt) {
          
  // Only ASCII character in that range allowed
  var ASCIICode = (evt.which) ? evt.which : evt.keyCode
  if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
      return false;
  return true;
}