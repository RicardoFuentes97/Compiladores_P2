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
"char"                  { console.log("Reconocio : "+ yytext); return 'CHAR'}
"boolean"               { console.log("Reconocio : "+ yytext); return 'BOOLEAN'}
"print"                 { console.log("Reconocio : "+ yytext); return 'PRINT'}
"if"                    { console.log("Reconocio : "+ yytext); return 'IF'}
"while"                 { console.log("Reconocio : "+ yytext); return 'WHILE'}
"else"                  { console.log("Reconocio : "+ yytext); return 'ELSE'}
"void"                  { console.log("Reconocio : "+ yytext); return 'VOID'}
"ejecutar"              { console.log("Reconocio : "+ yytext); return 'EJECUTAR'}

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
.                     return 'ERROR'

/lex

/* Area de imports */
%{
    const evaluar = require('../Clases/Evaluar');
    const aritmetica= require('../Clases/Expreciones/Operaciones/Aritmetica');
    const relacional = require('../Clases/Expreciones/Operaciones/Relaciones');
    const logica = require('../Clases/Expreciones/Operaciones/Logicas');
    const primitivo= require('../Clases/Expreciones/Primitivo');

    const ast =require('../Clases/AST/Ast');
    const declaracion = require ('../Clases/Instrucciones/Declaracion');
    const asignacion = require ('../Clases/Instrucciones/Asignacion');
    const simbolo= require ('../Clases/TablaSimbolos/Simbolos');
    const tipo= require ('../Clases/TablaSimbolos/Tipo');
%}

/* Precedencia de operadores */

%right 'INTERROGACION'
%left 'OR'
%left 'AND'
%right 'NOT'
%left 'IGUALIGUAL' 'DIFERENTE' 'MENORQUE' 'MENORIGUAL' 'MAYORQUE'  'MAYORIGUAL' 
%left 'MAS' 'MENOS'
%left 'MULTI' 'DIV' 'MODULO'
%right 'UNARIO'
%left 'POT'
 
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
            ;

asignacion : ID IGUAL e PYC   { $$ = new asignacion.default($1,$3, @1.first_line, @1.last_column); }
            ; 

declaracion : tipo lista_simbolos PYC   { $$ = new declaracion.default($1, $2, @1.first_line, @1.last_column); }
            ; 

lista_simbolos : lista_simbolos COMA ID          { $$ = $1; $$.push(new simbolo.default(1,null,$3, null)); }
            | lista_simbolos COMA ID IGUAL e     { $$ = $1; $$.push(new simbolo.default(1,null,$3, $5)); }
            | ID                                 { $$ = new Array(); $$.push(new simbolo.default(1,null,$1, null)); }
            | ID IGUAL e                         { $$ = new Array(); $$.push(new simbolo.default(1,null,$1, $3)); }
            ; 

tipo : INT      { $$ = new tipo.default('ENTERO'); }
    | DOUBLE    { $$ = new tipo.default('DOBLE'); }
    | STRING    { $$ = new tipo.default('STRING'); }
    | CHAR      { $$ = new tipo.default('CHAR'); }
    | BOOLEAN   { $$ = new tipo.default('BOOLEAN'); }
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
    ;
