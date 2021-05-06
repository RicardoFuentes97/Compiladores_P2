import Controlador from "../Controlador";
import { Instruccion } from "../Interfaces.ts/Instruccion";
import { TablaSimbolos } from "../TablaSimbolos/TablaSimbolos";
import Nodo from "./Nodo";

export default class Ast implements Instruccion{

    public lista_instrucciones: Array <Instruccion>;

    constructor (lista_instrucciones){
        this.lista_instrucciones=lista_instrucciones;
    }

    ejecutar(controlador: Controlador, ts: TablaSimbolos) {
       for (let instruccion of this.lista_instrucciones){
           instruccion.ejecutar(controlador,ts);
       }
    }
    recorrer(): Nodo {
        throw new Error("Method not implemented.");
    }

}