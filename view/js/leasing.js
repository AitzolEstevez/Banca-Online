function genLeasing(event) {
    event.preventClick;
    var formulario = Array.from($("form#genLeasing .form-control"));
    
    formulario.forEach(element => {
        //console.log(element.value);
    });

    var cantidad = formulario[1].value;
    var timeLapse = formulario[3].value;
    var tiempo = formulario[2].value * (12/timeLapse);
    var interes = (formulario[4].value / 100) / formulario[2].value;

    var calculo1 = cantidad * Math.pow((1+interes),-1);
    var calculo2 = (1-Math.pow(1+interes,-(tiempo+1))) / interes;
    
    var cuota = (calculo1 / calculo2);
    var BEZ = cuota * (formulario[5].value/100);

    var datos = {
        "dataType" : "leasing",
        "cantidad" : cantidad,   
        "timeLapse" : timeLapse,
        "tiempo" : tiempo,
        "interes" : interes,
        "BEZ" : BEZ,
        "cuota" : cuota
    };

    genTableInfo(datos);
    
    //Cargar los productos del filter tambien despues de dar submit en el modal de prestamos y que asi nos aparezca la tabla;
    document.getElementById("botonPrestamos").click();

    return false;
}
