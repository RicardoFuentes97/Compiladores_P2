export default class Evaluar{
    public resultado:  number;

    constructor(resultado: number){
        this.resultado=resultado;
    }
    ger_resultado():number{
        return this.resultado;
    }
}