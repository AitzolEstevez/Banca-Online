document.addEventListener("DOMContentLoaded", function(){

    document.getElementById("entrar").addEventListener("click", comprobacion);


});


function comprobacion(){
    var user = document.getElementById("user").value;
    var password = document.getElementById("password").value;

    entra = false;

    if(user == "admin" && password=="admin"){
        window.location.href = "admin-banca.html"
        entra = true;
    }



    if(user == "paul" && password== "123"){
        document.getElementById("iniciosesion").style.display = "none";        
        document.getElementById("imagengrande").style.width = "100%";
        document.getElementById("imagengrande").style.transition = "0.5s";
        document.getElementById("imggrande").style.width = "94%";
        document.getElementById("imggrande").style.height = "100%";
        entra = true;
    }


    if(entra == false){
        alert("Error al iniciar sesion");
    }
    
    
    
    

    
}