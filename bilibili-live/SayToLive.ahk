#NoEnv
确保管理员权限:
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; 需要 v1.0.92.01+
   ExitApp
}
Sendmode Input

InputBox, TEXT, , 输入内容, , 250, 125, , , , , ,

BlockInput, On

Run "firefox" -new-window imacros://run/?m=live.bilibili`%5CSayToLive.iim
WinMaximize, ahk_exe firefox.exe
WinWaitActive, iMacros ahk_class MozillaDialogClass
Send {ENTER}
WinWaitActive, ahk_exe firefox.exe, , , iMacros ahk_class MozillaDialogClass
Send ^f
Sleep 1000
ClipBoard = ForFindingTheTextInputBox
Send ^v
Sleep 1000
Send {ESC}
Sleep 500
Send ^a
ClipBoard = %TEXT%
Send ^v
BlockInput off
ExitApp

$Esc::ExitApp