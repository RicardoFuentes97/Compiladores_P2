import { Component } from '@angular/core';
import Controlador from 'src/clases/Controlador';
import Evaluar from 'src/clases/Evaluar';
import { TablaSimbolos } from 'src/clases/TablaSimbolos/TablaSimbolos';
import * as Analizador from '../clases/Analizar'

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  
  entrada : string  = "";
  consola : string = "";


  ejecutar():void {
    let ana =new Analizador.Analizador();
    let ts=new TablaSimbolos(null);
    let cont= new Controlador();
    console.log("entre");
    this.consola="";
    if(this.entrada != ""){
      console.log (this.entrada);
      let arreglo :  Array <Evaluar> = ana.ejecutar(this.entrada);
      
      for (let num of arreglo){
        this.consola+= num.resultado.getValor(cont,ts) +"\n";
      }
    }
  }
}
