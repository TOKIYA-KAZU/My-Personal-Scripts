::@ECHO off
SET "NUKE="C:\Program Files\Nuke10.0v4\Nuke10.0.exe""
SET "serverZ=\\192.168.1.4\f"
REM
REM ���Ϸ�����·������
REM
::����ѡ��
CHOICE /T 15 /D n /M "������Ⱦ"
IF "%ERRORLEVEL%" EQU "1" SET "isLocalRender=TRUE"
SET "renderTime=%date:~2,2%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%"
IF NOT EXIST "%~dp0RenderLog" (
    MKDIR "%~dp0RenderLog"
)
SET "RenderLog="%~dp0RenderLog\Renderlog_%renderTime%.txt""
::��Ⱦ
IF /I "%isLocalRender%" EQU "TRUE" (
    ECHO �����б��ػ���Ⱦ
    NET USE Z: /DELETE 2>nul
    SUBST Z: "D:\Cache\Nuke\localize\Z_"
)
SETLOCAL EnableDelayedExpansion
FOR %%i in ("%~dp0\*.nk") do (
    @IF /I "%isLocalRender%" EQU "Y" "%~dp0localiseFootage.bat" %%~i 2>>%RenderLog%
	SET "startTime=!time:~0,8!"
    @IF /I "%~1" NEQ "-PROXY" (
        ECHO.
        ECHO ȫ�ߴ���Ⱦ %%~nxi 
        ECHO.
        %NUKE% -x -f --cont "%%~i" 2>>%RenderLog%
        SET "finishTime=!time:~0,8!"
        ECHO !date! !startTime! !finishTime!	%%~ni >>%RenderLog%
        )ELSE (
        ECHO.
        ECHO ����ģʽ��Ⱦ %%~nxi
        ECHO.
        %NUKE% -x -p --cont "%%~i" 2>>%RenderLog%
        SET "finishTime=!time:~0,8!"        
        ECHO !date! !startTime! !finishTime!	%%~ni^(����ģʽ^) >>%RenderLog%
        )    
)
IF /I "%isLocalRender%" EQU "TRUE" (
    SUBST /D Z:
    NET USE Z: "%serverZ%" /PERSISTENT:YES
)
ECHO [!time:~0,8!] ��Ⱦ���
EXPLORER %RenderLog%
GOTO:EOF