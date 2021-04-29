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

/* Operadores Relacionales */
"<"                     { console.log("Reconocio : "+ yytext); return 'MENORQUE'}
">="                    { console.log("Reconocio : "+ yytext); return 'MAYORIGUAL'}
">"                     { console.log("Reconocio : "+ yytext); return 'MAYORQUE'}

/* Operadores Logicos */
"&&"                    { console.log("Reconocio : "+ yytext); return 'AND'}
"!"                     { console.log("Reconocio : "+ yytext); return 'NOT'}

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
%}

/* Precedencia de operadores */

%right 'INTERROGACION'
%left 'AND'
%right 'NOT'
%left 'MENORQUE' 'MAYORQUE' 'IGUALIGUAL' 'MAYORIGUAL'
%left 'MAS' 'MENOS'
%left 'MULTI' 'DIV'
%right 'UNARIO'


%start inicio

%% /* Gramatica */


inicio
    : instrucciones EOF { $$ = $1;  return $$; }
    ;

instrucciones : instrucciones instruccion   { $$ = $1; $$.push($2); }
            | instruccion                   {$$= new Array(); $$.push($1); }
            ;

instruccion :   e  PYC { $$ = new evaluar.default($1); }
            ;

e : e MAS e             {$$ = new aritmetica.default($1, '+', $3, $1.first_line, $1.last_column, false);}
    | e MENOS e         {$$ = new aritmetica.default($1, '-', $3, $1.first_line, $1.last_column, false);}
    | e MULTI e         {$$ = new aritmetica.default($1, '*', $3, $1.first_line, $1.last_column, false);}
    | e DIV e           {$$ = new aritmetica.default($1, '/', $3, $1.first_line, $1.last_column, false);}
    | e AND e           {$$ = new logica.default($1, '&&', $3, $1.first_line, $1.last_column, false);}
    | NOT e             {$$ = new logica.default($2, '!', null, $1.first_line, $1.last_column, true);}
    | e MAYORQUE e      {$$ = new relacional.default($1, '>', $3, $1.first_line, $1.last_column, false);}
    | e MAYORIGUAL e      {$$ = new relacional.default($1, '>=', $3, $1.first_line, $1.last_column, false);}
    | e MENORQUE e      {$$ = new relacional.default($1, '<', $3, $1.first_line, $1.last_column, false);}
    | e IGUALIGUAL e      {$$ = new relacional.default($1, '==', $3, $1.first_line, $1.last_column, false);}
    | MENOS e %prec UNARIO {$$ = new aritmetica.default($2, 'UNARIO', null, $1.first_line, $1.last_column, true);}
    | PARA e PARC       {$$ = $2;}
    | DECIMAL           {$$ = new primitivo.default(Number(yytext), $1.first_line, $1.last_column);}
    | ENTERO            {$$ = new primitivo.default(Number(yytext), $1.first_line, $1.last_column);}
    | CADENA            {$1 = $1.slice(1, $1.length-1); $$ = new primitivo.default($1, $1.first_line, $1.last_column);}
    | CHAR              {$1 = $1.slice(1, $1.length-1); $$ = new primitivo.default($1, $1.first_line, $1.last_column);}
    | TRUE              {$$ = new primitivo.default(true, $1.first_line, $1.last_column);}
    | FALSE             {$$ = new primitivo.default(false, $1.first_line, $1.last_column);}
    | ID                {$$ = new identificador.default($1, @1.first_line, @1.last_column); }
    | e INTERROGACION e DSPNTS e {$$ = new ternario.default($1, $3, $5, @1.first_line, @1.last_column); } 
    | ID INCRE          {$$ = new aritmetica.default($1, '+', 1, $1.first_line, $1.last_column, false);}
  
    ;
