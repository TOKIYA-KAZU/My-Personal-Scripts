@ECHO off
SET NUKE="C:\Program Files\Nuke10.0v4\Nuke10.0.exe"
SET serverZ=\\192.168.1.4\f
CHOICE /T 15 /D n /M "������Ⱦ"
IF "%ERRORLEVEL%" EQU "1" SET isLocalRender=Y
MKDIR "%~dp0RenderLog" 2>nul
IF /I "%isLocalRender%" EQU "Y" (
    ECHO �����б��ػ���Ⱦ
    NET USE Z: /DELETE 2>nul
    SUBST Z: "D:\Cache\Nuke\localize\Z_"
)
SET renderTime=%date:~2,2%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%
SETLOCAL enabledelayedexpansion
FOR %%i in ("%~dp0\*.nk") do (
    @IF /I "%isLocalRender%" EQU "Y" "%~dp0localiseFootage.bat" %%~i
	SET startTime=!time:~0,8!
    @IF /I "%~1" NEQ "-PROXY" (
        ECHO.
        ECHO ȫ�ߴ���Ⱦ %%~nxi 
        ECHO.
        %NUKE% -x -f --cont "%%~i" 2>>"%~dp0Renderlog\Renderlog_%renderTime%.txt"
        SET finishTime=!time:~0,8!
        ECHO !date! !startTime! !finishTime!	%%~ni >>"%~dp0Renderlog\Renderlog_%renderTime%.txt"
        )ELSE (
        ECHO.
        ECHO ����ģʽ��Ⱦ %%~nxi
        ECHO.
        %NUKE% -x -p --cont "%%~i" 2>>"%~dp0Renderlog\Renderlog_%renderTime%.txt"
        SET finishTime=!time:~0,8!        
        ECHO !date! !startTime! !finishTime!	%%~ni^(����ģʽ^) >>"%~dp0Renderlog\Renderlog_%renderTime%.txt"
        )    
)
IF /I %isLocalRender% EQU Y (
    SUBST /D Z:
    NET USE Z: "%severZ%" /PERSISTENT:YES
)
ECHO !time:~0,8! ��Ⱦ���
START "%~dp0Renderlog\Renderlog_%renderTime%.txt"
EXIT