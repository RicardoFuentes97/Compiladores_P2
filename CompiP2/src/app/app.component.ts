import { Component } from '@angular/core';
import Evaluar from 'src/clases/Evaluar';
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
    console.log("entre");
    if(this.entrada != ""){
      console.log (this.entrada);
      let arreglo :  Array <Evaluar> = ana.ejecutar(this.entrada);
      
      for (let num of arreglo){
        this.consola+= num.resultado +"\n";
      }
    }
  }
}
