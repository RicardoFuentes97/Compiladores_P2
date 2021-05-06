import Simbolos from "./Simbolos";


export class TablaSimbolos{

    public ant : TablaSimbolos;
    public tabla : Map<string,Simbolos>;

    constructor ( ant: TablaSimbolos){
        this.ant=ant;
        this.tabla= new Map<string,Simbolos>();
    }

    agregar(id: string, simbolo : Simbolos){
        this.tabla.set(id.toLowerCase(), simbolo); 
    }

    existe(id: string): boolean{
        let ts : TablaSimbolos = this;

        while(ts != null){
            let existe = ts.tabla.get(id);

            if(existe != null){
                return true;
            }
            ts = ts.ant;
        }
        return false;
    }

    existeEnActual(id: string): boolean{
        let ts : TablaSimbolos = this;

        let existe = ts.tabla.get(id);

        if(existe != null){
            return true;
        }
        return false;
    }

    getSimbolo(id: string){
        let ts : TablaSimbolos = this; 

        while(ts != null){
            let existe = ts.tabla.get(id);

            if(existe != null){
                return existe;
            }
            ts = ts.ant;
        }
        return null;
    }
}