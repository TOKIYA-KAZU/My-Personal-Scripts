@ECHO off
SET "NUKE="C:\Program Files\Nuke10.0v4\Nuke10.0.exe""
SET "serverZ=\\192.168.1.4\f"
REM
REM 在上方设置路径变量
REM
::设置选项
SET "renderTime=%date:~2,2%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%"
IF NOT EXIST "%~dp0RenderLog" (
    MKDIR "%~dp0RenderLog"
)
SET "RenderLog="%~dp0RenderLog\RenderLog_%renderTime%.txt""
::渲染
SETLOCAL EnableDelayedExpansion
FOR %%i in ("%~dp0\*.nk") do (
    @IF /I "%isLocalRender%" EQU "Y" "%~dp0localiseFootage.bat" %%~i 2>>%RenderLog%
	SET "startTime=!time:~0,8!"
    @IF /I "%~1" NEQ "-PROXY" (
        ECHO.
        ECHO 全尺寸渲染 %%~nxi 
        ECHO.
        %NUKE% -x -f --cont "%%~i" 2>>%RenderLog%
        SET "finishTime=!time:~0,8!"
        ECHO !date! !startTime! !finishTime!	%%~ni >>%RenderLog%
        IF NOT EXIST "%~dp0ArchivedRenderFiles\%rendertime%" (
            MKDIR "%~dp0ArchivedRenderFiles\%rendertime%"
        )
        MOVE "%%~i" "%~dp0ArchivedRenderFiles\%rendertime%\"
    )ELSE (
        ECHO.
        ECHO 代理模式渲染 %%~nxi
        ECHO.
        %NUKE% -x -p --cont "%%~i" 2>>%RenderLog%
        SET "finishTime=!time:~0,8!"        
        ECHO !date! !startTime! !finishTime!	%%~ni^(代理模式^) >>%RenderLog%
    )
)
ECHO [!time:~0,8!] 渲染完成
FOR /F "demils=" %%i in ('FORFILES /P %~dp0/Renderlog /D -30 ^| FINDSTR /I "RenderLog_.*\.txt") do (
    DEL %%i
)
EXPLORER %RenderLog%
EXIT