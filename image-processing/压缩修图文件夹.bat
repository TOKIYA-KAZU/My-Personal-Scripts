SET "MarkFile="%~1\��ͼ Nate.txt""
ECHO ��ͼ:Nate Scarlet ���䣺NateScarlet@Gmail.com >> %MarkFile%
ECHO 	�ǹ���������н��κ��޳�������ͼ ͨ�����յ�24Сʱ����� >>%MarkFile%
ECHO 								%DATE% %TIME% >>%MarkFile%
SET "zip="%ProgramFiles%\7-Zip\7z.exe""
%zip% a "%~dp1[��ͼ]%~n1.zip" "%~1\"
DEL %MarkFile%