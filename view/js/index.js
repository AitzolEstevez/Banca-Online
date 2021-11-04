document.addEventListener("DOMContentLoaded", function(){

    document.getElementById("entrar").addEventListener("click", comprobacion);


});


function comprobacion(){
    var user = document.getElementById("user").value;
    var password = document.getElementById("password").value;

    
    document.getElementById("iniciosesion").style.display = "none";        
    document.getElementById("imagengrande").style.width = "100%";
    document.getElementById("imggrande").style.width = "95%";
    document.getElementById("imggrande").style.height = "100%";
    
    

    
}