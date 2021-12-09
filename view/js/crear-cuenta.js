document.addEventListener("DOMContentLoaded", function(){

    document.getElementById("btncrear").addEventListener("click", crear);

    document.querySelector("#numcount").addEventListener("keypress", function (evt) {
        if (evt.which != 8 && evt.which != 0 && evt.which < 48 || evt.which > 57)
        {
            evt.preventDefault();
        }
    });

});

function crear(){

    var num = document.getElementById("numcount").value;
    var numlong = num.length;
    var tipo = document.getElementById("tipocount").value;
    /*
    console.log(numlong);
    console.log(tipo);
    */
    if(numlong == 20 && tipo == "Corriente"){
        //console.log("Entra al corriente");
        var url = "controller/cNewCuenta.php";

        var data = {'num':num, 'tipo':tipo};

        fetch(url, {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {'Content-Type': 'application/json' }
        })
        .then(res => res.json()).then(result => {

            if(result.existe == "si"){
               alert("Ya existe una cuenta corriente con ese numero de cuenta");
            }else if(result.creado == "si"){
               alert("Cuenta Corriente creada correctamente");
               document.getElementById("numcount").value = "";
               document.getElementById("tipocount").value = "-1";
            }else{
                alert("No se ha podido crear la cuenta"); 
            }
        })
        .catch(error => console.error('Error status:', error));

    }else if(numlong == 16 && tipo == "Crédito"){
        //console.log("Entra al credito");
        var url = "controller/cNewCuenta.php";

        var data = {'num':num, 'tipo':tipo};

        fetch(url, {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {'Content-Type': 'application/json' }
        })
        .then(res => res.json()).then(result => {

            if(result.existe == "si"){
                alert("Ya existe una cuenta de crédito con ese numero de cuenta");
             }else if(result.creado == "si"){
                alert("Cuenta de Crédito creada correctamente");
                document.getElementById("numcount").value = "";
                document.getElementById("tipocount").value = "-1";
             }else{
                 alert("No se ha podido crear la cuenta"); 
             }

        })
        .catch(error => console.error('Error status:', error));

    }  else{
        alert("Número de dígitos y tipo de cuenta no compatibles");
    }


    
}