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

  htmlts: string ="";
  htmlerrores: string ="";

  ejecutar():void {
    let ana =new Analizador.Analizador();
    this.consola="";

    if(this.entrada !=""){
      let ejecutar =ana.ejecutar(this.entrada);
      this.consola=ejecutar.consola;
      this.htmlts=ejecutar.ts;
      this.htmlerrores = ejecutar.errores;
    }

    
  }

  openPage(pageName,valor) {

    if(valor==1){
      document.getElementById("tablasimbols").innerHTML = this.htmlts;
    }else if (valor == 2){
      document.getElementById("tablasimbols").innerHTML = this.htmlerrores;
    }
    // Hide all elements with class="tabcontent" by default */
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }
  
    // Remove the background color of all tablinks/buttons
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].style.backgroundColor = "";
    }
  
    document.getElementById(pageName).style.display = "block";
  
  }
}
