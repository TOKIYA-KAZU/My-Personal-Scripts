@ECHO off
SET "NUKE="C:\Program Files\Nuke10.0v4\Nuke10.0.exe""
REM
REM ���Ϸ�����·������
REM
CHDIR /D "%~dp0images"
ECHO ɾ�������ļ�:
FOR /F %%i IN ('DIR /B "*_proxy.*"') DO (DEL "%%~i")
ECHO ɾ����ʱ�ļ�:
FOR /F %%i IN ('DIR /B "*.tmp"') DO (DEL "%%~i")
CHDIR /D "%~dp0"
FOR /F %%i IN ('DIR /B "ContactSheet*.nk"') DO (
    ECHO.
    ECHO ȫ�ߴ���Ⱦ %%~i
    ECHO.
    %NUKE% -x -f --cont "%%~i"
)
EXIT