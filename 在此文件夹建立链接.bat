SET UserDir=Z:\SNJYW\Comp\mov\EP02\05
::REM ����ļ������ö��ŷָ�,��ʽΪ "�ļ���1","�ļ���2",...
FOR /R "Z:\SNJYW\Comp\mov\EP02\05\" %%i in (*) do (
ECHO %%~ni
::MKLINK %%~ni %%i
)
PAUSE