export enum tipo{
    ENTERO,
    DOBLE,
    BOOLEANO,
    CARACTER,
    CADENA
}

export default  class Tipo{
     constructor (public type : tipo){
         this.type=type;
     }
}