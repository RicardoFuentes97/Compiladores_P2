import Nodo from "src/clases/AST/Nodo";
import Controlador from "src/clases/Controlador";
import { Expreciones } from "src/clases/Interfaces.ts/Expreciones";
import { TablaSimbolos } from "src/clases/TablaSimbolos/TablaSimbolos";
import Operaciones, { Operador } from "./Operaciones";


export default class Logicas extends Operaciones implements Expreciones{

    public constructor(exp1, op: string, exp2, linea: number, columna:number, expU :boolean) {
        super(exp1,op,exp2,linea,columna,expU);        
    }

    getTipo(controlador: Controlador, TablaSimbolos: TablaSimbolos) {
        throw new Error("Method not implemented.");
    }
    getValor(controlador: Controlador, TablaSimbolos: TablaSimbolos) {
        let valor_exp1;
        let valor_exp2;
        let valor_expU;
        
        
        if(this.expU == false){
            valor_exp1 = this.exp1.getValor(controlador, TablaSimbolos);
            valor_exp2 = this.exp2.getValor(controlador, TablaSimbolos);
        }else{
            valor_expU = this.exp1.getValor(controlador, TablaSimbolos);
        }

        switch (this.operador){

            case Operador.AND:
                return this.and(valor_exp1,valor_exp2);
            case Operador.NOT:
                return this.not(valor_expU);
            case Operador.OR:
                return this.or(valor_exp1,valor_exp2);
            default:
                break;
            
        }

    }

    and(valor_exp1,valor_exp2){
        if(typeof valor_exp1 =='boolean'){
            if(typeof valor_exp2 == 'boolean'){
                return valor_exp1 && valor_exp2;
            }else{
                //Error semantico
            }
        }
    }

    or(valor_exp1,valor_exp2){
        if(typeof valor_exp1 =='boolean'){
            if(typeof valor_exp2=='boolean'){
                return valor_exp1 || valor_exp2;
            }else{
                //Erro semantico
            }
        }
    }

    not(valor_expU){
        if(typeof valor_expU =='boolean'){
            return !valor_expU;
        }else{
            //Erro semantico
        }
    }

    recorrer(): Nodo {
        throw new Error("Method not implemented.");
    }

}