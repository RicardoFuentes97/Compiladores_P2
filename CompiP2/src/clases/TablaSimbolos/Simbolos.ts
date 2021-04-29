import Tipo from "./Tipo";


export default class Simbolos {
    
    public simbolo: number; 

    // Para la variables
    public tipo : Tipo;
    public identificador : String ;
    public valor: any;

    // funcion/metodo

    public lista_parametros: Array <Simbolos>;
    public metodo: boolean;

    constructor (simbolo: number,tipo: Tipo, indetificado: string , valor : any,lista_parametros?,metodo?){
        
    }






}