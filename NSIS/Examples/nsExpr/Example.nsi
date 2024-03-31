!include MUI2.nsh
!include nsExpr.nsh

Name `nsExpr plug-in`
OutFile Example.exe
RequestExecutionLevel user

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

Section

  ${If} ${Expr} `99 > 5`
    MessageBox MB_OK|MB_ICONINFORMATION `Expression evaluated to true ($_LOGICLIB_TEMP)!`
  ${Else}
    MessageBox MB_OK|MB_ICONINFORMATION `Expression evaluated to false ($_LOGICLIB_TEMP)!`
  ${EndIf}

  !macro TestExpression Expression
    ${ExprEval} `${Expression}` $R0
    MessageBox MB_OK|MB_ICONINFORMATION `${Expression}: $R0`
  !macroend

  !insertmacro TestExpression `99 / 9 == 11 ? 1 : 0` ; 1
  !insertmacro TestExpression `== 3` ; error
  !insertmacro TestExpression `5 == 5 && (r0 < 3 || r1 < 9)` ; 1
  !insertmacro TestExpression `(R0 == 9 || r0 == 0) && (R0 == 0 || !r2)` ; 1

  SetAutoClose true

SectionEnd