@ECHO OFF
SET "NUKE="C:\Program Files\Nuke10.0v4\Nuke10.0.exe""
ECHO NUKE·��: %Nuke%
SET "serverZ=\\192.168.1.4\f"
ECHO Z������·��: %serverZ%
ECHO.
ECHO ��ʾ - ���Ա༭���������ļ�������·��
ECHO.
REM
REM ���Ϸ�����·������
REM
:����ѡ��
CHOICE /T 15 /D n /M "���ػ�����Ⱦ"
IF "%ERRORLEVEL%" EQU "1" SET "isLocalRender=TRUE"
SET "renderTime=%date:~2,2%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%"
IF NOT EXIST "%~dp0RenderLog" (
    MKDIR "%~dp0RenderLog"
)
IF /I "%isLocalRender%" EQU "TRUE" (
    IF NOT EXIST "%NUKE_TEMP_DIR%" (
        ECHO ���� - ��Ҫ���û�������%NUKE_TEMP_DIR%^(ĩβ��Ҫ��б��^)
        ECHO ����ʹ�ñ��ػ�����Ⱦ
        PAUSE
        SET "isLocalRender=FALSE"
        GOTO:��Ⱦ
    )
    ECHO ��ʾ - �����б��ػ���Ⱦ
    CALL "%~dp0all_localiseFootage.bat" "%serverZ%"
    IF EXIST "Z:\" (
        SUBST Z: /D >nul || NET USE Z: /DELETE 2>nul
        IF ERRORLEVEL 1 (        
            ECHO ���� - �޷��Ͽ�Z��
            ECHO ����ʹ�ñ��ػ�����Ⱦ
            SET "isLocalRender=FALSE"
            GOTO:Render
        )
    )
    SUBST Z: "%NUKE_TEMP_DIR%\localize\Z_"
)
SET "RenderLog="%~dp0RenderLog\RenderLog_%renderTime%.txt""
:Render
REM ��Ⱦ
SETLOCAL EnableDelayedExpansion
IF NOT EXIST "%~dp0\*.nk" (
    ECHO ���� - �����������ļ��в�����nk�ļ�
    PAUSE&GOTO:EOF
)
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
        IF NOT EXIST "%~dp0ArchivedRenderFiles\%rendertime%" (
            MKDIR "%~dp0ArchivedRenderFiles\%rendertime%"
        )
        MOVE "%%~i" "%~dp0ArchivedRenderFiles\%rendertime%\"
    )ELSE (
        ECHO.
        ECHO ����ģʽ��Ⱦ %%~nxi
        ECHO.
        %NUKE% -x -p --cont "%%~i" 2>>%RenderLog%
        SET "finishTime=!time:~0,8!"        
        ECHO !date! !startTime! !finishTime!	%%~ni^(����ģʽ^) >>%RenderLog%
    )
)
ECHO [!time:~0,8!] ��Ⱦ���
IF /I "%isLocalRender%" EQU "TRUE" (
    SUBST /D Z:
    NET USE Z: "%serverZ%" /PERSISTENT:YES
)
FOR /F "demils=" %%i in ('FORFILES /P %~dp0/Renderlog /D -30 ^| FINDSTR /I "RenderLog_.*\.txt") do (
    DEL %%i
)
EXPLORER %RenderLog%
EXIT