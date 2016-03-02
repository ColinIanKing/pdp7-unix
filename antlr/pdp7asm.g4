/*
BSD License

Copyright (c) 2013, Tom Everett
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of Tom Everett nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

grammar pdp7asm;

prog
   : line +
   ;

line
   : declarations? comment? eol
   ;

declarations
   : declaration (';' declaration)*
   ;

declaration
   : label? (instruction | assignment | expression)?
   ;

instruction
   : opcode argument*
   ;

argument
   : expression
   ;

assignment
   : (variable | LOC | RELOC) '=' expression
   ;

expression
   : multiplyingExpression ((PLUS | MINUS) multiplyingExpression)*
   ;

multiplyingExpression
   : atom ((TIMES | DIV) atom)*
   ;

atom
   : variable
   | LOC
   | RELOC
   | string
   | DECIMAL
   | DECIMAL_MINUS
   | OCTAL
   | signeddecimal
   | signedoctal
   ;

string
    : STRING OCTAL_LITERAL* '>'?
    ;

signeddecimal
   : '-'? DECIMAL_LITERAL
   ;

signedoctal
     : '-'? OCTAL_LITERAL
     ;

eol
   : EOL
   ;

comment
   : COMMENT
   ;

label
   : LABEL
   ;

variable
   : IDENTIFIER
   ;

opcode
   : 'dac'
   | 'jms'
   | 'dzm'
   | 'lac'
   | 'xor'
   | 'add'
   | 'tad'
   | 'xct'
   | 'isz'
   | 'and'
   | 'sad'
   | 'jmp'
   | 'nop'
//   | 'i'
   | 'law'
   | 'cma'
   | 'las'
   | 'ral'
   | 'rar'
   | 'hlt'
   | 'sma'
   | 'sza'
   | 'snl'
   | 'skp'
   | 'sna'
   | 'szl'
   | 'rtl'
   | 'rtr'
   | 'cil'
   | 'rcl'
   | 'rcr'
   | 'cia'
   | 'lrs'
   | 'lrss'
   | 'lls'
   | 'llss'
   | 'als'
   | 'alss'
   | 'mul'
   | 'idiv'
   | 'lacq'
   | 'clq'
   | 'omq'
   | 'cmq'
   | 'lmq'
   | 'dscs'
   | 'dslw'
   | 'dslm'
   | 'dsld'
   | 'dsls'
   | 'dssf'
   | 'dsrs'
   | 'iof'
   | 'ion'
   | 'caf'
   | 'clon'
   | 'clsf'
   | 'clof'
   | 'ksf'
   | 'krb'
   | 'tsf'
   | 'tcf'
   | 'tls'
   | 'sck'
   | 'cck'
   | 'lck'
   | 'rsf'
   | 'rsa'
   | 'rrb'
   | 'psf'
   | 'pcf'
   | 'psa'
   | 'cdf'
   | 'rlpd'
   | 'lda'
   | 'wcga'
   | 'raef'
   | 'rlpd'
   | 'beg'
   | 'spb'
   | 'cpb'
   | 'lpb'
   | 'wbl'
   | 'dprs'
   | 'dpsf'
   | 'dpcf'
   | 'dprc'
   | 'crsf'
   | 'crrb'
   | 'sys'
   | 'czm'
   ;

LOC
   : '.'
   ;


RELOC
   : '..'
   ;


PLUS
   : '+'
   ;


MINUS
   : '-'
   ;


TIMES
   : '*'
   ;


DIV
   : '/'
   ;


LABEL
   : [a-zA-Z0-9] + ':'
   ;


IDENTIFIER
   : [a-zA-Z] [a-zA-Z0-9]*
   ;


OCTAL_LITERAL
   : '0' [0-7]*
   ;

DECIMAL_LITERAL
   : [1-9] [0-9]*
   ;


DECIMAL
   : 'd' [0-9] +
   ;


OCTAL
   : 'o' [0-7] +
   ;


DECIMAL_MINUS
   : 'dm' [0-9] +
   ;


STRING
   : '<' [a-zA-Z0-9$*,%/]*
   ;


COMMENT
   : '"' ~ [\r\n]*
   ;


EOL
   : [\r\n]+
   ;


WS
   : [ \t] -> skip
   ;
