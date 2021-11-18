document.addEventListener("DOMContentLoaded", function(){

    document.getElementById("entrar").addEventListener("click", login);

    document.getElementById("user").addEventListener("keyup", function(event) {
    event.preventDefault();
    if (event.keyCode === 13) {
        document.getElementById("entrar").click();
    }
    });
    
    document.getElementById("password").addEventListener("keyup", function(event) {
    event.preventDefault();
    if (event.keyCode === 13) {
        document.getElementById("entrar").click();
    }
    });


    document.getElementById("loginbutton").addEventListener("click", abrirocerrar);

    
});

function abrirocerrar(){
    if(document.getElementById("logindiv").classList.contains("cerrado")){
        document.getElementById("imagengrande").classList.remove("col-lg-12");
        document.getElementById("imagengrande").classList.add("col-lg-7");    
        document.getElementById("imgrande").style.width= "750px";
        document.getElementById("imgrande").style.transition = "0.3s";
        document.getElementById("iniciosesion").style.display = "block";
        document.getElementById("logindiv").classList.remove("cerrado");
        document.getElementById("logindiv").classList.add("abierto");
        
}else{
        document.getElementById("imagengrande").classList.remove("col-lg-7");
        document.getElementById("imagengrande").classList.add("col-lg-12");
        document.getElementById("imgrande").style.width= "1400px";
        document.getElementById("imgrande").style.transition = "0.3s";
        document.getElementById("iniciosesion").style.display = "none";
        document.getElementById("logindiv").classList.remove("abierto");
        document.getElementById("logindiv").classList.add("cerrado");
        document.getElementById("user").value = "";
        document.getElementById("password").value = "";
}
}

function login(){
    var nombre = document.getElementById("user").value;
    var contrasena = document.getElementById("password").value;
    console.log("entra al login");
    var url = "controller/cLogin.php";
	var data = {'nombre':nombre, 'contrasena':contrasena};

    fetch(url, {
        method: 'POST',
        body: JSON.stringify(data),
        headers:{'Content-Type': 'application/json'}
        })
  .then(res => res.json()).then(result => {
    console.log("Entra a dentro");
    if(result.error == "no error"){

        if(result.tipo == "admin"){
            location.href = "admin-banca.html";
        }else if(result.tipo == "cliente"){
            abrirocerrar();
            document.getElementById("logindiv").innerHTML = "<h1 class='mt-3 me-1'>" + result.nombre + "</h1><a id='cerrarsesion' class='ms-1' href='index.html'>Cerrar Sesion</a>";
        }

        
    }else if (result.error == "incorrect user"){
        alert("Nombre o contrasena incorrectas");
    }else{
        alert("No se admite los campos vacios");
    }
    
  })
  .catch(error => console.error('Error status:', error));

}