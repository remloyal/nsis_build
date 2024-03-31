nsExpr NSIS plug-in

Author:  Stuart 'Afrow UK' Welch
Company: Afrow Soft Ltd.
Website: http://www.afrowsoft.co.uk
E-mail:  afrowuk@afrowsoft.co.uk
Date:    9th January 2012
Version: 1.0.1.1

A small plug-in that evaluates Boolean and mathematical expressions.

See Examples\nsExpr\*.

------------------------------------------------------------------------
Usage (!include nsExpr.nsh)
------------------------------------------------------------------------

${If} ${Expr} "[expression]"
  ...

Branches depending on the result of the expression evaluation with 0 and
error being false and any other value being true.

  --------------------------------------------------------------------

${ExprEval} "[expression]" $Var

Evaluates the expression and places the result into $Var. Boolean
expressions evaluate to 0 (false) or 1 (true). Returns "error" on syntax
error or division by zero.

------------------------------------------------------------------------
Usage (plug-in)
------------------------------------------------------------------------

nsExpr::Eval "[expression]"
Pop $Var

Same as using ${EvalExpr} (above).

------------------------------------------------------------------------
Operators
------------------------------------------------------------------------

All suitable C/C++ operators are supported (in order of precedence):

Precedence  Operator  Description                          Associativity
------------------------------------------------------------------------
1           -         Unary minus                          Right-to-left
            !         Logical NOT
            ~         Logical bitwise NOT
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
2           *         Multiply                             Left-to-right
            /         Divide
            %         Modulus
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
3           +         Add                                  "
            -         Subtract
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
4           <<        Bitwise left shift                   "
            >>        Bitwise right shift
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
5           <         Less than relational                 "
            <=        Less than or equal to relational
            >         Greater than relational
            >=        Greater than or equal to relational
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
6           ==        Equal to                             "
            !=        Not equal to
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
7           &         Bitwise AND                          "
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
8           ^         Bitwise XOR                          "
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
9           |         Bitwise OR                           "
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
10          &&        Logical AND                          "
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
11          ||        Logical OR                           "
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
12          ?:        Ternary conditional                  Right-to-left
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Brackets () have the highest precedence and can be used to change the
precedence of operators, e.g:

  "$R0 * (5 + $0)"
  "$R0 == 5 && ($0 < 3 || $1 < 9)"

------------------------------------------------------------------------
Using Variables
------------------------------------------------------------------------

Variables can just be superimposed into the expression string, e.g:
  "$R0 * 5 + $0"

Or you can use R0-R9 (for $R0-$R9) and r0-r9 (for $0-$9) respectively,
e.g.:
  "R0 * 5 + r0"

The benefit of using R0 rather than $R0 however is that a syntax error
is avoided if $R0 is empty. R0 would be read as 0 if it were empty. E.g.
"$R0 + 5" would become " + 5", whereas "R0 + 5" would become "0 + 5".

Otherwise, both expressions above are the same and will produce the
same result.

------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.1.1 - 9th January 2012
* Fixed missing '/n' for skipping whitespace.

1.0.0.1 - 9th January 2012
* Reduced memory usage and improved parse efficiency.
* Fixed any operator being accepted instead of a colon for ternary
  comparison.
* Added additional comments.

1.0.0.0 - 9th January 2012
* First version.

------------------------------------------------------------------------
License
------------------------------------------------------------------------

This plug-in is provided 'as-is', without any express or implied
warranty. In no event will the author be held liable for any damages
arising from the use of this plug-in.

Permission is granted to anyone to use this plug-in for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this plug-in must not be misrepresented; you must not
   claim that you wrote the original plug-in.
   If you use this plug-in in a product, an acknowledgment in the
   product documentation would be appreciated but is not required.
2. Altered versions must be plainly marked as such, and must not be
   misrepresented as being the original plug-in.
3. This notice may not be removed or altered from any distribution.