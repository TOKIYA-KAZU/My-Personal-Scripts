#NoEnv
ȷ������ԱȨ��:
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; ��Ҫ v1.0.92.01+
   ExitApp
}
Sendmode event

BlockInput, On

Run "firefox" -new-window imacros://run/?m=live.bilibili`%5CEndLive.iim
WinWaitActive, iMacros ahk_class MozillaDialogClass
Send {ENTER}
WinClose OBS ahk_exe obs64.exe
WinActivate �˳�OBS?, , 2
WinWaitActive �˳�OBS?, , 2
If (ErrorLevel = 0) 
	Send {Enter}

BlockInput, Off
ExitApp

$Esc::ExitApp