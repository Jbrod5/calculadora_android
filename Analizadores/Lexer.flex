/* - - - - - - - - - - - - - - - - - CODIGO DE USUARIO - - - - - - - - - - - - - - - - - */

package com.jbrod.calculadoracompi.analizadores;
import java_cup.runtime.*;

%%


/*  - - - - - - - - - - - - - - - - - DECLARACIONES  - - - - - - - - - - - - - - - - - */
%public 
%class Lexer
%cup
%line
%column


//Numeros
entero = [0-9]+
decimal = [0-9]+"."[0-9]+

//Operaciones
mult = "*"
divi = "/"
suma = "+"
rest = "-"
para = "("
parc = ")"
coma = ","

LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]
WhiteSpaceOp ={WhiteSpace}*

%{

    // Manejo de tokens
    private Symbol symbol(int type){
        return new Symbol(type, yyline + 1, yycolumn + 1);
    }

    private Symbol symbol(int type, Object value){
        //System.out.println("Token reconocido: " + yytext());
        return new Symbol(type, yyline + 1, yycolumn + 1, value);
    }

    private void error(String message){
        //System.out.println("Error en la linea: " + (yyline + 1) + " columna: " + (yycolumn + 1) + " : " + message);
    }

    
%}


%%

/*  - - - - - - - - - - - - - - - - - REGLAS LEXICAS  - - - - - - - - - - - - - - - - - */

/* numeros */
{decimal} { return symbol(sym.NUMERO, Double.parseDouble(yytext())); }
{entero}  { return symbol(sym.NUMERO, Double.parseDouble(yytext() + ".0")); }


/* operaciones / simbolos */
{mult} {return symbol(sym.MULTIPLICACION); }
{divi} {return symbol(sym.DIVISION); }
{suma} {return symbol(sym.SUMA); }
{rest} {return symbol(sym.RESTA); }
{para} {return symbol(sym.PARA); }
{parc} {return symbol(sym.PARC); }
{coma} {return symbol(sym.COMA); }

/* error fallback */
{WhiteSpace} { /* No hacer nada */ }

[^]            { /*System.out.println("No se reconocio el lexema " + yytext() + " como un token valido y se ignoro.");*/
                 /*errores.agregarError(yytext(), yyline +1, yycolumn + 1, "Lexico", "El simbolo no se encuentra definido en el alfabeto.");*/}
<<EOF>>        { return symbol(sym.EOF); }