!ifndef __NsExpr_H__
!define __NsExpr_H__

!include LogicLib.nsh

!macro _ExprEval _e _o
  nsExpr::Eval `${_e}`
  Pop ${_o}
!macroend
!define ExprEval `!insertmacro _ExprEval`

!macro _Expr _a _b _t _f
  !insertmacro _LOGICLIB_TEMP
  nsExpr::Eval `${_b}` `${_t}` `${_f}`
  Pop $_LOGICLIB_TEMP
  !insertmacro _= $_LOGICLIB_TEMP 0 `${_f}` `${_t}`
!macroend
!define Expr `"" Expr`

!endif