#SingleInstance force
#NoEnv
ȷ������ԱȨ��:
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; ��Ҫ v1.0.92.01+
   ExitApp
}

Run "firefox"-url imacros://run/?m=TabClose.iim

ExitApp

$esc::ExitApp