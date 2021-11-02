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