import Nodo from "../AST/Nodo";
import Controlador from "../Controlador";
import { Expreciones } from "../Interfaces.ts/Expreciones";
import { TablaSimbolos } from "../TablaSimbolos/TablaSimbolos";
import Errores from "../AST/Errores";

export default class Identificador implements Expreciones{

    public identificador : string;
    public linea : number;
    public columna : number;

    constructor(identifador, linea, columna) {
        this.identificador = identifador;
        this.linea = linea;
        this.columna = columna;
    }


    getTipo(controlador: Controlador, ts: TablaSimbolos) {
        let existe_id = ts.getSimbolo(this.identificador);
        if(existe_id != null ){
            return existe_id.tipo.type;
        }
    }
    getValor(controlador: Controlador, ts: TablaSimbolos) {
        let existe_id = ts.getSimbolo(this.identificador);

        if(existe_id != null){
            return existe_id.valor; 
        }else{
            let error = new Errores('Semantico', `No existe la variable ${this.identificador} en la tabla de simbolos.`, this.linea, this.columna);
            controlador.errores.push(error);
            controlador.append(`Error Semantico : No existe la variable ${this.identificador} en la tabla de simbolos. En la linea ${this.linea} y columan ${this.columna}`);
            return null;
        }
    }
    recorrer(): Nodo {
        let padre = new Nodo("Identificador","");
        padre.AddHijo(new Nodo(this.identificador,""));
       return padre;
    }

}