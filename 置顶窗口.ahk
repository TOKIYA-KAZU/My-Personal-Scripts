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

WinWaitNotActive, ahk_exe explorer.exe
WinSet, AlwaysOnTop, Toggle, A
WinSet, Top, A


CoordMode, Mouse, Screen
MouseMove, %rawX%, %rawY%
CoordMode, Mouse, Client

ExitApp

$esc::ExitApp