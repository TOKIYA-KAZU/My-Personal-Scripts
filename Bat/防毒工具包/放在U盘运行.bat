@echo off
echo !��ɾ������Ϊskypee;27272;autorun.inf;4c4;a9a9a;383���ļ��л��ļ�
pause
cd %~d0\
echo !��ֹ��������
taskkill /F /FI "IMAGENAME eq AutoIt*"
echo !ɾ��U�̲����ļ�
attrib -s -h -a -r skypee
attrib -s -h -a -r 27272
attrib -s -h -a -r autorun.inf
attrib -s -h -a -r 4c4
attrib -s -h -a -r a9a9a
attrib -s -h -a -r 383
rd skypee /s /q
rd 27272 /s /q
rd 4c4 /s /q
rd a9a9a /s /q
rd 383 /s /q
del autorun.inf /f /q 
echo !��������ͬ���ļ�ռλ
del skypee /f /q 
cd.>skypee
del 27272 /f /q
cd.>27272
del 4c4 /f /q
cd.>4c4
del a9a9a /f /q
cd.>a9a9a
del 383 /f /q
cd.>383
rd autorun.inf /s /q
md autorun.inf
md autorun.inf\������_��ɾ
attrib +s +h +a +r skypee
attrib +s +h +a +r 27272
attrib +s +h +a +r 4c4
attrib +s +h +a +r a9a9a
attrib +s +h +a +r 383
attrib +s +h +a +r autorun.inf
echo !ɾ��C�̲����ļ�
attrib -s -h -a -r C:\Google
attrib -s -h -a -r C:\Skypee
rd C:\Google /s /q
rd C:\Skypee /s /q
echo !����C�̲���ͬ���ļ�ռλ
del C:\Google /f /q
cd.>C:\Google
del C:\Skypee /f /q
cd.>C:\Skypee
attrib +s +h +a +r C:\Google
attrib +s +h +a +r C:\Skypee
echo !ɾ�������ļ��еĽű��ļ�
cd /d %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
attrib -s -h -a -r *.js
del *.js /f /q
echo !��1126�²���
::��ֹ����
taskkill /fi "imagename eq fun.exe" /f
taskkill /fi "imagename eq dc.exe" /f
taskkill /fi "imagename eq sviq.exe" /f
::���õ�ǰĿ¼
cd /d c:\
cd c:\Windows
::ɾ�������ļ�
attrib -s -h -a -r fun.exe
attrib -s -h -a -r dc.exe
attrib -s -h -a -r sviq.exe
del dc.exe /f /q
del sviq.exe /f /q
del fun.exe /f /q
::��������ͬ���ļ�ռλ
rd fun.exe /s /q
md fun.exe
md fun.exe\������_��ɾ
rd dc.exe /s /q
md dc.exe
md dc.exe\������_��ɾ
rd sviq.exe /s /q
md sviq.exe
md sviq.exe\������_��ɾ
attrib +s +h +a +r fun.exe
attrib +s +h +a +r dc.exe
attrib +s +h +a +r sviq.exe
echo ����������������������������������������������������������
echo ���������ʾ�ܾ��������Ҽ�����ԱȨ����������һ����ļ�����
echo ����������������������������������������������������������
pause