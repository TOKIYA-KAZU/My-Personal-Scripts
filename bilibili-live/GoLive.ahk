#NoEnv
确保管理员权限:
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; 需要 v1.0.92.01+
   ExitApp
}
Sendmode Input

BlockInput, On
CoordMode, Mouse, Screen
MouseGetPos, rawX, rawY
CoordMode, Mouse, Window

;~ 任务管理器:
;~ WinClose ahk_exe Taskmgr.exe
;~ WinWaitClose ahk_exe Taskmgr.exe
;~ Run, Taskmgr
;~ WinWait, ahk_exe Taskmgr.exe
;~ WinActivate
;~ WinWaitActive
;~ WinMove, ahk_exe Taskmgr.exe, , %A_ScreenWidth%, 170
;~ Click, , 66, 66
;~ Click, , 80, 100, 2

;~ 声音:
;~ WinClose, 声音 ahk_class #32770
;~ Run rundll32.exe shell32.dll`,Control_RunDLL mmsys.cpl @1
;~ WinWait, 声音 ahk_class #32770
;~ Click, 85, 55
;~ WinMove 2725, 120

弹幕姬:
TargetWin = B站彈幕姬 ahk_exe Bililive_dm.exe
Process, Close, Bililive_dm.exe
Run DMhime.appref-ms
WinWait, %TargetWin%
Sleep, 2000
WinActivate, %TargetWin%
WinMove, %TargetWin%, , %A_ScreenWidth%, 620, 600, 400
Click, , 322, 42
Click, , 190, 60
Click, , 511, 44
Sleep 500

直播间:
Run "firefox" -new-window imacros://run/?m=live.bilibili`%5CGoLive.iim
WinWaitActive, iMacros ahk_class MozillaDialogClass
Send {ENTER}
WinWaitActive, ahk_class MozillaWindowClass
Send ^f
Sleep, 0 
Sleep 1000
ClipBoard = Stream
Sleep, 0 
Sleep 1000
Send ^v
Sleep, 0 
Sleep 1000
ClipBoard = 
Send {ESC}
Sleep, 0 
Sleep 1000
Send ^a
Send ^c
ClipWait
WinClose

OBS:
TargetWin = ahk_exe obs64.exe
IfWinNotExist, %TargetWin%
{
	Run, OBS
}
WinWait, %TargetWin%
Sleep, 0
Sleep, 1000
IfWinActive, Scene Switcher
{
   Send {ENTER}
}
WinWaitNotActive, Scene Switcher
WinWait, %TargetWin%
WinActivate
WinMove, %TargetWin%, , %A_ScreenWidth%, 120
WinMaximize
WinSet, Transparent, % (0.75 * 255), %TargetWin%
WinActivate ahk_exe obs64.exe
Process, Priority, obs64.exe, A
WinMove, ahk_exe obs64.exe, 0, 0
Click, , 1217, 790
WinWait, 设置
Sleep 2000
Click, , 86, 120
Sleep 100
Click, , 492, 144, 2
Sleep 100
Send ^v
Send {ENTER}
WinWaitActive, OBS ahk_exe obs64.exe
Click, , 1214, 713
/*
CoordMode, Mouse, Screen
MouseMove, %rawX%, %rawY%
CoordMode, Mouse, Window
*/
BlockInput, Off
ExitApp

$esc::ExitApp

