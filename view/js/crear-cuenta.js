document.addEventListener("DOMContentLoaded", function(){

    document.getElementById("btncrear").addEventListener("click", crear);


});

function crear(){

    var num = document.getElementById("numcount").value;
    var numlong = num.length;
    var tipo = document.getElementById("tipocount").value;

    console.log(numlong);
    console.log(tipo);

    if(numlong == 20 && tipo == "Corriente"){
        console.log("Entra al corriente");
        var url = "controller/cNewCuenta.php";

        var data = {'num':num, 'tipo':tipo};

        fetch(url, {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {'Content-Type': 'application/json' }
        })
        .then(res => res.json()).then(result => {

            if(result.existe == "si"){
               alert(result.existe);
            }else{
                alert(result.creado);
                location.reload();
            }
        })
        .catch(error => console.error('Error status:', error));

    }else if(numlong == 16 && tipo == "Crédito"){
        console.log("Entra al credito");
        var url = "controller/cNewCuenta.php";

        var data = {'num':num, 'tipo':tipo};

        fetch(url, {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {'Content-Type': 'application/json' }
        })
        .then(res => res.json()).then(result => {

            if(result.existe == "si"){
                alert(result.existe);
            }else{
                 alert(result.creado);
                 location.reload();
             }

        })
        .catch(error => console.error('Error status:', error));

    }  else{
        alert("no entra");
    }



}