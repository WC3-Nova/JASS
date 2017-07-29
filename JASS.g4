grammar JASS;

/*
 * Parser Rules
 */

code: ((globals | fn) NEWLINE)* ;

globals: 'globals' NEWLINE globalBlock? 'endglobals' ;
globalBlock: ((decl?) NEWLINE)+;

fn: 'function ' identifier ' takes ' argList ' returns ' (type | 'nothing') NEWLINE  (statementBlock)? 'endfunction' ;

identifier: LETTER+ (LETTER | DIGIT | UNDERSCORE)* ;
argList: (arg COMMA)* arg
       | 'nothing'
       ;

arg: type identifier ;

type: primitive
    | builtin
    ;

statementBlock: statement+ ;
statement: (ifBlock | loop | localDecl | set | call | exitwhen)? NEWLINE;

decl: type identifier (EQUAL expr)? ;

localDecl: 'local' decl ;
set: 'set' identifier EQUAL expr ;
call: 'call' fnCall;
loop: 'loop' NEWLINE statementBlock? 'endloop' ;
exitwhen: 'exitwhen' logicalExpr ;

logicalExpr: OPEN_PAR logicalExpr CLOSE_PAR
           | 'not' logicalExpr
           | logicalExpr ' and ' logicalExpr
           | logicalExpr ' or ' logicalExpr
           | identifier '==' value
           | identifier
           | 'true' | 'false'
           ;

ifBlock: 'if ' logicalExpr ' then' (statementBlock)? (elseifBlock+)? (elseBlock)? 'endif' ;
elseifBlock: 'elseif ' logicalExpr ' then' (statementBlock)? ;
elseBlock: 'else' (statementBlock)? ;


expr: expr ('*' | '/') expr
    | expr ('+' | '-') expr
    | 'null'
    | value
    ;

fnCall: identifier OPEN_PAR fnInputList? CLOSE_PAR ;
fnInputList: (value COMMA)* value ;

value: identifier
     | fnCall
     | INT
     | FLOAT
     | STRING
     | 'true'
     | 'false'
     ;

primitive: 'boolean' | 'integer' | 'real' ;
builtin: 'player' | 'unit' | 'trigger' ;

/*
 * Lexer Rules
 */
LETTER  : [A-Za-z] ;
COMMA   : ',' ;
EQUAL   : '=' ;
DIGIT   : [0-9] ;
NEWLINE : [\r\n]+ ;
WS      : [ \t] -> channel(HIDDEN) ;
UNDERSCORE : '_' ;

INT     : '-'? [0-9]+ ;
FLOAT   : '-'? [0-9]* '.' [0-9]+ ;
STRING  : ('"' .*? '"') | ('\'' .*? '\'');

OPEN_PAR: '(' ;
CLOSE_PAR: ')' ;

SLASH   : '/' ;
COMMENT : SLASH SLASH .*? NEWLINE -> channel(HIDDEN) ;
