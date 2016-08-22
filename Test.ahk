; 环境: AutoHotkey 1.1.05.01 Unicode, Windows XP

#NoEnv

ahkcs := "http://www.steampowered.com"

;~ MsgBox, % "上网方式: " W_InternetGetConnectedState() "`n连接状态: " W_IsNetworkAlive() "`n"
MsgBox, % W_InternetCheckConnection(ahkcs) ? "成功连接到 baidu.com":"连接失败"
Return

;        判断网络连接方式
W_InternetGetConnectedState()
{
        INTERNET_CONNECTION_MODEM := 0x01
        INTERNET_CONNECTION_LAN := 0x02
        INTERNET_CONNECTION_PROXY := 0x04
        
        lpdwFlags := ""        ; 上网方式
        IsOnline := TRUE        ; 是否在线
        dwReserved := 0
        
        IsOnline := DllCall("Wininet.dll\InternetGetConnectedState", "UInt*", lpdwFlags, "Uint", dwReserved, "Int")
        if (IsOnline)        ; 在线  
        {  
                if ((lpdwFlags & INTERNET_CONNECTION_MODEM) = INTERNET_CONNECTION_MODEM)
                {
                        return, "Local system uses a modem to connect to the Internet."
                }
                if ((lpdwFlags & INTERNET_CONNECTION_LAN) = INTERNET_CONNECTION_LAN)
                {
                        return, "Local system uses a local area network to connect to the Internet."
                }
                if ((lpdwFlags & INTERNET_CONNECTION_PROXY) = INTERNET_CONNECTION_PROXY)
                {
                        return, "Local system uses a proxy server to connect to the Internet."
                }
        }
        else
                return, "Local system is in offline mode."
}

;        判断当前网络连接状态
W_IsNetworkAlive()
{
    NETWORK_ALIVE_LAN := 0x1
    NETWORK_ALIVE_WAN := 0x2
    NETWORK_ALIVE_AOL := 0x4
        
          lpdwFlags := ""        ; 上网方式
        IsOnline := TRUE        ; 是否在线

        IsOnline := DllCall("Sensapi.dll\IsNetworkAlive", "UInt*", lpdwFlags)
        if A_LastError
                return, "ERROR"
        if (IsOnline)
        {  
                if ((lpdwFlags & NETWORK_ALIVE_LAN) = NETWORK_ALIVE_LAN)
                {
                        return, "NETWORK_ALIVE_LAN"
                }
                if ((lpdwFlags & NETWORK_ALIVE_WAN) = NETWORK_ALIVE_WAN)
                {
                        return, "NETWORK_ALIVE_WAN"
                }
                if ((lpdwFlags & NETWORK_ALIVE_AOL) = NETWORK_ALIVE_AOL)
                {
                        return, "NETWORK_ALIVE_AOL"
                }
        }
        else
                return, "Local system is in offline mode."
}

;        判断是否可以与某个 URL 建立连接
W_InternetCheckConnection(lpszUrl)
{
        FLAG_ICC_FORCE_CONNECTION := 0x1
        dwReserved := 0x0
        return, DllCall("Wininet.dll\InternetCheckConnection", "Ptr", &lpszUrl, "UInt", FLAG_ICC_FORCE_CONNECTION, "UInt", dwReserved, "Int")
}