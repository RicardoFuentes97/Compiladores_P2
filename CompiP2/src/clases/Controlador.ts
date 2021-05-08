import Errores from "./AST/Errores";
import Simbolos from "./TablaSimbolos/Simbolos";
import { TablaSimbolos } from "./TablaSimbolos/TablaSimbolos";

export default class Controlador{
    public errores: Array<Errores>;
    public consola: string;
    public ambito: string;
    public cuerpo: string;
    constructor (){
        this.errores = new  Array<Errores>();
        this.consola ="";
        this.cuerpo;
    }

    public append (consola: string){
        this.consola+=consola+"\n";
    }

    graficar_ts(controlador:Controlador, ts:TablaSimbolos):string{
        var cuerpohtml = "<thead class=\"black white-text\"><tr><td colspan=\"6\">Tabla de Simbolos </td></tr><tr><th>Rol</th><th>Nombre</th><th>Tipo</th><th>Ambito</th><th>Valor</th><th>Parametros</th></tr></thead>";

        cuerpohtml+=this.cuerpo;
        
        return cuerpohtml;
    }

    graficarEntornos(controlador:Controlador, ts:TablaSimbolos,ubicacion:string){
        var cuerpohtml="";
        for(let sim of ts.tabla.values()){
            cuerpohtml += "<tr mdbTableCol class=\"grey lighten-1 black-text\"><th scope=\"row\">" +  this.getRol(sim) + "</th><td>" + sim.identificador + 
            "</td><td>" + this.getTipo(sim) +"</td>"  + 
            "</td><td>" + this.ambito+ ubicacion + 
            "</td><td>" + this.getValor(sim) + 
            "</td><td>" + this.parametros(sim) +"</td>" +  "</tr>";
        }
        this.cuerpo=cuerpohtml+this.cuerpo;
    }

    graficar_Semantico(controlador:Controlador, ts:TablaSimbolos):string{
        var cuerpohtml = "<thead class=\"black white-text\"><tr><td colspan=\"4\">Errores Semanticos </td></tr><tr><th>Tipo</th><th>Descripcion</th><th>Fila</th><th>Columna</th></tr></thead>";


        for(let sim of controlador.errores){
            console.log(`Errores`);
                
            cuerpohtml += "<tr mdbTableCol class=\"grey lighten-1 black-text\"><th scope=\"row\">" + sim.tipo + "</th><td>" + sim.descripcion + 
                "</td><td>" + sim.linea +"</td>"  + 
                "</td><td>" + sim.columna +  "</tr>";
        }
            
        
        
        return cuerpohtml;
    }
    getValor(sim:Simbolos):string{
        if(sim.valor != null){
            return sim.valor.toString(); 
        }else{
            return '...';
        }
    }
    getTipo(sim):string{

        return sim.tipo.stype.toLowerCase();
    }
    getRol(sim:Simbolos):string{
        let rol : string = '';
        switch(sim.simbolo){
            case 1:
                rol = "variable"
                break
            case 2:
                rol = "funcion";
                break;
            case 3:
                rol = "metodo";
                break;
             case 4:
                rol = "vector";
                break
             case 5:
                rol = "lista";
                break;
            case 6:
                rol = "parametro"
                break;
        }
        return rol;
    }

    getAmbito():string{
        return 'global'
    }
    parametros(sim){
        if(sim.lista_params != undefined){
            return sim.lista_params.length
        }else{
            return "...";
        }
    }

}