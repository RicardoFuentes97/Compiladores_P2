
import Nodo from "src/clases/AST/Nodo";
import Controlador from "src/clases/Controlador";
import { Expreciones } from "src/clases/Interfaces.ts/Expreciones";
import { Instruccion } from "src/clases/Interfaces.ts/Instruccion";
import { TablaSimbolos } from "src/clases/TablaSimbolos/TablaSimbolos";


export default class For implements Instruccion{

    public condicion: Expreciones;
    public lista_instrucciones : Array<Instruccion>;
    public inicio;
    public fin;
    public linea : number;
    public columna : number;

    constructor(condicion, lista_instrucciones,inicio,fin,linea, columna) {
        this.condicion = condicion;
        this.lista_instrucciones = lista_instrucciones;
        this.inicio=inicio;
        this.fin=fin;
        this.linea = linea;
        this.columna = columna;
    }

    ejecutar(controlador: Controlador, ts: TablaSimbolos) {
        let ts_for = new TablaSimbolos(ts);
        this.inicio.ejecutar(controlador,ts_for);
        let valor_condicion = this.condicion.getValor(controlador, ts_for);
        
        if(typeof valor_condicion == 'boolean'){

            while(this.condicion.getValor(controlador,ts_for)){

                let ts_local = new TablaSimbolos(ts_for);

                for(let ins of this.lista_instrucciones){
                    let res = ins.ejecutar(controlador,ts_local);
                     //TODO verificar si res es de tipo CONTINUE, BREAK, RETORNO 
                }
                controlador.graficarEntornos(controlador,ts_local," (FOR)");

                this.fin.ejecutar(controlador,ts_for);
            }
        }
        controlador.graficarEntornos(controlador,ts_for," (FOR)");
    }
    
    recorrer(): Nodo {
        throw new Error("Method not implemented.");
    }

} 