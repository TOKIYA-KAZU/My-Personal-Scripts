@ECHO off

SET targetFolder=
SET localFolder=

START explorer.exe "%targetFolder%"
ECHO ���ֶ����������ļ�
PAUSE
FOR /F "delims=" %%i in ('DIR /B "%~dp0\%localFolder%"') do (
    ECHO. && ECHO %%i
    MKLINK /J "%targetFolder%\%%i" "%~dp0\%localFolder%\%%i" 1>nul
)
PAUSE