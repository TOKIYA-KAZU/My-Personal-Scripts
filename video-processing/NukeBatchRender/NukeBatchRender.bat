@ECHO OFF
TITLE Nuke����Ⱦv1.0
SETLOCAL EnableDelayedExpansion
REM ��ɺ�����ѡ��
IF 
CHOICE 
ECHO.
IF "%ERRORLEVEL%" EQU "1" (
    ECHO ���ִ˴��ڿ�����ʵ����Ⱦ����Զ�����
    TITLE ���� - ��Ⱦ��ɺ�
    START 
    ECHO.
    CHOICE 
    IF ERRORLEVEL 2 EXIT
    SHUTDOWN 
)
:StartUp
REM
REM ���·�����·������
REM
SET "NUKE="C:\Program Files\Nuke10.0v4\Nuke10.0.exe""
SET "serverZ=\\192.168.1.4\f"
REM
REM ���Ϸ�����·������
REM
ECHO ��Ⱦʱʹ�õ�NUKE·��: %NUKE%
ECHO ���ػ���ʱʹ�õ�Z������·��: %serverZ%
ECHO.
ECHO ��ʾ - ���Ա༭���������ļ�ͷ��������·��
ECHO.
:SettingCheck
REM ���·������
FOR 
FOR 
IF NOT EXIST !NUKE! (
    ECHO ���� - �ļ������õ�·������ȷ
    ECHO ���ֶ�����Nuke·��^(����Դ��������Nuke.exe�Ͻ�������^)
    SET 
    IF "!inputTemp!" NEQ "" (
        SET "NUKE=!inputTemp!"
        SET "inputTemp="
    )
    GOTO SettingCheck
)
IF NOT EXIST "!serverZ!" (
    ECHO ���� - �ļ����������߻򲻴���
    ECHO ���ֶ����÷���������·��(����Դ���������ļ����Ͻ�������^)
    SET 
    IF "!inputTemp!" NEQ "" (
        SET "serverZ=!inputTemp!"
        SET "inputTemp="
    )
    GOTO SettingCheck
)
REM ����ѡ��
CHOICE 
IF "%ERRORLEVEL%" EQU "1" SET "isLocalRender=TRUE"
IF 
    SET "isProxyRender=TRUE"
) ELSE (
    ECHO.
    ECHO ����ߴ�:
    CHOICE 
    IF "!ERRORLEVEL!" EQU "1" SET "isProxyRender=TRUE"
    IF "!ERRORLEVEL!" EQU "2" SET "isProxyRender=FALSE"
)
ECHO.
ECHO ��Ⱦ�������ȼ�:
CHOICE 
IF "%ERRORLEVEL%" EQU "1" SET "isLowPriority=TRUE"
IF "%ERRORLEVEL%" EQU "2" SET "isLowPriority=FALSE"
REM Ϊ��Ⱦ��־��׼��
SET "renderTime=%date:~2,2%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%"
IF NOT EXIST "%~dp0RenderLog" (
    MKDIR "%~dp0RenderLog"
)
REM �Ͽ�Z��ӳ�䲢����ӳ��Z�̵������ļ���
IF 
    IF NOT EXIST "%NUKE_TEMP_DIR%" (
        ECHO ���� - ��Ҫ���û�������%NUKE_TEMP_DIR%^(ĩβ��Ҫ��б��^)
        ECHO ����ʹ�ñ��ػ�����Ⱦ
        PAUSE
        SET "isLocalRender=FALSE"
        GOTO:Render
    )
    ECHO.
    ECHO ��ʾ - �����б��ػ���Ⱦ
    IF EXIST "Z:\" (
        SUBST Z: 
        IF ERRORLEVEL 1 (        
            ECHO ���� - �޷��Ͽ�Z��
            ECHO ����ʹ�ñ��ػ�����Ⱦ
            SET "isLocalRender=FALSE"
            GOTO:Render
        )
    )
    SUBST Z: "%NUKE_TEMP_DIR%\localize\Z_"
    REM ����all_localiseFootage.bat�������ز�
    IF NOT EXIST "%~dp0all_localiseFootage.bat" (
        ECHO �Ҳ����ļ� - all_localiseFootage.bat
        ECHO ����ʹ�ñ��ػ�����Ⱦ
        PAUSE
        SET "isLocalRender=FALSE"
        GOTO:Render
    )
    IF NOT EXIST "%~dp0localiseFootage.bat" (
        ECHO �Ҳ����ļ� - localiseFootage.bat
        ECHO ����ʹ�ñ��ػ�����Ⱦ
        PAUSE
        SET "isLocalRender=FALSE"
        GOTO:Render
    )
    CALL "%~dp0all_localiseFootage.bat" "%serverZ%"
)
SET "RenderLog="%~dp0RenderLog\RenderLog_%renderTime%.txt""
:Render
REM ��Ⱦ
IF NOT EXIST "%~dp0\*.nk" (
    ECHO ���� - �����������ļ��в�����nk�ļ�
    PAUSE&GOTO:EOF
)
FOR %%i in ("%~dp0\*.nk") do (
	SET "startTime=!time:~0,8!"
	IF 
	    REM ������Ⱦ
	    ECHO.
        ECHO ����ģʽ��Ⱦ %%~nxi
        ECHO.
        IF  
            ECHO --�����ȼ�
            ECHO.
            %NUKE% -x -p --cont --priority low "%%~i" 2>>%RenderLog%
        ) ELSE (
            %NUKE% -x -p --cont "%%~i" 2>>%RenderLog%
        )
        SET "finishTime=!time:~0,8!"
        ECHO !date! !startTime! !finishTime!	%%~ni^(����ģʽ^) >>%RenderLog%
	) ELSE (
	    REM ȫ�ߴ���Ⱦ
        ECHO.
        ECHO ȫ�ߴ���Ⱦ %%~nxi 
        ECHO.
        IF  
            ECHO --�����ȼ�
            ECHO.
            %NUKE% -x -f --cont --priority low "%%~i" 2>>%RenderLog%
        ) ELSE (
            %NUKE% -x -f --cont "%%~i" 2>>%RenderLog%
        )
        SET "finishTime=!time:~0,8!"
        ECHO !date! !startTime! !finishTime!	%%~ni >>%RenderLog%
        IF NOT EXIST "%~dp0ArchivedRenderFiles\%rendertime%" (
            MKDIR "%~dp0ArchivedRenderFiles\%rendertime%"
        )
        MOVE "%%~i" "%~dp0ArchivedRenderFiles\%rendertime%\"
	)
)
ECHO [!time:~0,8!] ��Ⱦ���
REM ����ӳ���Z��
IF 
    SUBST 
    NET USE Z: "%serverZ%" 
)
REM ����2����ǰ����־
FOR 
    DEL %%i
)
EXPLORER %RenderLog%
EXIT