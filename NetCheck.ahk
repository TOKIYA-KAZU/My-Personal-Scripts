#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;~ if not A_IsAdmin ;ȷ������ԱȨ��
;~ {
   ;~ Run *RunAs "%A_ScriptFullPath%"  ; ��Ҫ v1.0.92.01+
   ;~ ExitApp
;~ }
CoordMode, Mouse, Client



ahkcs := "http://www.steampowerd.com"
Menu, Tray, Icon, imageres.dll, 85

Loop
{
        ;~ ͼ��仯
        If (W_InternetCheckConnection(ahkcs))
        {
                NetStatus := "��������"
                Menu, Tray, Icon, imageres.dll, 21
        }
        else
        {
                NetStatus := "�����ж�"
                Menu, Tray, Icon, imageres.dll, 85
        }
        ;~ ������ʾ
        If (NetStatus != LastNetStatus)
        {
                TrayTip, , %NetStatus%
                LastNetStatus := NetStatus
        }
        Sleep, 1000
}
;        �ж��Ƿ������ĳ�� URL ��������

W_InternetCheckConnection(lpszUrl)
{
        FLAG_ICC_FORCE_CONNECTION := 0x1
        dwReserved := 0x0
        return, DllCall("Wininet.dll\InternetCheckConnection", "Ptr", &lpszUrl, "UInt", FLAG_ICC_FORCE_CONNECTION, "UInt", dwReserved, "Int")
}