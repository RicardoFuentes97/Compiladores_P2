import Controlador from "../Controlador";
import Declaracion from "../Instrucciones/Declaracion";
import Ejecutar from "../Instrucciones/Ejecutar";
import Funcion from "../Instrucciones/Funcion";
import { Instruccion } from "../Interfaces.ts/Instruccion";
import { TablaSimbolos } from "../TablaSimbolos/TablaSimbolos";
import Nodo from "./Nodo";

export default class Ast implements Instruccion{

    public lista_instrucciones: Array <Instruccion>;

    constructor (lista_instrucciones){
        this.lista_instrucciones=lista_instrucciones;
    }

    ejecutar(controlador: Controlador, ts: TablaSimbolos) {
    let bandera = false;
    for(let instruccion of this.lista_instrucciones){
        if(instruccion instanceof Funcion){
            let funcion= instruccion as Funcion;
            funcion.agregarSimboloFuncion(controlador,ts);
        }
    }

    for(let instruccion of this.lista_instrucciones){
         if(instruccion instanceof Ejecutar  && bandera == false){
             instruccion.ejecutar(controlador, ts);
             bandera = true;
         }else if (bandera){
             //reportar error
             return;
         }
         if(instruccion instanceof Declaracion ){
             instruccion.ejecutar(controlador, ts);
         }
     }

    }
    recorrer(): Nodo {
        let raiz = new Nodo("INICIO","");

        for(let inst of this.lista_instrucciones){
            raiz.AddHijo(inst.recorrer());
        }
        return raiz;
    }

}