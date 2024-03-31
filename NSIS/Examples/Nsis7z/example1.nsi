Name "nsis7zsample"

; �������ɵĿ�ִ���ļ���Ϊ��nsis7zsample.exe��
OutFile "nsis7zsample.exe"

; ����Ĭ�ϰ�װĿ¼Ϊ��C:\Utils��
InstallDir "C:\Utils"

; ��Windows Vistaϵͳ������Ӧ�ó�����Ȩ
RequestExecutionLevel user

; ��Ӳ��Ŀ¼
!addplugindir "..\Debug"
!addplugindir "."

; �ر�ѹ��������ѹ������
SetCompress off

; ����ص�����
Function CallbackTest
  Pop $R8
  Pop $R9

  SetDetailsPrint textonly
  ; ��ʾ��ȡ����
  DetailPrint "Extracting $R8 / $R9..."
  SetDetailsPrint both
FunctionEnd

; ���ð�װ������
Section ""
  ; ����Ҫ���ҳ�棬���Ʋ���Ҫ
  SetOutPath $INSTDIR
  SetCompress off
  ; ��ʾ��ȡ�ļ�����Ϣ
  DetailPrint "Extracting package..."
  SetDetailsPrint listonly
  ; ���Ҫ��װ���ļ�
  File Test.7z
  SetCompress auto
  SetDetailsPrint both

  ; ͨ��ģʽ-ʹ��DetailPrint���ý�ѹ����ʾ���������ʾ������
  ; DetailPrint "Installing package..."
  ; Nsis7z::Extract "$INSTDIR\Test.7z"

  ; ��ϸģʽ-�ӵڶ����������ɽ�ѹ����ʾ��ʹ�ã�s�����ѹ����ϸ��Ϣ�����硰10����5 / 10 MB����
  ; Nsis7z::ExtractWithDetails "$INSTDIR\Test.7z" "Installing package %s..."

  ; �ص�ģʽ-�������ʾ���������������ڻص�������ִ���κβ���
  GetFunctionAddress $R9 CallbackTest
  Nsis7z::ExtractWithCallback "$INSTDIR\Test.7z" $R9

  ; ɾ����װ�ļ����е��ļ�
  Delete "$OUTDIR\Test.7z"
SectionEnd ; ���ν���

