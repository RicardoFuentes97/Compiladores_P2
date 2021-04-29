import Simbolos from "./Simbolos";


export class TablaSimbolos{

    public ant : TablaSimbolos;
    public tabla : Map<string,Simbolos>;

    constructor ( ant: TablaSimbolos){
        this.ant=ant;
        this.tabla= new Map<string,Simbolos>();
    }

}