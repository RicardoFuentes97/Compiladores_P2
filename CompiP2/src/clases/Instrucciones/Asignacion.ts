import Nodo from "../AST/Nodo";
import Controlador from "../Controlador";
import { Expreciones } from "../Interfaces.ts/Expreciones";
import { Instruccion } from "../Interfaces.ts/Instruccion";
import { TablaSimbolos } from "../TablaSimbolos/TablaSimbolos";


export default class Asignacion implements Instruccion {

    public identificador: string;
    public valor : Expreciones;
    public linea : number;
    public columna: number;

    constructor (identificador,valor,linea,columna){
        this.identificador=identificador;
        this.valor=valor;
        this.linea=linea;
        this.columna=columna;
    }




    ejecutar(controlador: Controlador, ts: TablaSimbolos) {
        if(ts.existe(this.identificador)){
            let valor=this.valor.getValor(controlador,ts);
            ts.getSimbolo(this.identificador).setValor(valor);
        }else{
            //Error semantico
        }
    }
    recorrer(): Nodo {
        throw new Error("Method not implemented.");
    }

}