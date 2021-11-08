document.addEventListener("DOMContentLoaded", function(){

    document.getElementById("entrar").addEventListener("click", login);


});


function login(){
    var nombre = document.getElementById("user").value;
    var contrasena = document.getElementById("password").value;

    var url = "controller/cLogin.php";
	var data = {'nombre':nombre, 'contrasena':contrasena};

    fetch(url, {
        method: 'POST',
        body: JSON.stringify(data),
        headers:{'Content-Type': 'application/json'}
        })
  .then(res => res.json()).then(result => {
        alert(result.error);
  })
  .catch(error => console.error('Error status:', error));

}

    /*if(user == "paul" && password== "123"){
        document.getElementById("iniciosesion").style.display = "none";        
        document.getElementById("imagengrande").style.width = "100%";
        document.getElementById("imagengrande").style.transition = "0.5s";
        document.getElementById("imggrande").style.width = "94%";
        document.getElementById("imggrande").style.height = "100%";
        entra = true;
    }*/

    
    
    
    

    
