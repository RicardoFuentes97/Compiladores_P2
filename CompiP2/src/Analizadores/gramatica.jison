/* Definicion lexica */
%lex
%options case-insensitive
%option yylineno

/* Expresiones regulares */
num     [0-9]+
id      [a-zñA-ZÑ_][a-zñA-ZÑ0-9_]*
//--> Cadena
escapechar  [\'\"\\ntr]
escape      \\{escapechar}
aceptacion  [^\"\\]+
cadena      (\"({escape} | {aceptacion})*\")

//--> Caracter
escapechar2  [\\ntr]
escape2      \\{escapechar2}
aceptada2    [^\'\\]
caracter     (\'({escape2}|{aceptada2})\')

%%

/* Comentarios */
"//".*              {/* Ignoro los comentarios simples */}
"/*"((\*+[^/*])|([^*]))*\**"*/"     {/*Ignorar comentarios con multiples lneas*/}  


/* Simbolos del programa */

"++"                   { console.log("Reconocio : "+ yytext); return 'INCRE'}
"--"                   { console.log("Reconocio : "+ yytext); return 'DECRE'}
"("                    { console.log("Reconocio : "+ yytext); return 'PARA'}
")"                    { console.log("Reconocio : "+ yytext); return 'PARC'}
"["                    { console.log("Reconocio : "+ yytext); return 'CORA'}
"]"                    { console.log("Reconocio : "+ yytext); return 'CORC'}

";"                    { console.log("Reconocio : "+ yytext); return 'PYC'}
","                    { console.log("Reconocio : "+ yytext); return 'COMA'}
"=="                   { console.log("Reconocio : "+ yytext); return 'IGUALIGUAL'}
"="                    { console.log("Reconocio : "+ yytext); return 'IGUAL'}
"?"                    { console.log("Reconocio : "+ yytext); return 'INTERROGACION'}
":"                    { console.log("Reconocio : "+ yytext); return 'DSPNTS'}
"{"                    { console.log("Reconocio : "+ yytext); return 'LLAVA'}
"}"                    { console.log("Reconocio : "+ yytext); return 'LLAVC'}

/* Operadores Aritmeticos */
"+"                     { console.log("Reconocio : "+ yytext); return 'MAS'}
"-"                     { console.log("Reconocio : "+ yytext); return 'MENOS'}
"*"                     { console.log("Reconocio : "+ yytext); return 'MULTI'}
"/"                     { console.log("Reconocio : "+ yytext); return 'DIV'}
"^"                     { console.log("Reconocio : "+ yytext); return 'POT'}
"%"                     { console.log("Reconocio : "+ yytext); return 'MODULO'}

/* Operadores Relacionales */
"<="                    { console.log("Reconocio : "+ yytext); return 'MENORIGUAL'}
"<"                     { console.log("Reconocio : "+ yytext); return 'MENORQUE'}
">="                    { console.log("Reconocio : "+ yytext); return 'MAYORIGUAL'}
">"                     { console.log("Reconocio : "+ yytext); return 'MAYORQUE'}
"!="                    { console.log("Reconocio : "+ yytext); return 'DIFERENTE'}


/* Operadores Logicos */
"&&"                    { console.log("Reconocio : "+ yytext); return 'AND'}
"!"                     { console.log("Reconocio : "+ yytext); return 'NOT'}
"||"                    { console.log("Reconocio : "+ yytext); return 'OR'}

/* Palabras reservadas */
"evaluar"               { console.log("Reconocio : "+ yytext); return 'EVALUAR'}
"true"                  { console.log("Reconocio : "+ yytext); return 'TRUE'}
"false"                 { console.log("Reconocio : "+ yytext); return 'FALSE'}
"int"                   { console.log("Reconocio : "+ yytext); return 'INT'}
"double"                { console.log("Reconocio : "+ yytext); return 'DOUBLE'}
"string"                { console.log("Reconocio : "+ yytext); return 'STRING'}
"char"                  { console.log("Reconocio : "+ yytext); return 'CHAR1'}
"boolean"               { console.log("Reconocio : "+ yytext); return 'BOOLEAN'}
"print"                 { console.log("Reconocio : "+ yytext); return 'PRINT'}
"if"                    { console.log("Reconocio : "+ yytext); return 'IF'}
"while"                 { console.log("Reconocio : "+ yytext); return 'WHILE'}
"else"                  { console.log("Reconocio : "+ yytext); return 'ELSE'}
"void"                  { console.log("Reconocio : "+ yytext); return 'VOID'}
"exec"                  { console.log("Reconocio : "+ yytext); return 'EXEC'}
"do"                    { console.log("Reconocio : "+ yytext); return 'DO'}
"for"                   { console.log("Reconocio : "+ yytext); return 'FOR'}
"break"                 { console.log("Reconocio : "+ yytext); return 'BREAK'}
"continue"              { console.log("Reconocio : "+ yytext); return 'CONTINUE'}
"return"                { console.log("Reconocio : "+ yytext); return 'RETURN'}
"switch"                { console.log("Reconocio : "+ yytext); return 'SWITCH'}
"case"                  { console.log("Reconocio : "+ yytext); return 'CASE'}
"default"               { console.log("Reconocio : "+ yytext); return 'DEFAULT'}


/* SIMBOLOS ER */
[0-9]+("."[0-9]+)?\b        { console.log("Reconocio : "+ yytext); return 'DECIMAL'}
{num}                       { console.log("Reconocio : "+ yytext); return 'ENTERO'}
{id}                        { console.log("Reconocio : "+ yytext); return 'ID'}
{cadena}                    { console.log("Reconocio : "+ yytext); return 'CADENA'}
{caracter}                  { console.log("Reconocio : "+ yytext); return 'CHAR'}

/* Espacios */
[\s\r\n\t]                  {/* skip whitespace */}


<<EOF>>               return 'EOF'

/* Errores lexicos */
.                     { console.log("Error Lexico "+yytext
                        +" linea "+yylineno
                        +" columna "+(yylloc.last_column+1));

                        
                                      
                        }

/lex

/* Area de imports */
%{
    const evaluar = require('../Clases/Evaluar');
    const aritmetica= require('../Clases/Expreciones/Operaciones/Aritmetica');
    const relacional = require('../Clases/Expreciones/Operaciones/Relaciones');
    const logica = require('../Clases/Expreciones/Operaciones/Logicas');
    const primitivo= require('../Clases/Expreciones/Primitivo');
    const identificador= require('../Clases/Expreciones/Identificador');
    const ternario= require('../Clases/Expreciones/Ternario');

    const ast =require('../Clases/AST/Ast');
    const declaracion = require ('../Clases/Instrucciones/Declaracion');
    const asignacion = require ('../Clases/Instrucciones/Asignacion');
    const funcion = require ('../Clases/Instrucciones/Funcion');
    const llamada = require ('../Clases/Instrucciones/Llamada');
    const ejecutar = require ('../Clases/Instrucciones/Ejecutar');
    const Print = require ('../Clases/Instrucciones/Print');
    const Ifs = require ('../Clases/Instrucciones/SentenciaControl/Ifs');
    const While = require ('../Clases/Instrucciones/SentenciaCiclos/While');
    const dowhile =require ('../Clases/Instrucciones/SentenciaCiclos/DoWhile');
    const For =require ('../Clases/Instrucciones/SentenciaCiclos/For');
    const simbolo= require ('../Clases/TablaSimbolos/Simbolos');
    const tipo= require ('../Clases/TablaSimbolos/Tipo');

    const detener = require ('../Clases/Instrucciones/SentenciaTransferencia/Break');
    const continuar = require ('../Clases/Instrucciones/SentenciaTransferencia/continuar');
    const retornar = require ('../Clases/Instrucciones/SentenciaTransferencia/retornar');

    const sw = require ('../Clases/Instrucciones/SentenciaControl/SW');
    const cs = require ('../Clases/Instrucciones/SentenciaControl/CS');
%}

/* Precedencia de operadores */

%right 'INTERROGACION'
%left 'OR'
%left 'AND'
%right 'NOT'
%left 'IGUALIGUAL' 'DIFERENTE' 'MENORQUE' 'MENORIGUAL' 'MAYORQUE'  'MAYORIGUAL' 
%left 'MAS' 'MENOS'
%left 'MULTI' 'DIV' 'MODULO'
%nonassoc 'POT'
%right 'UNARIO'
%right 'PARA' 'CORA'
 
%start inicio

%% /* Gramatica */


inicio
    : instrucciones EOF { console.log($1); $$= new ast.default($1);  return $$; }
    ;

instrucciones : instrucciones instruccion   { $$ = $1; $$.push($2); }
            | instruccion                   {$$= new Array(); $$.push($1); }
            ;

instruccion :  declaracion {$$ = $1; }
            |  asignacion  {$$ = $1; }
            |  print       {$$ = $1; }
            |  sent_if     {$$ = $1; }
            |  sent_while  {$$ = $1; }
            |  sent_dowhile{$$ = $1; }
            |  sent_for    {$$ = $1; }
            |  funciones   { $$ = $1; }
            |  llamada PYC { $$ = $1; }
            |  EXEC llamada PYC { $$ = new ejecutar.default($2, @1.first_line, @1.last_column); }
            |  BREAK PYC {$$ = new detener.default()}
            |  CONTINUE PYC {$$ = new continuar.default()}
            | RETURN PYC { $$ = new retornar.default(null)}
            | RETURN e PYC { $$ = new retornar.default($2)}
            | sw {$$=$1}
            | error         { console.log("Error Sintactico" + yytext 
                                    + "linea: " + this._$.first_line 
                                    + "columna: " + this._$.first_column); 
                        
                                          
                            }
            ;

sw: SWITCH PARA e PARC LLAVA lista_case  LLAVC {$$=new sw.default($3,$6,[])}
    |SWITCH PARA e PARC LLAVA lista_case DEFAULT DSPNTS instrucciones LLAVC {$$=new sw.default($3,$6,$9)}
    ;


lista_case : lista_case CASE e DSPNTS instrucciones     { $$ = $1; $$.push(new cs.default($3,$5)); }
                | CASE e DSPNTS instrucciones           { $$ = new Array(); $$.push(new cs.default($2,$4)); }
                ;


funciones : tipo ID PARA PARC LLAVA instrucciones LLAVC     { $$ = new funcion.default(3, $1, $2.toLowerCase() , [], true, $6, @1.first_line, @1.last_column ); }
            |tipo ID PARA lista_parametros PARC LLAVA instrucciones LLAVC  { $$ = new funcion.default(3, $1, $2.toLowerCase() , $4, true, $7, @1.first_line, @1.last_column ); }
            ;

lista_parametros : lista_parametros COMA tipo ID    { $$ = $1; $$.push(new simbolo.default(6,$3, $4.toLowerCase() , null)); }
                | tipo ID                           { $$ = new Array(); $$.push(new simbolo.default(6,$1,$2.toLowerCase(), null)); }
                ;

llamada : ID PARA PARC              { $$ = new llamada.default($1.toLowerCase() , [],@1.first_line, @1.last_column ); }
        | ID PARA lista_exp PARC    { $$ = new llamada.default($1.toLowerCase() , $3 ,@1.first_line, @1.last_column ); }
        ;

lista_exp : lista_exp COMA e        { $$ = $1; $$.push($3); }
        | e                         { $$ = new Array(); $$.push($1); }
        ;

sent_while : WHILE PARA e PARC LLAVA instrucciones LLAVC { $$ = new While.default($3, $6, @1.first_line, @1.last_column); }
            ;

sent_dowhile : DO LLAVA instrucciones LLAVC WHILE PARA e PARC PYC { $$ = new dowhile.default($7, $3, @1.first_line, @1.last_column); }
            ;

sent_if : IF PARA e PARC LLAVA instrucciones LLAVC { $$ = new Ifs.default($3, $6, [], @1.first_line, @1.last_column); }
        | IF PARA e PARC LLAVA instrucciones LLAVC ELSE LLAVA instrucciones LLAVC { $$ = new Ifs.default($3, $6, $10, @1.first_line, @1.last_column); }
        | IF PARA e PARC LLAVA instrucciones LLAVC ELSE sent_if { $$ = new Ifs.default($3, $6, [$9], @1.first_line, @1.last_column); }
        ;

sent_for: FOR PARA asignacion  e PYC asignacion2 PARC LLAVA instrucciones LLAVC { $$ = new For.default($4, $9,$3,$6, @1.first_line, @1.last_column); }
        | FOR PARA declaracion e PYC asignacion2 PARC LLAVA instrucciones LLAVC { $$ = new For.default($4, $9,$3,$6, @1.first_line, @1.last_column); }
        ;

asignacion2 :ID IGUAL e   { $$ = new asignacion.default($1.toLowerCase() ,$3, @1.first_line, @1.last_column); }
            |ID INCRE      { $$ = new asignacion.default($1.toLowerCase() ,new aritmetica.default(new identificador.default($1, @1.first_line, @1.last_column), '+',new primitivo.default(Number(1), $1.first_line, $1.last_column), $1.first_line, $1.last_column, false), @1.first_line, @1.last_column); }
            |ID DECRE      { $$ = new asignacion.default($1.toLowerCase() ,new aritmetica.default(new identificador.default($1, @1.first_line, @1.last_column), '-',new primitivo.default(Number(1), $1.first_line, $1.last_column), $1.first_line, $1.last_column, false), @1.first_line, @1.last_column); }
            ; 

print : PRINT PARA e PARC PYC  {$$ = new Print.default($3, @1.first_line, @1.last_column); }
    ; 

asignacion : ID IGUAL e PYC   { $$ = new asignacion.default($1.toLowerCase() ,$3, @1.first_line, @1.last_column); }
            |ID INCRE PYC     { $$ = new asignacion.default($1.toLowerCase() ,new aritmetica.default(new identificador.default($1, @1.first_line, @1.last_column), '+',new primitivo.default(Number(1), $1.first_line, $1.last_column), $1.first_line, $1.last_column, false), @1.first_line, @1.last_column); }
            |ID DECRE PYC     { $$ = new asignacion.default($1.toLowerCase() ,new aritmetica.default(new identificador.default($1, @1.first_line, @1.last_column), '-',new primitivo.default(Number(1), $1.first_line, $1.last_column), $1.first_line, $1.last_column, false), @1.first_line, @1.last_column); }
            ; 

declaracion : tipo lista_simbolos PYC   { $$ = new declaracion.default($1, $2, @1.first_line, @1.last_column); }
            ; 

lista_simbolos : lista_simbolos COMA ID          { $$ = $1; $$.push(new simbolo.default(1,null,$3.toLowerCase() , null)); }
            | lista_simbolos COMA ID IGUAL e     { $$ = $1; $$.push(new simbolo.default(1,null,$3.toLowerCase() , $5)); }
            | ID                                 { $$ = new Array(); $$.push(new simbolo.default(1,null,$1.toLowerCase(), null)); }
            | ID IGUAL e                         { $$ = new Array(); $$.push(new simbolo.default(1,null,$1.toLowerCase(), $3)); }
            ; 

tipo : INT      { $$ = new tipo.default('ENTERO'); }
    | DOUBLE    { $$ = new tipo.default('DOBLE'); }
    | STRING    { $$ = new tipo.default('STRING'); }
    | CHAR1      { $$ = new tipo.default('CHAR'); }
    | BOOLEAN   { $$ = new tipo.default('BOOLEAN'); }
    | VOID   { $$ = new tipo.default('VOID'); }
    ; 



e : e MAS e             {$$ = new aritmetica.default($1, '+', $3, $1.first_line, $1.last_column, false);}
    | e MENOS e         {$$ = new aritmetica.default($1, '-', $3, $1.first_line, $1.last_column, false);}
    | e MULTI e         {$$ = new aritmetica.default($1, '*', $3, $1.first_line, $1.last_column, false);}
    | e DIV e           {$$ = new aritmetica.default($1, '/', $3, $1.first_line, $1.last_column, false);}
    | e POT e           {$$ = new aritmetica.default($1, '^', $3, $1.first_line, $1.last_column, false);}
    | e MODULO e        {$$ = new aritmetica.default($1, '%', $3, $1.first_line, $1.last_column, false);}
    | e AND e           {$$ = new logica.default($1, '&&', $3, $1.first_line, $1.last_column, false);}
    | e OR e            {$$ = new logica.default($1, '||', $3, $1.first_line, $1.last_column, false);}
    | NOT e             {$$ = new logica.default($2, '!', null, $1.first_line, $1.last_column, true);}
    | e MAYORQUE e      {$$ = new relacional.default($1,'>', $3, $1.first_line, $1.last_column, false);}
    | e MAYORIGUAL e    {$$ = new relacional.default($1,'>=', $3, $1.first_line, $1.last_column, false);}
    | e MENORQUE e      {$$ = new relacional.default($1,'<', $3, $1.first_line, $1.last_column, false);}
    | e MENORIGUAL e    {$$ = new relacional.default($1,'<=', $3, $1.first_line, $1.last_column, false);}
    | e IGUALIGUAL e    {$$ = new relacional.default($1,'==', $3, $1.first_line, $1.last_column, false);}
    | e DIFERENTE e     {$$ = new relacional.default($1,'!=', $3, $1.first_line, $1.last_column, false);}
    | MENOS e %prec UNARIO {$$ = new aritmetica.default($2, 'UNARIO', null, $1.first_line, $1.last_column, true);}
    | PARA e PARC       {$$ = $2;}
    | DECIMAL           {$$ = new primitivo.default(Number(yytext), $1.first_line, $1.last_column);}
    | ENTERO            {$$ = new primitivo.default(Number(yytext), $1.first_line, $1.last_column);}
    | CADENA            {$1 = $1.slice(1, $1.length-1); $$ = new primitivo.default($1, $1.first_line, $1.last_column);}
    | CHAR              {$1 = $1.slice(1, $1.length-1); $$ = new primitivo.default($1, $1.first_line, $1.last_column);}
    | TRUE              {$$ = new primitivo.default(true, $1.first_line, $1.last_column);}
    | FALSE             {$$ = new primitivo.default(false, $1.first_line, $1.last_column);}
    | ID                {$$ = new identificador.default($1.toLowerCase() , @1.first_line, @1.last_column); }
    | e INTERROGACION e DSPNTS e {$$ = new ternario.default($1, $3, $5, @1.first_line, @1.last_column); } 
    | ID INCRE          {$$ = new aritmetica.default(new identificador.default($1.toLowerCase() , @1.first_line, @1.last_column), '+',new primitivo.default(Number(1), $1.first_line, $1.last_column), $1.first_line, $1.last_column, false);}
    | ID DECRE          {$$ = new aritmetica.default(new identificador.default($1.toLowerCase() , @1.first_line, @1.last_column), '-',new primitivo.default(Number(1), $1.first_line, $1.last_column), $1.first_line, $1.last_column, false);}
    |ID PARA PARC       { $$ = new llamada.default($1.toLowerCase() , [],@1.first_line, @1.last_column ); }
    |ID PARA lista_exp PARC { $$ = new llamada.default($1.toLowerCase() , $3 ,@1.first_line, @1.last_column ); }
    ;
