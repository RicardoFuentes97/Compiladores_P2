import * as sintactico from "../Analizadores/gramatica"

export class Analizador {
    public ejecutar(input):any {
        console.log("vamos a analizar la entrada");
     
            let salida= sintactico.parse(input);
            return salida;
        
    }
}