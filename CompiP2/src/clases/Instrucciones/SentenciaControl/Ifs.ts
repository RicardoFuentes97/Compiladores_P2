import Nodo from "src/clases/AST/Nodo";
import Controlador from "src/clases/Controlador";
import { Expreciones } from "src/clases/Interfaces.ts/Expreciones";
import { Instruccion } from "src/clases/Interfaces.ts/Instruccion";
import { TablaSimbolos } from "src/clases/TablaSimbolos/TablaSimbolos";
import { tipo } from "src/clases/TablaSimbolos/Tipo";


export default class Ifs implements Instruccion{

    public condicion : Expreciones;
     public lista_ifs : Array<Instruccion>;
     public lista_elses : Array<Instruccion>;
     public linea : number;
     public columna : number;

     constructor(condicion, lista_ifs, lista_elses, linea, columna) {
         this.condicion = condicion;
         this.lista_ifs = lista_ifs;
         this.lista_elses = lista_elses;
         this.columna = columna; 
         this.linea = linea;
     }

     ejecutar(controlador: Controlador, ts: TablaSimbolos) {
        let ts_local = new TablaSimbolos(ts);

        let valor_condicion = this.condicion.getValor(controlador, ts);

        if(this.condicion.getTipo(controlador, ts) == tipo.BOOLEANO){
            if(valor_condicion){
                for(let ins of this.lista_ifs){
                    let res = ins.ejecutar(controlador, ts_local);
                    //TODO verificar si res es de tipo CONTINUE, BREAK, RETORNO 
                }
            }else{
                for(let ins of this.lista_elses){
                    let res = ins.ejecutar(controlador,ts_local);
                    //TODO verificar si res es de tipo CONTINUE, BREAK, RETORNO 
                }
            }
        }
        return null;
    }
    recorrer(): Nodo {
        throw new Error("Method not implemented.");
    }

}