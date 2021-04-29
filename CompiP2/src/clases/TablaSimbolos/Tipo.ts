export enum tipo{
    ENTERO,
    DOUBLE,
    BOOLEANO,
    CARACTER,
    CADENA
}

export default  class Tipo{
     constructor (public type : tipo){
         this.type=type;
     }
}