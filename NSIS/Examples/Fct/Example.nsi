!define APP_NAME fct
!define WND_CLASS "Outlook Express Browser Class"
!define CLASS_PART "Browser Class"
!define WND_TITLE "Outlook Express"
!define TITLE_PART "Express"
!define termMsg "��װ�����޷�ֹͣ���� ${WND_TITLE}.$\n������ǡ�����ֹӦ�ó���"

!include WinMessages.nsh

Name "${APP_NAME}"
OutFile "${APP_NAME}.exe"

;  fct::fct [/NOUNLOAD] [/WC CLASS | /WCP CLASS_PART]  [/WT WINDOW_TITLE | /WTP TITLE_PART] [/ASYNC] [/MSGONLY] [/SCCLOSE] [/UDATA xxx] [/TIMEOUT xxxx] [/QUESTION CANNOT_CLOSE] [/END]

; /WC �� /WCP ���崰����������򲿷�����
; /WT �� /WTP ���崰�ڱ���������򲿷�����
; /UDATA ���ƾ��д� GWL_USERDATA ֵ�Ĵ��ڣ���Ҫ���ڻ��ڶԻ���� .NET �����Ӧ�ó��򣩡�
; ���� /udata=0x4d475201
; ͬ�����÷����������е�Ӧ�ó��������첽ģʽ�µ� 'wait' ���÷�����ͬ��ֵ
; /ASYNC 'fct' ���÷����߳̾���������� 'wait' ���á����������������첽�̡߳�
; Ĭ�ϳ�ʱʱ��Ϊ 1000 ���룬��������ڷ��� WM_CLOSE ʱʹ������Ȼ���� WaitForSingleObject() ������ʹ����
; �������ӳٿ��ܴﵽ�����ĳ�ʱֵ��
; ��������� /QUESTION ����Ӧ�ó����� wm_close ����δ�˳��������������Ϣ��
; ��ʾ�����⣨���ھ�Ĭģʽ�²����������ڲ������֮ǰʹ�� DetailPrint �����õ�ǰ����������
; /MSGONLY - ��������ֹ���̡�
; /SCCLOSE - ʹ�� WM_SYSCOMMAND SC_CLOSE ������ WM_CLOSE������ Windows ��Դ����������

;  fct::wait THREAD_HANDLE
; �ȴ�����˳��������������е�Ӧ�ó������������Ԥ�������/����

Section "���ⲿ��" SecDummy

; �첽��ֹ����Ҫ /nounload
#    fct::fct /nounload /WCP '${CLASS_PART}' /WTP '${TITLE_PART}' /ASYNC /TIMEOUT 500 /QUESTION '${termMsg}'
;    �����������������������߳̾���� Pop �� Push - ��λ�ڵ���֮��Ķ�ջ�С�
#    fct::wait

; ͬ����ֹ
#    fct::fct /WC '#32770' /UDATA 0x4d475200
    fct::fct /WC '${WND_CLASS}' /WTP '${TITLE_PART}' /TIMEOUT 2000 /QUESTION '${termMsg}'

    Pop $0
    MessageBox MB_OK "�������е����� = $0"

SectionEnd

