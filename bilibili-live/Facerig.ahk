﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
if not A_IsAdmin ;确保管理员权限
{
   Run *RunAs "%A_ScriptFullPath%"  ; 需要 v1.0.92.01+
   ExitApp
}
CoordMode, Mouse, Screen
MouseGetPos, rawX, rawY
CoordMode, Mouse, Client

Run steam://rungameid/274920
WinWait, Facerig Launcher ahk_exe Launcher.exe
Sleep, 2000
Loop
{
   Click, , 80, 267
   Sleep, 2000
   WinWaitClose, Facerig Launcher ahk_exe Launcher.exe, , 5,
   
   if (ErrorLevel = 0)
   {		
	WinWait, FaceRig ahk_class FaceRigWndClass ahk_exe FaceRig.exe
	break
   }
}
WinWait, FaceRig ahk_class FaceRigWndClass ahk_exe FaceRig.exe
WinMove, , , 2233, 122
WinWait, FaceRig 已在运行!, , 2,
WinClose, FaceRig 已在运行!, , 2,

CoordMode, Mouse, Screen
MouseMove, %rawX%, %rawY%
CoordMode, Mouse, Client

ExitApp

$esc::ExitApp