!include "./defines.nsh"

Name "FloatOp"
OutFile "floatop.exe"
ShowInstDetails show
XPStyle on

Page instfiles


Section "-boo"
DetailPrint "Executing plugin...."
FloatOp::Autor ${VAR_0}
DetailPrint "Author: $0"
FloatOp::Ver ${VAR_1}
DetailPrint "Version: $1"
FloatOp::S 2.3 1.17 ${VAR_2} # $2 = 3.47
DetailPrint "2.3+1.17=$2"
FloatOp::R $2 9.25 ${VAR_3} # $3 = -5.78
DetailPrint "$2-9.25=$3"
FloatOp::M $3 1.102 ${VAR_4} # $4 = -6.36956
DetailPrint "$3*1.102=$4"
FloatOp::D $4 -6.4 ${VAR_5} # $5 = 0.995244
DetailPrint "$4/-6.4=$5"
DetailPrint "Plugin done."
SectionEnd
