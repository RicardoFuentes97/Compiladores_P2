import { Component } from '@angular/core';
import Controlador from 'src/clases/Controlador';
import Evaluar from 'src/clases/Evaluar';
import { TablaSimbolos } from 'src/clases/TablaSimbolos/TablaSimbolos';
import * as Analizador from '../clases/Analizar'

import {graphviz} from 'd3-graphviz';
import {wasmFolder} from '@hpcc-js/wasm'
import Nodo from 'src/clases/AST/Nodo';

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


  recorrer(): void{
    let ana = new Analizador.Analizador();
    if(this.entrada != ""){
      console.log("Vamos a graficar");
      let nodo_ast: Nodo= ana.recorrer(this.entrada);
      let grafo = nodo_ast.GraficarSintactico();  //Aqui tenemos la cadena de graphviz para graficar
      wasmFolder('/assets/@hpcc-js/wasm/dist/');
      graphviz('#graph').renderDot(grafo);
    }
  }

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
    }else if(valor==3){
      this.recorrer();
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
